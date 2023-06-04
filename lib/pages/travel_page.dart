import 'package:flutter/material.dart';
import 'package:flutter_study/dao/travel_tab_dao.dart';
import 'package:flutter_study/model/travel_model.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TravelPage();
  }
}

class _TravelPage extends State<TravelPage> with TickerProviderStateMixin {
//  顶部的tabbar
  List<TravelTab> tabs = [];

  TravelTabModel? travelTabModel;

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    TravelTabDao.fetch().then((value) {
      setState(() {
        tabs = value.tabs;
        travelTabModel = value;
        //fix tab label 空白问题
        _controller = TabController(length: tabs.length, vsync: this);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Center居中组件，只能有一个子节点
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
                controller: _controller,
                // 多个标签时滚动加载
                isScrollable: true,
                // 标签指示器的颜色
                indicatorColor: Colors.blue,
                // 标签的颜色
                labelColor: Colors.black,
                // 未选中标签的颜色
                unselectedLabelColor: Colors.black,
                // 指示器的大小
                indicatorSize: TabBarIndicatorSize.label,
                // 指示器的权重，即线条高度
                indicatorWeight: 4.0,
                tabs: tabs.map((e) => Tab(text: e.labelName ?? '')).toList()),
          ),
          // Flexible组件可以使Row、Column、Flex等子组件在主轴方向有填充可用空间的能力，但是不强制子组件填充可用空间。
          // Expanded组件可以使Row、Column、Flex等子组件在其主轴方向上展开并填充可用空间，是强制子组件填充可用空间。
          // TabBarView需要明确一个高度
          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: tabs.map((e) => Text(e.labelName ?? '')).toList()))
        ],
      ),
    );
  }
}
