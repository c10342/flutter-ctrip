import 'package:flutter/material.dart';
import 'package:flutter_study/components/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Center居中组件，只能有一个子节点
        body: Stack(
      children: [
        SearchBar(
          placeholder: '请输入',
        )
      ],
    ));
  }
}
