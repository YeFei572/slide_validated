import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {


  @override
  void initState() {
    debugPrint('------初始化消息页面init方法------');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('------构建消息页面------');
    return const Scaffold(
      body: Center(child: Text('消息模块')),
    );
  }
}
