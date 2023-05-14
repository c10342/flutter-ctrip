
import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget{
  const TravelPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TravelPage();
  }

}


class _TravelPage extends State<TravelPage>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Center居中组件，只能有一个子节点
      body: Center(
        child: Text('旅拍'),
      ),
    );
  }

}