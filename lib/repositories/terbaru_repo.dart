import 'dart:convert';

import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/popular_terbaru_model.dart';
import 'package:mangamint/service/api_service.dart';

class TerbaruRepo{
  Future<List<PopularTerbaruModel>>getTerbaru({int page})async{
    final response = await ApiService.api.get(BaseUrl+'manga/terbaru/$page');
    if(response.statusCode == 200){
      var res = json.decode(response.body)['manga_list'];
      List<PopularTerbaruModel>list = List<PopularTerbaruModel>.from(res.map((json) => PopularTerbaruModel.fromJson(json)));
      print(list[0].title +' terbaru');
      print(page);
      return list;
    }else{
      throw Exception('failed Fetch');
    }
  }
}