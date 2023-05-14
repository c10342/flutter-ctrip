//底部导航组件

import 'package:flutter/material.dart';
import 'package:flutter_study/pages/home_page.dart';
import 'package:flutter_study/pages/my_page.dart';
import 'package:flutter_study/pages/search_page.dart';
import 'package:flutter_study/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabNavigator();
  }
}

class _TabNavigator extends State<TabNavigator> {
  // 当前激活的是那个页面
  int _currentIndex = 0;
  final PageController _controller = PageController(
      // 默认显示第几个页面
      initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // Scaffold是一个可以快速搭建一个页面骨架的组件
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: const [
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
      ),
      // 底部导航
      bottomNavigationBar:_bottomNavigationBar(),
    );
  }

  _onBottomNavigationBarClick(index){
    // 跳转到指定的PageView的页面
    _controller.jumpToPage(index);
    setState(() {
      // 记录现在是那一页
      _currentIndex = index;
    });
  }

  _bottomNavigationBar(){
    return  BottomNavigationBar(
      // 当前选中的是哪一个
      currentIndex: _currentIndex,
      // 点击事件
      onTap: _onBottomNavigationBarClick,
      // 选中的颜色
      selectedItemColor: Colors.blue,
      // 未选中的颜色
      unselectedItemColor: Colors.grey,
      // 固定label在底部，默认情况下，只有选中了才显示label
      type: BottomNavigationBarType.fixed,
      items: [
        _bottomItem('首页', Icons.home),
        _bottomItem('搜索', Icons.search),
        _bottomItem('旅拍', Icons.camera_alt),
        _bottomItem('我的', Icons.account_circle),
      ],
    );
  }

  _bottomItem(String title, IconData icon) {
    return BottomNavigationBarItem(
        // 非激活状态图标
        icon: Icon(icon),
        // 激活状态图标
        activeIcon: Icon(icon),
        // 文本
        label: title);
  }
}
