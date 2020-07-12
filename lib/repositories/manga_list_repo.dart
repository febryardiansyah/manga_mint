import 'dart:convert';

import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/manga_list_model.dart';
import 'package:mangamint/service/api_service.dart';

class MangaListRepo{
  Future <List<MangaListModel>> getMangaList({int page})async{
    final response = await ApiService.api.get(BaseUrl+'manga/page/$page');
    if(response.statusCode == 200){
      var data = json.decode(response.body);
      final List<MangaListModel> list = MangaModel.fromJson(data).mangaList;
      print(list.last.title);
      print(page);
      return list;
    }
  }
}