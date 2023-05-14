import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_study/components/grid_nav.dart';
import 'package:flutter_study/components/home_search_bar.dart';
import 'package:flutter_study/components/loading_container.dart';
import 'package:flutter_study/components/local_nav.dart';
import 'package:flutter_study/components/sales_box.dart';
import 'package:flutter_study/components/sub_nav.dart';
import 'package:flutter_study/dao/home_dao.dart';
import 'package:flutter_study/model/common_model.dart';
import 'package:flutter_study/model/grid_nav_model.dart';
import 'package:flutter_study/model/home_model.dart';
import 'package:flutter_study/model/sales_box_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
//  轮播图列表
  List<CommonModel> _bannerList = [];

//  顶部bar的透明度
  double _appbarOpacity = 0;

  List<CommonModel> _localNavList = [];

  GridNavModel? _gridNavList;

  List<CommonModel> _subNavList = [];

  SalesBoxModel? _salesBox;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<HomeModel?> _loadData() async {
    try {
      HomeModel res = await HomeDao.fetch();
      setState(() {
        _localNavList = res.localNavList ?? [];
        _bannerList = res.bannerList ?? [];
        _gridNavList = res.gridNav;
        _subNavList = res.subNavList ?? [];
        _salesBox = res.salesBox;
        _loading = false;
      });
      return res;
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      //   ListView默认会有个边距，需要使用MediaQuery.removePadding移除
      body: LoadingContainer(
        loading: _loading,
        child: _body(),
        cover: true,
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        MediaQuery.removePadding(
          // 移除上边距
          removeTop: true,
          context: context,
          // RefreshIndicator实现下拉刷新
          child: RefreshIndicator(
              onRefresh: _loadData,
              // NotificationListener监听ListView列表滚动
              child: NotificationListener(
                  onNotification: _onNotification, child: _listView())),
        ),
        _headerBar()
      ],
    );
  }

  Widget _listView() {
    return ListView(
      children: [
        _swiperBanner(),
        LocalNav(localNavList: _localNavList),
        GridNav(gridNavList: _gridNavList),
        SubNav(subNavList: _subNavList),
        SalesBox(
          salesBox: _salesBox,
        )
      ],
    );
  }

  _swiperBanner() {
    return SizedBox(
      height: 160,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            _bannerList[index].icon ?? '',
            fit: BoxFit.fill,
          );
        },
        itemCount: _bannerList.length,
        pagination: const SwiperPagination(),
        // control:  SwiperControl(),
        autoplay: true,
      ),
    );
  }

  _headerBar() {
    // Opacity设置组件的透明度
    // return Opacity(
    //   opacity: _appbarOpacity,
    //   child: Container(
    //       height: 80,
    //       padding: EdgeInsets.only(top: 20),
    //       decoration: const BoxDecoration(color: Colors.white),
    //       child: const Center(
    //         child: Text('首页'),
    //       )),
    // );
    return HomeSearchBar(appBarAlpha: _appbarOpacity,);
  }

//  监听列表滚动事件
  bool _onNotification(Notification notification) {
    // notification是ScrollUpdateNotification实例对象
    // 第一次进来的时候也会处罚onNotification，所以要判断notification is ScrollUpdateNotification
    if (notification is ScrollUpdateNotification && notification.depth == 0) {
      // onNotification会监听到深层的事件，导致轮播图滚动的时候也会触发这个函数
      // 所以需要添加一个notification.depth==0，只监听第一层元素
      _onScroll(notification.metrics.pixels);
    }
    /// Return true to cancel the notification bubbling. Return false to
    /// allow the notification to continue to be dispatched to further ancestors
    /// return true 会导致RefreshIndicator下拉刷新不生效
    return false;
  }

  void _onScroll(double offset) {
    // 根据滚动的距离计算透明度
    double opacity = offset / 100;
    if (opacity < 0) {
      opacity = 0;
    } else if (opacity > 1) {
      opacity = 1;
    }
    setState(() {
      _appbarOpacity = opacity;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
