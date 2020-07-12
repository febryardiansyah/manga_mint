import 'dart:convert';

import 'package:mangamint/constants/base_url.dart';
import 'package:mangamint/models/chapter_model.dart';
import 'package:mangamint/service/api_service.dart';

class ChapterRepo{
  Future<ChapterModel>getChapter(String endpoint)async{
    final response = await ApiService.api.get(BaseUrl+'chapter/$endpoint');

    if(response.statusCode == 200){
      final res = json.decode(response.body);
      ChapterModel data = ChapterModel.fromJson(res);
      print(data.chapterImage[0].chapter_image_link);
      return data;
    }else{
      throw Exception('failed Fetch');
    }
  }
}