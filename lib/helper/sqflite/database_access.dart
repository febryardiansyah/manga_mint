import 'package:mangamint/helper/sqflite/DatabaseProvider.dart';
import 'package:mangamint/helper/sqflite/chapter_local_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAccess{
  final _dbProvider = DBProvider.instance;

  Future<int> insertChapter(ChapterLocalModel model)async{
    final db = await _dbProvider.database;
    var result = db.insert(chapterTable, model.toDatabase());
    return result;
  }
  Future<int> updateChapter(ChapterLocalModel model)async{
    final db = await _dbProvider.database;
    int count = await db.update(chapterTable, model.toDatabase(),
    where: 'endpoint=?',whereArgs: [model.endpoint]);
    return count;
  }
  Future<List<ChapterLocalModel>> getChapterIndex()async{
    final db = await _dbProvider.database;
    List<Map<String,dynamic>> mapList = await db.query(chapterTable);
    List<ChapterLocalModel> chapterList = List<ChapterLocalModel>();
    int count = mapList.length;
    for(int i = 0;i<count;i++){
      chapterList.add(ChapterLocalModel.fromDatabase(mapList[i]));
    }
    return chapterList;
  }
}