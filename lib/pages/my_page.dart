
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget{
  const MyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyPage();
  }

}


class _MyPage extends State<MyPage>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Center居中组件，只能有一个子节点
      body: Center(
        child: Text('我的'),
      ),
    );
  }

}