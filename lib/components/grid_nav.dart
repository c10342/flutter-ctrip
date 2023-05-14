import 'package:flutter/material.dart';
import 'package:flutter_study/components/webview.dart';
import 'package:flutter_study/model/common_model.dart';
import 'package:flutter_study/model/grid_nav_model.dart';

//无状态组件
class GridNav extends StatelessWidget {
  GridNavModel? gridNavList;

  GridNav({super.key, this.gridNavList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _gridNavItems(context),
    );
  }

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNavList?.hotel));
    items.add(_gridNavItem(context, gridNavList?.flight));
    items.add(_gridNavItem(context, gridNavList?.travel));
    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem? model) {
    if (model == null) {
      return null;
    }
    Color startColor = Color(int.parse('0xff${model.startColor!}'));
    Color endColor = Color(int.parse('0xff${model.endColor!}'));
    // PhysicalModel可以很快捷的设置圆角，Container不行，因为有图层遮挡
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        // 裁剪
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
//          设置渐变色
              gradient: LinearGradient(colors: [startColor, endColor])),
          child: Row(
            children: [
              _mainItem(context, model.mainItem),
              // Expanded要结合Row或者Column一起使用
              Expanded(
                  child: Column(
                children: [
                  _rowSubItem(context, model.item1, model.item2, true),
                  _rowSubItem(context, model.item3, model.item4, false),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  _rowSubItem(BuildContext context, CommonModel? model1, CommonModel? model2,
      bool bottomBorder) {
    return Row(
      children: [
        Expanded(child: _subItem(context, model1, bottomBorder)),
        Expanded(child: _subItem(context, model2, bottomBorder)),
      ],
    );
  }

  _mainItem(BuildContext context, CommonModel? model) {
    if (model == null) {
      return null;
    }
    return _gestureDetector(
      context,
      model,
      Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Image.network(
            model.icon ?? '',
            fit: BoxFit.contain,
            height: 88,
            width: 121,
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              model.title ?? '',
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  _subItem(BuildContext context, CommonModel? model, bool bottomBorder) {
    if (model == null) {
      return null;
    }
    return _gestureDetector(
        context,
        model,
        FractionallySizedBox(
          // 水平占满
          widthFactor: 1,
          child: Container(
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: const BorderSide(color: Colors.white, width: 1),
                    bottom: BorderSide(
                        color: Colors.white, width: bottomBorder ? 1 : 0))),
            child: Center(
              child: Text(
                model.title ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ));
  }

  _gestureDetector(BuildContext context, CommonModel model, Widget data) {
    return GestureDetector(
      child: data,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext builder) {
          return WebView(url: model.url ?? '', title: model.title ?? '');
        }));
      },
    );
  }
}
