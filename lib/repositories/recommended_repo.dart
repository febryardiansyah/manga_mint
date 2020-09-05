import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/recomended_model.dart';
import 'package:mangamint/service/api_service.dart';
import 'package:mangamint/service/base_service.dart';

class RecommendedRepo extends BaseService{
  Future<List<RecommendedList>>getRecomended()async{
    Response response = await request(url: 'recommended');
    List<RecommendedList> res = RecommendedModel.fromJson(response.data).recommendedList;
    return res;
  }
}