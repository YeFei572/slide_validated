import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  @override
  void initState() {
    debugPrint('------初始化我的页面init方法------');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('------构建我的页面------');
    return const Scaffold(
      body: Center(
        child: Text('我的'),
      ),
    );
  }
}
