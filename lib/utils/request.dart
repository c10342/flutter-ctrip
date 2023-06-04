import 'package:dio/dio.dart';

//封装请求

class Request {
  final _dio = Dio();

  Future<dynamic> get(String url) async {
    final response = await _dio.get(url);
    return response.data;
    // if (response.statusCode == 200) {
    //   //fix 中文乱码
    //   Utf8Decoder utf8decoder = const Utf8Decoder();
    //   final result = json.decode(utf8decoder.convert(response.bodyBytes));
    //   // 返回模型
    //   return result;
    // } else {
    //   throw Exception('请求失败');
    // }
  }

  Future<dynamic> post(String url, {data: Map}) async {
    final response = await _dio.post(url,data: data);
    return response.data;
  }
}

Request request = Request();
