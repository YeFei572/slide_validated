import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({Key? key}) : super(key: key);

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage>
    with AutomaticKeepAliveClientMixin {
  final InAppLocalhostServer localhostServer = InAppLocalhostServer();

  @override
  void initState() {
    debugPrint('------初始化动态页面init方法------');
    initWebServe();
    super.initState();
  }

  Future<void> initWebServe() async {
    await localhostServer.start();
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint('------构建动态页面------');
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse("http://localhost:8080/assets/dist/index.html"),
              ),
              onWebViewCreated: (controller) {
                controller.addJavaScriptHandler(handlerName: 'test01', callback: (args) {
                  debugPrint(args[0].toString());
                  return "123";
                });
              },
              onLoadStart: (controller, url) {},
              onLoadStop: (controller, url) async {
                await controller.evaluateJavascript(source:"""
                  const args = 11111;
                  window.flutter_inappwebview.callHandler('fromFlutter', ...args);
                """
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
