import 'package:dio/dio.dart';
import 'package:mangamint/models/genre_list_model.dart';
import 'package:mangamint/service/base_service.dart';

class GenreListRepo extends BaseService{
  Future<List<GeneListModel>>getGenreList()async{
    final Response response = await request(url:'genres');
    List<GeneListModel>list = List<GeneListModel>.from(response.data['list_genre'].map((item) => GeneListModel.fromMap(item)));
    // print('genressssss ${response.data}');
    return list;
  }
}

class MangaByGenreRepo extends BaseService{
  Future<List<MangaByGenreModel>>getManga({String genre,int page})async{
    final Response response = await request(url: 'genres/$genre$page');
    List<MangaByGenreModel>list = List<MangaByGenreModel>.from(response.data['manga_list'].map((item) => MangaByGenreModel.fromJson(item)));
    print(list.length);
    return list;
  }
}
