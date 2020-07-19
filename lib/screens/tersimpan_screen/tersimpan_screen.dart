import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mangamint/components/my_body.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/helper/color_manga_type.dart';
import 'package:mangamint/helper/hive/hive_manga_model.dart';

class TersimpanScreen extends StatefulWidget {
  @override
  _TersimpanScreenState createState() => _TersimpanScreenState();
}

class _TersimpanScreenState extends State<TersimpanScreen> {
  @override
  Widget build(BuildContext context) {
    return MyBody(
      showRefresh: false,
      title: Text('Tersimpan',style: TextStyle(color: BaseColor.black,fontWeight: FontWeight.bold),),
      body: FutureBuilder(
        future: Hive.openBox('manga'),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if (snapshot.hasError) {
              return Center(child: Text('error'),);
            } else{
              return Hive.box('manga').isEmpty ?Center(
                child: Text('Kosong Mint xixixi'),
              )
                  :_buildListview();
            }
          }
          return Container();
        },
      ),
    );
  }
  _buildListview(){
    var mangaBox = Hive.box('manga');
    return WatchBoxBuilder(
      box: mangaBox,
      builder: (context,manga) =>
      ListView.builder(
        itemCount: mangaBox.length,
        itemBuilder: (context,i){
          HiveMangaModel mangaModel = mangaBox.getAt(i);
          print(mangaModel.title);
          return ListTile(
            title: Text(mangaModel.title.length > 20 ? '${mangaModel.title}..':mangaModel.title),
            subtitle: Text(mangaModel.type,style: TextStyle(color: mangaTypeColor(mangaModel.type)),),
            trailing: IconButton(
              icon: Icon(Icons.delete,color: BaseColor.red,),
              onPressed: (){
                mangaBox.deleteAt(i);
              },
            ),
            leading: Image.network(
              mangaModel.thumb,
            ),
          );
        },
      ),
    );
  }
}
