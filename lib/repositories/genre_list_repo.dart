import 'dart:convert';

import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/genre_list_model.dart';
import 'package:mangamint/service/api_service.dart';

class GenreListRepo {
  Future<List<GeneListModel>>getGenreList()async{
    final response = await ApiService.api.get(BaseUrl+'genres');
    if (response.statusCode == 200) {
      var res = json.decode(response.body)['list_genre'];
      List<GeneListModel>list = List<GeneListModel>.from(res.map((item) => GeneListModel.fromMap(item)));
      return list;
    }else{
      throw Exception('Failed Fetch');
    }
  }
}

class MangaByGenreRepo{
  Future<List<MangaByGenreModel>>getManga({String genre,int page})async{
    final response = await ApiService.api.get(BaseUrl+'genres/$genre$page');
    if (response.statusCode == 200) {
      var res = json.decode(response.body)['manga_list'];
      List<MangaByGenreModel>list = List<MangaByGenreModel>.from(res.map((item) => MangaByGenreModel.fromJson(item)));
      print(page);
      return list;
    }else{
      throw Exception('Failed Fetch');
    }
  }
}
