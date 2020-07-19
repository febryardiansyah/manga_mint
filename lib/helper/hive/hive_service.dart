import 'package:hive/hive.dart';

class HiveService{
  addBoxes<T>(List<T> items,String boxName)async{
    final box = await Hive.openBox(boxName);
    for (var item in items){
      box.add(item);
    }
  }
  getBoxes<T>(String boxName)async{
    List<T> boxList = List<T>();
    final box = await Hive.openBox(boxName);
    int length = box.length;
    for(int i = 0;i<length;i++){
      boxList.add(box.getAt(i));
    }
    return boxList;
  }
}