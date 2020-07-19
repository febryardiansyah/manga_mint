import 'dart:convert';

import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/manhua_manhwa_model.dart';
import 'package:mangamint/service/api_service.dart';

class ManhuaManhwaRepo {
  Future<List<ManhuaManwaModel>>getManhuaManhwa({String type,int page})async{
    final response = await ApiService.api.get('${BaseUrl}$type/$page');
    if(response.statusCode == 200){
      var res = json.decode(response.body)['manga_list'];
      List<ManhuaManwaModel> list = List<ManhuaManwaModel>.from(res.map((json)=>
      ManhuaManwaModel.fromJson(json)));
      print(page);
      print(list[1].type);
      return list;
    }else{
      throw Exception('failed fetch');
    }
  }
}