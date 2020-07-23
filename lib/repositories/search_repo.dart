import 'dart:convert';

import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/search_model.dart';
import 'package:mangamint/service/api_service.dart';

class SearchRepo{
  Future<List<SearchModel>>searchManga({String query})async{
    final response = await ApiService.api.get(BaseUrl+'cari/$query');
    if(response.statusCode == 200){
      print(response.body);
      var res = json.decode(response.body);
      List<SearchModel> list = List<SearchModel>.from(res.map((json) => SearchModel.fromJson(json)));
      print(list[0].type);
      return list;
    }
  }
}