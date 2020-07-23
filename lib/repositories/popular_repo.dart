import 'dart:convert';

import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/popular_model.dart';
import 'package:mangamint/service/api_service.dart';

class PopularRepo{
  Future<List<PopularModel>>getPopular({int page})async{
    final response = await ApiService.api.get(BaseUrl+'manga/popular/$page');
    if(response.statusCode == 200){
      var res = json.decode(response.body)['manga_list'];
      List<PopularModel> list = List<PopularModel>.from(res.map((json) => PopularModel.fromJson(json)));
      print(page);
      print(list[0].title);
      return list;
    }else{
      throw Exception('Failed Fetch');
    }
  }
}