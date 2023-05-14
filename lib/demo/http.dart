import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpPage extends StatefulWidget {
  const HttpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HttpPage();
  }
}

class _HttpPage extends State<HttpPage> {
  String _showResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('http')),
      body: Column(
        children: [
          InkWell(
              onTap: _onTap,
              child: const Text('点击发送请求', style: TextStyle(fontSize: 20))),
          Text(_showResult)
        ],
      ),
    );
  }

  void _onTap() {
    fetchGet().then((_CommonModel value) {
      setState(() {
        // _showResult = '请求结果，title:${value.title},url:${value.url},${value.toString()}';
        // 使用value.toString()或者jsonEncode(value),CommonModel必须要有toJson方法，否则报错
        // 对象转字符串
        _showResult = jsonEncode(value);
      });
    });
  }

  // 发送网络请求
  Future<_CommonModel> fetchGet() async {
    // 构造url，第一个参数是域名，第二个参数是请求路径
    Uri url = Uri.https(
        'www.devio.org', 'io/flutter_app/json/test_common_model.json');
    final response = await http.get(url);
    // 解析body
    // final result = json.decode(response.body);
    //fix 中文乱码
    Utf8Decoder utf8decoder = const Utf8Decoder();
    final result = json.decode(utf8decoder.convert(response.bodyBytes));
    // 返回模型
    return _CommonModel.fromJson(result);
  }
}

//创建一个CommonModel类，它包含我们网络请求的数据。它还将包括一个工厂构造函数，它允许我们可以通过json创建一个CommonModel对象
class _CommonModel {
//  定义模型有哪些属性
//   ? -> null
  String? icon;
  String? title;
  String? url;
//构造函数
  _CommonModel({this.icon, this.title, this.url});

  // 序列化为字符串的时候必须要有toJson函数
  Map toJson() {
    Map map = {};
    map["icon"] = icon;
    map["title"] = title;
    map["url"] = url;
    return map;
  }

//创建模型
  factory _CommonModel.fromJson(Map<String, dynamic> json) {
    return _CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
    );
  }
}
