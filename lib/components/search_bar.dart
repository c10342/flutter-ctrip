import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
//  是否隐藏左侧返回箭头
  bool hideLeft;

//  输入框placeholder
  String placeholder;

//  输入框默认值
  String defaultValue;

  // 点击语音图标回调函数
  void Function()? speakClick;

//  点击搜索按钮回调函数
  void Function(String val)? onSearch;

//  文本发生变化
  ValueChanged<String>? onChanged;

  SearchBar({super.key,
    this.hideLeft = true,
    this.placeholder = '',
    this.defaultValue = '',
    this.speakClick,
    this.onSearch,
    this.onChanged});

  @override
  State<StatefulWidget> createState() {
    return _SearchBar();
  }
}

class _SearchBar extends State<SearchBar> {

  bool showClear = false;

  final TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    setState(() {
      _controller.text = widget.defaultValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 30,
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: getChildren(),
      ),
    );
  }

  List<Widget> getChildren() {
    List<Widget> list = [];
    if (widget.hideLeft != true) {
      list.add(GestureDetector(
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.grey,
        ),
      ));
    }
    list.add(getInput());
    list.add(getSearchText());
    return list;
  }

  Widget getInput() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        height: 30,
        margin: EdgeInsets.only(right: 5, left: widget.hideLeft ? 0 : 5),
        decoration: BoxDecoration(
            color: Color(int.parse('0xffEDEDED')),
            borderRadius: BorderRadius.circular(5)),
        child: Row(children: [
          const Icon(
            Icons.search,
            size: 20,
            color: Colors.grey,
          ),
          Expanded(
              flex: 1,
              child: TextField(
                autofocus: true,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
                // 输入文本的样式
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    // 去掉输入框底部线，修复设置了contentPadding后输入框内容不能垂直居中
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 0, color: Colors.transparent)),
                    disabledBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 0, color: Colors.transparent)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 0, color: Colors.transparent)),
                    border: InputBorder.none,
                    hintText: widget.placeholder,
                    hintStyle: const TextStyle(fontSize: 15)),
                controller: _controller,
                onChanged: _onChanged,
              )),
          showClear
              ? GestureDetector(
            onTap: () {
              setState(() {
                // 清空文本内容
                _controller.clear();
              });
              _onChanged('');
            },
            child: const Icon(
              Icons.clear,
              size: 22,
              color: Colors.grey,
            ),
          )
              : GestureDetector(
            onTap: () {
              if (widget.speakClick != null) {
                widget.speakClick!();
              }
            },
            child: const Icon(Icons.mic, size: 22, color: Colors.blue),
          )
        ]),
      ),
    );
  }

//  输入框文本发生变化
  _onChanged(String text) {
    setState(() {
      showClear = text.isNotEmpty;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  Widget getSearchText() {
    return GestureDetector(
      onTap: () {
        if (widget.onSearch != null) {
          widget.onSearch!(_controller.text);
        }
      },
      child: Text('搜索', style: TextStyle(fontSize: 16, color: Colors.blue)),
    );
  }
}
