import 'package:flutter/material.dart';
import 'package:flutter_study/components/webview.dart';
import 'package:flutter_study/model/common_model.dart';

class SubNav extends StatelessWidget {
  List<CommonModel> subNavList = [];

  SubNav({super.key, required this.subNavList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.white),
        child: _rowItems(context),
      ),
    );
  }

  _rowItems(BuildContext context) {
    // 计算出一行显示多少
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: [
        _items(context, subNavList.sublist(0, separate)),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child:
              _items(context, subNavList.sublist(separate, subNavList.length)),
        )
      ],
    );
  }

  _items(BuildContext context, List<CommonModel> list) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: list.map((e) => _item(context, e)).toList(),
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
      // 均分
        flex: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext builder) {
              return WebView(url: model.url ?? '', title: model.title ?? '');
            }));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                model.icon ?? '',
                fit: BoxFit.fill,
                width: 20,
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  model.title ?? '',
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              )
            ],
          ),
        ));
  }
}
