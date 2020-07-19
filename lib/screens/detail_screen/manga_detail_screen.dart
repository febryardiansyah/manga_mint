import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mangamint/bloc/manga_detail_bloc/bloc.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/helper/hive/hive_manga_model.dart';
import 'package:mangamint/helper/hive/hive_service.dart';
import 'package:mangamint/models/manga_detail_model.dart';
import 'package:mangamint/screens/chapter_screen/index_chapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MangaDetailScreen extends StatefulWidget {
  final MangaDetailModel data;

  const MangaDetailScreen({Key key, this.data}) : super(key: key);

  @override
  _MangaDetailScreenState createState() => _MangaDetailScreenState();
}

class _MangaDetailScreenState extends State<MangaDetailScreen> {
  MangaDetailModel get data => widget.data;
  bool isReversed = false;
  var hiveBox = Hive.box('manga');
  void _sortByName(){
    if(isReversed == false){
      setState(() {
        isReversed = true;
      });
    }else{
      setState(() {
        isReversed = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(500.h),
          child: Stack(
            children: [
              Container(
                height: 500.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  color: BaseColor.grey2,
                  image: DecorationImage(
                    image: NetworkImage(data.thumb),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Positioned(
                top: 10,
                child: Container(
                  height: 150.h,
                  padding: EdgeInsets.only(left: 10),
                  color: Colors.black54,
                  width: size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                         icon:  Icon(Icons.arrow_back),color: BaseColor.black,
                          onPressed: (){
                           Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(data.title.length > 20 ?'${data.title.substring(0,20)}..':data.title,style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.info_outline,color: Colors.white,),
                        onPressed: (){
                          showModalBottomSheet(context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                              ),
                              builder: (context){
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 500,
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 5,
                                      color: BaseColor.grey1,
                                    ),
                                    Text('Synopsis',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),),
                                    Text(data.synopsis,textAlign: TextAlign.justify,)
                                  ],
                                ),
                              ),
                            );
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.bookmark_border,color: Colors.white,),
                        onPressed: (){
                          final data = HiveMangaModel(
                            title: widget.data.title,
                            type: widget.data.type,
                            thumb: widget.data.thumb,
                          );
                          if(hiveBox.containsKey(widget.data.thumb)){
                            hiveBox.delete(widget.data.thumb);
                          }
                          hiveBox.add(data);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                child: Container(
                  height: 100.h,
                  width: 250.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4)
                  ),
                  child: Center(child: Text(data.type,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),)),
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              _detail(data),
              Divider(),
              _score(data: data),
              Divider(),
              Text('Genre',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              _genre(data),
              Divider(),
              Row(
                children: [
                  Text('Chapter',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.sort_by_alpha),
                    onPressed: _sortByName,
                  )
                ],
              ),
              ChapterList(data,isReversed)
            ],
          ),
        ),
      ),
    );
  }
  Widget _detail(MangaDetailModel data){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _detailRow(key: 'Status',value: data.status),
        _detailRow(key: 'Released',value: data.released.toString()),
        _detailRow(key: 'Updated On',value: data.updated_on),
        _detailRow(key: 'Author', value: data.author),
        _detailRow(key: 'Posted On',value: data.posted_on)
      ],
    );
  }
  Widget _detailRow({String key,String value}){
    return Row(
      children: [
        Text('$key : \t',style: TextStyle(fontSize: 17),),
        Text(value.length > 25 ? '${value.substring(0,25)}..':value,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
      ],
    );
  }
  Widget _score({MangaDetailModel data}){
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 100.h,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 30,
              width: 30,
              color: BaseColor.orange,
              child: Icon(Icons.star,color:Colors.white,),
            ),
          ),
          SizedBox(width: 10,),
          Text('Score',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          Spacer(),
          SizedBox(width: 10,),
          ScoreStar(data),
          Text(data.score.toString())
        ],
      ),
    );
  }
  Widget _genre(MangaDetailModel data){
    return SizedBox(
      height: 150.h,
      width: double.infinity,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.genreList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,i){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: InkWell(
                onTap: (){
                  print('tapped');
                },
                child: Container(
                  color: BaseColor.red,
                  height: 20,
                  width: 100,
                  child: Center(child: Text(data.genreList[i].genre_name,style: TextStyle(color: Colors.white),)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
class ScoreStar extends StatelessWidget {
  final MangaDetailModel _mangaDetailModel;

  ScoreStar(this._mangaDetailModel);

  num get score => _mangaDetailModel.score;
  @override
  Widget build(BuildContext context) {
      if(score == 6 || score < 5 || score < 7){
        return _buildRowStar(icon1: BaseColor.orange,);
      }else if(score == 7 || score < 8){
        return _buildRowStar(icon1: BaseColor.orange,icon2: BaseColor.orange,);
      }else if(score == 8 || score <9){
        return _buildRowStar(icon1: BaseColor.orange,icon2: BaseColor.orange,
          icon3: BaseColor.orange,);
      }else if(score == 9 || score < 9){
        return _buildRowStar(icon1: BaseColor.orange,icon2: BaseColor.orange,
            icon3: BaseColor.orange,icon4: BaseColor.orange);
      }else{
        return _buildRowStar(icon1: BaseColor.orange,icon2: BaseColor.orange,
            icon3: BaseColor.orange,icon4: BaseColor.orange,icon5: BaseColor.orange);
      }
  }
  Widget _buildRowStar({icon1,icon2,icon3,icon4,icon5}){
    return Row(
      children: [
        Icon(Icons.star,color: icon1 ?? BaseColor.grey2,),
        Icon(Icons.star,color: icon2 ?? BaseColor.grey1,),
        Icon(Icons.star,color: icon3 ?? BaseColor.grey1,),
        Icon(Icons.star,color: icon4 ?? BaseColor.grey1,),
        Icon(Icons.star,color: icon5 ?? BaseColor.grey1,),
      ],
    );
  }
}
class ChapterList extends StatefulWidget {
  final MangaDetailModel data;
  bool isReversed;

  ChapterList(this.data,this.isReversed);

  @override
  _ChapterListState createState() => _ChapterListState();
}
class _ChapterListState extends State<ChapterList> {
  bool isOpened = false;
  bool get isReversed => widget.isReversed;
  void _checkOpen()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isOpened = pref.getBool('isOpened'??false);
    });
  }
  @override
  void initState() {
    super.initState();
    _checkOpen();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GridView.builder(
        reverse: isReversed?true:false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          crossAxisSpacing: 4,
          childAspectRatio: 3,
        ),
        itemCount: widget.data.chapterList.length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context,i){
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: InkWell(
              onTap: ()async{
                final SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setBool('isOpened', true);
//                pref.setString('chapterId', widget.data.chapterList[i].chapter_endpoint);
                Navigator.pushNamed(context, '/chapter',arguments:
                widget.data.chapterList[i].chapter_endpoint);
              },
              child: Container(
                color: BaseColor.red,
                height: 20,
                child: Center(child: Text(widget.data.chapterList[i].chapter_title,style: TextStyle(color: Colors.white),)),
              ),
            ),
          );
        },
      ),
    );
  }
}


