import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_study/components/webview.dart';
import 'package:flutter_study/model/common_model.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({super.key, required this.localNavList});
  // padding: const EdgeInsets.fromLTRB(7, 4, 7, 4)
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70,
      decoration: const BoxDecoration(
          // 设置背景色
          color: Colors.white,
          // 设置圆角
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(7, 10, 7, 10),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    for (var model in localNavList) {
      items.add(_item(context, model));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    // 可点击
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(url: model.url ?? '', title: model.title ?? '');
        }));
      },
      child: Column(
        children: [
          Image.network(
            model.icon ?? '',
            width: 32,
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              model.title ?? '',
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
