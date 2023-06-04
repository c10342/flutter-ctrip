import 'dart:async';

import 'package:flutter_study/model/travel_model.dart';
import 'package:flutter_study/utils/request.dart';

///旅拍类别接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final result = await request
        .get('http://www.devio.org/io/flutter_app/json/travel_page.json');
    return TravelTabModel.fromJson(result);
  }
}
