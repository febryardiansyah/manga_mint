import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/popular_model.dart';
import 'package:mangamint/service/api_service.dart';
import 'package:mangamint/service/base_service.dart';

class PopularRepo extends BaseService{
  Future<List<PopularModel>>getPopular({int page})async{
    Response response = await request(url: 'manga/popular/$page');
    final List<PopularModel> res = List<PopularModel>.from(response.data['manga_list'].map((json)=>PopularModel.fromJson(json)));
    return res;
//    final response = await ApiService.api.get(BaseUrl+'manga/popular/$page');
//    if(response.statusCode == 200){
//      var res = json.decode(response.body)['manga_list'];
//      List<PopularModel> list = List<PopularModel>.from(res.map((json) => PopularModel.fromJson(json)));
//      print(page);
//      print(list[0].title);
//      return list;
//    }else{
//      throw Exception('Failed Fetch');
//    }
  }
}