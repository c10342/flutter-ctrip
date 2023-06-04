import 'package:flutter/material.dart';
import 'package:flutter_study/pages/search_page.dart';
import 'package:flutter_study/pages/speak_page.dart';

double iconSize = 20;

class HomeSearchBar extends StatelessWidget {
  double appBarAlpha;

  HomeSearchBar({super.key, required this.appBarAlpha});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext builder) {
          return SearchPage(
            hideLeft: false,
          );
        }));
      },
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              // 设置背景根据滚动的距离进行变化
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            padding: EdgeInsets.fromLTRB(5, 16, 5, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      '上海',
                      style: TextStyle(fontSize: 18, color: getIconColor()),
                    ),
                    Icon(Icons.expand_more,
                        size: iconSize, color: getIconColor())
                  ],
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 30,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          color: appBarAlpha > 0.2
                              ? Color(int.parse('0xffEDEDED'))
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: iconSize,
                            color: Colors.blue,
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(
                                '请输入',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              )),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                return SpeakPage();
                              }));
                            },
                            child: Icon(
                              Icons.mic,
                              size: iconSize,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )),
                Icon(Icons.comment, size: iconSize, color: getIconColor())
              ],
            ),
          ),
          // 实现阴影效果
          Container(
              height: appBarAlpha > 0.2 ? 0.5 : 0,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 0.5)
              ]))
        ],
      ),
    );
  }

  Color getIconColor() {
    return appBarAlpha > 0.2 ? Colors.grey : Colors.white;
  }
}
