

import 'package:flutter_study/model/search_model.dart';
import 'package:flutter_study/utils/request.dart';

///搜索接口
class SearchDao {
  static Future<SearchModel> fetch(String url) async {
    final result = await request.get(url);
    return SearchModel.fromJson(result);
  }
}
