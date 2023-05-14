import 'package:flutter/material.dart';
import 'package:flutter_study/components/webview.dart';
import 'package:flutter_study/model/common_model.dart';
import 'package:flutter_study/model/sales_box_model.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel? salesBox;

  const SalesBox({super.key, this.salesBox});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(6)),
          child: Column(
            children: [
              _title(context),
              _rowCard(context, salesBox?.bigCard1, salesBox?.bigCard2, true),
              _rowCard(
                  context, salesBox?.smallCard1, salesBox?.smallCard2, false),
              _rowCard(
                  context, salesBox?.smallCard3, salesBox?.smallCard4, false)
            ],
          )),
    );
  }

  Widget _title(BuildContext context) {
    if (salesBox == null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            salesBox?.icon ?? '',
            height: 15,
            fit: BoxFit.fill,
          ),
          GestureDetector(
            onTap: () {
              _onTap(context, salesBox?.moreUrl ?? '', '');
            },
            child: Container(
              padding: EdgeInsets.only(top: 4, left: 6, right: 6, bottom: 4),
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(colors: [
                    Color(0xffff4e63),
                    Color(0xffff6cc9),
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
              child: Text(
                '获取更多福利 >',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _rowCard(BuildContext context, CommonModel? model1,
      CommonModel? model2, bool isBig) {
    if (model1 == null || model2 == null) {
      return Container();
    }
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
      child: Row(
        children: [
          _card(context, model1, isBig, false),
          _card(context, model2, isBig, true),
        ],
      ),
    );
  }

  Widget _card(
      BuildContext context, CommonModel? model, bool isBig, bool isRight) {
    if (model == null) {
      return Container();
    }
    BorderSide borderSize =
        const BorderSide(width: 1, color: Color(0xfff2f2f2));
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            _onTap(context, model.url ?? '', model.title ?? '');
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    left: borderSize,
                    right: isRight ? borderSize : BorderSide.none)),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Image.network(
                model.icon ?? '',
                fit: BoxFit.fill,
                // MediaQuery.of(context).size.width获取屏幕的宽度
                // width: MediaQuery.of(context).size.width / 2 - 10,
                height: isBig ? 129 : 80,
              ),
            ),
          ),
        ));
  }

  void _onTap(BuildContext context, String url, String title) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext buildContext) {
      return WebView(
        url: url,
        title: title,
      );
    }));
  }
}
