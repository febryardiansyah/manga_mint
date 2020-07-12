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