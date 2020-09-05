import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/manga_list_model.dart';
import 'package:mangamint/service/api_service.dart';
import 'package:mangamint/service/base_service.dart';

class MangaListRepo extends BaseService{
  Future <List<MangaListModel>> getMangaList({int page})async{
    Response response = await request(url:BaseUrl+'manga/page/$page');
    final List<MangaListModel> list = MangaModel.fromJson(response.data).mangaList;
    return list;
  }
}