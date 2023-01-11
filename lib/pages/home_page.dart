import 'package:demo04/captcha/block_puzzle_captcha.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    debugPrint('------初始化首页init方法------');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('------构建首页页面------');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: submit,
              child: const Text("点击提交"),
            ),
            ElevatedButton(
              onPressed: () async {
                await launchUrl(Uri(scheme: 'faxian1'));
              },
              child: const Text("点击提交"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> submit() async {
    showToast('测试滑动校验功能', backgroundColor: Colors.black87);
    showDialog(
      context: context,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: BlockPuzzleCaptchaPage(onSuccess: (v) {
            showToast('滑动成功！$v', backgroundColor: Colors.green);
          }, onFail: () {
            showToast('滑动失败！', backgroundColor: Colors.red);
          }),
        );
      },
    );
  }
}
