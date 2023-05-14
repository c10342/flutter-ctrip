import 'package:flutter_study/model/common_model.dart';
import 'package:flutter_study/model/config_model.dart';
import 'package:flutter_study/model/grid_nav_model.dart';
import 'package:flutter_study/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel? config;

  final List<CommonModel>? bannerList;

  final List<CommonModel>? localNavList;

  final List<CommonModel>? subNavList;

  final GridNavModel? gridNav;

  final SalesBoxModel? salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.subNavList,
      this.gridNav,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    // 数组要特殊处理一下
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
      localNavList: localNavList,
      bannerList: bannerList,
      subNavList: subNavList,
      config: ConfigModel.fromJson(json['config']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localNavList': localNavList,
      'bannerList': bannerList,
      'subNavList': subNavList,
      'config': config,
      'gridNav': gridNav,
      'salesBox': salesBox,
    };
  }
}
