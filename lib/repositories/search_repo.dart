import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/search_model.dart';
import 'package:mangamint/service/api_service.dart';
import 'package:mangamint/service/base_service.dart';

class SearchRepo extends BaseService{
  Future<List<SearchModel>>searchManga({String query})async{
    final Response response = await request(url:'cari/$query');
    List<SearchModel> list = List<SearchModel>.from(response.data.map((json) => SearchModel.fromJson(json)));
    return list;
//    final response = await ApiService.api.get(BaseUrl+'cari/$query');
//    if(response.statusCode == 200){
//      print(response.body);
//      var res = json.decode(response.body);
//      List<SearchModel> list = List<SearchModel>.from(res.map((json) => SearchModel.fromJson(json)));
//      print(list[0].type);
//      return list;
//    }
  }
}