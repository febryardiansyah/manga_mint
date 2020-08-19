import 'dart:convert';

import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/recomended_model.dart';
import 'package:mangamint/service/api_service.dart';

class RecommendedRepo{
  Future<List<RecommendedList>>getRecomended()async{
    final response = await ApiService.api.get(BaseUrl+'recommended');
    if(response.statusCode == 200){
      var res = json.decode(response.body);
      List<RecommendedList>recommendedList = RecommendedModel.fromJson(res).recommendedList;
      print(recommendedList[0].thumb);
      return recommendedList;
    }else{
      throw Exception('Failed Fetch');
    }
  }
}