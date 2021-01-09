import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/manga_detail_model.dart';
import 'package:mangamint/service/api_service.dart';
import 'package:mangamint/service/base_service.dart';

class MangaDetailRepo extends BaseService{
  Future<MangaDetailModel>getMangaDetail(String endpoint)async{
    final Response response = await request(url: 'manga/detail/$endpoint');
    final MangaDetailModel data = MangaDetailModel.fromJson(response.data);
    print(response.data);
    return data;
//    final response = await ApiService.api.get(BaseUrl+'manga/detail/$endpoint');
//
//    if(response.statusCode == 200){
//      final res = json.decode(response.body);
//      final MangaDetailModel data = MangaDetailModel.fromJson(res);
//      print(data.chapterList[0].chapter_title);
//      return data;
//    }
  }
}