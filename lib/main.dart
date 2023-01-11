import 'dart:async';
import 'dart:io';

import 'package:demo04/captcha/block_puzzle_captcha.dart';
import 'package:demo04/pages/action_page.dart';
import 'package:demo04/pages/home_page.dart';
import 'package:demo04/pages/message_page.dart';
import 'package:demo04/pages/mine_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  if (Platform.isAndroid) {
    /// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //这个是状态栏的颜色根据自己的需要自己更改
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      textStyle: const TextStyle(fontSize: 19.0, color: Colors.white),
      backgroundColor: Colors.grey,
      animationCurve: Curves.easeIn,
      animationBuilder: const Miui10AnimBuilder(),
      animationDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 3),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  late PreloadPageController _controller;

  List<Widget> pages = const [
    HomePage(),
    ActionPage(),
    MessagePage(),
    MinePage(),
  ];

  List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
      activeIcon: Icon(Icons.home_filled),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.email_outlined),
      label: '动态',
      activeIcon: Icon(Icons.email),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.messenger_outline),
      label: '消息',
      activeIcon: Icon(Icons.message),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: '我的',
      activeIcon: Icon(Icons.person),
    ),
  ];

  @override
  void initState() {
    _controller = PreloadPageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
          _controller.jumpToPage(index);
        },
      ),
      body: PreloadPageView.builder(
        controller: _controller,
        itemBuilder: (_, index) => pages[index],
        itemCount: pages.length,
        physics: const NeverScrollableScrollPhysics(),
        preloadPagesCount: 0,
      ),
    );
  }
}
