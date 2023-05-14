

import 'dart:convert';

import 'package:http/http.dart' as http;

//封装请求

class Request{
  final String _baseUrl;

  Request(this._baseUrl);

  Future<dynamic> get(String url) async {
    Uri uri = Uri.http(_baseUrl,url);
    final response = await http.get(uri);
    if(response.statusCode==200){
      //fix 中文乱码
      Utf8Decoder utf8decoder = const Utf8Decoder();
      final result = json.decode(utf8decoder.convert(response.bodyBytes));
      // 返回模型
      return result;
    }else{
      throw Exception('请求失败');
    }

  }
}

Request request = Request('www.devio.org');
