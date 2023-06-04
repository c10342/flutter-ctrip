import 'package:flutter/material.dart';
import 'package:flutter_study/components/search_bar.dart';
import 'package:flutter_study/components/webview.dart';
import 'package:flutter_study/dao/search_dao.dart';
import 'package:flutter_study/model/search_model.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

const URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String placeholder;

  const SearchPage(
      {super.key,
      this.hideLeft = true,
      this.searchUrl = URL,
      this.keyword = '',
      this.placeholder = '请输入'});

  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  SearchModel? searchModel;

  String searchKey = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Center居中组件，只能有一个子节点
        body: Column(
      children: [
        _appBar(),
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: searchModel?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return _item(index);
                  })),
        )
      ],
    ));
  }

  _appBar() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        //AppBar渐变遮罩背景
        colors: [Color(0x66000000), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: SearchBar(
        placeholder: widget.placeholder,
        hideLeft: widget.hideLeft,
        onChanged: _onSearchTextChange,
      ),
    );
  }

  void _onSearchTextChange(String text) {
    if (text.isEmpty) {
      // 输入框内容为空
      setState(() {
        searchKey = '';
        searchModel = null;
      });
      return;
    }

    String url = widget.searchUrl + text;
    SearchDao.fetch(url).then((value) {
      setState(() {
        searchKey = text;
        searchModel = value;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Widget _item(int index) {
    if (searchModel == null || searchModel?.data == null) {
      return Container();
    }
    SearchItem searchItem = searchModel!.data![index];
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext builder) {
          return WebView(
              url: searchItem.url ?? '', title: searchItem.word ?? '');
        }));
      },
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Image(
                  image: AssetImage(_typeImage(searchItem.type)),
                  width: 26,
                  height: 26,
                ),
              ),
              // Image.asset('images/type_travelgroup.png',width: 26,height: 26,),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: Container(
                          child: _title(searchItem),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          child: _subTitle(searchItem),
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }

  String _typeImage(String? type) {
    if (type == null) {
      return 'images/type_travelgroup.png';
    }
    String path = 'travelgroup';
    for (final val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  _title(SearchItem searchItem) {
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(searchItem.word, searchKey));
    spans.add(TextSpan(
        text: ' ' +
            (searchItem.districtname ?? '') +
            ' ' +
            (searchItem.zonename ?? ''),
        style: TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  _subTitle(SearchItem searchItem) {
    // 展示富文本
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: (searchItem.price ?? '') + ' ',
          style: TextStyle(fontSize: 16, color: Colors.orange)),
      TextSpan(
          text: ' ' + (searchItem.star ?? ''),
          style: TextStyle(fontSize: 12, color: Colors.grey))
    ]));
  }

  Iterable<TextSpan> _keywordTextSpans(String? word, String searchKey) {
    // 搜索关键字要高亮
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) {
      return spans;
    }
    // 分割字符
    List<String> arr = word.split(searchKey);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    //'wordwoc'.split('w') -> [, ord, oc] @https://www.tutorialspoint.com/tpcg.php?p=wcpcUA
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        // 根据上面分解的示例，2的倍数要添加关键字
        spans.add(TextSpan(text: searchKey, style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
