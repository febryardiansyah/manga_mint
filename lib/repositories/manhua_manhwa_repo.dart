import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/manhua_manhwa_model.dart';
import 'package:mangamint/service/api_service.dart';
import 'package:mangamint/service/base_service.dart';

class ManhuaManhwaRepo extends BaseService{
  Future<List<ManhuaManwaModel>>getManhuaManhwa({String type,int page})async{
    final Response response = await request(url: '$type/$page');
    List<ManhuaManwaModel> list = List<ManhuaManwaModel>.from(response.data['manga_list'].map((json)=>
      ManhuaManwaModel.fromJson(json)));
    return list;
//    final response = await ApiService.api.get('${BaseUrl}$type/$page');
//    if(response.statusCode == 200){
//      var res = json.decode(response.body)['manga_list'];
//      List<ManhuaManwaModel> list = List<ManhuaManwaModel>.from(res.map((json)=>
//      ManhuaManwaModel.fromJson(json)));
//      print(page);
//      print(list[1].type);
//      return list;
//    }else{
//      throw Exception('failed fetch');
//    }
  }
}