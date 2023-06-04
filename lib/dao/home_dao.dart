
import 'package:flutter_study/model/home_model.dart';
import 'package:flutter_study/utils/request.dart';


String url = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao{
  static Future<HomeModel> fetch() async{
    final result = await request.get(url);
    return HomeModel.fromJson(result);
  }
}