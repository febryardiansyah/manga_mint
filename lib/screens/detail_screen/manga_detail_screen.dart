import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/helper/hive/hive_chapter_opened_model.dart';
import 'package:mangamint/helper/hive/hive_manga_model.dart';
import 'package:mangamint/models/manga_detail_model.dart';
import 'package:toast/toast.dart';

class MangaDetailScreen extends StatefulWidget {
  final MangaDetailModel data;

  const MangaDetailScreen({Key key, this.data}) : super(key: key);

  @override
  _MangaDetailScreenState createState() => _MangaDetailScreenState();
}

class _MangaDetailScreenState extends State<MangaDetailScreen> {
  MangaDetailModel get data => widget.data;
  bool isReversed = false;
  var mangaBox = Hive.box('manga');
  bool _isSaved = false;
  HiveMangaModel mangaModel;
  var lastBox = Hive.box('lastOpenedChapter');
  HiveChapterOpenedModel lastModel;
  String _chapterEndpoint = '';
  int _totalChapter;

  void _checkIsSaved() {
    int count = mangaBox.length;
    for (int i = 0; i < count; i++) {
      mangaModel = mangaBox.getAt(i);
      if (mangaModel.manga_endpoint == widget.data.manga_endpoint) {
        setState(() {
          _isSaved = true;
        });
        break;
      } else {
        setState(() {
          _isSaved = false;
        });
      }
    }
  }

  void _sortByName() {
    if (isReversed == false) {
      setState(() {
        isReversed = true;
      });
    } else {
      setState(() {
        isReversed = false;
      });
    }
  }

  void _checkLastChapter() {
    setState(() {
      _totalChapter = data.chapterList.length-1;
    });
    int count = lastBox.length;
    for (int i = 0; i < count; i++) {
      lastModel = lastBox.getAt(i);
      if (lastModel.manga_endpoint == widget.data.manga_endpoint) {
        setState(() {
          _chapterEndpoint = lastModel.chapter_endpoint;
        });
        break;
      } else {
        setState(() {
          _chapterEndpoint = '';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIsSaved();
    _checkLastChapter();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _chapterEndpoint.isEmpty?Center():FloatingActionButton(
          child: Icon(Icons.history),
          tooltip: 'Lanjutkan chapter',
          backgroundColor: BaseColor.orange,
          onPressed: (){
            Navigator.pushNamed(context, '/chapter',arguments: _chapterEndpoint);
          },
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(500.h),
          child: Stack(
            children: [
              Container(
                height: 500.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: BaseColor.grey2,
                    image: DecorationImage(
                        image: NetworkImage(data.thumb), fit: BoxFit.cover)),
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
                          icon: Icon(Icons.arrow_back),
                          color: BaseColor.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        data.title.length > 17
                            ? '${data.title.substring(0, 17)}..'
                            : data.title,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              builder: (context) {
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
                                        Text(
                                          'Synopsis',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          data.synopsis,
                                          textAlign: TextAlign.justify,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                      WatchBoxBuilder(
                        box: mangaBox,
                        builder: (context, manga) => IconButton(
                          icon: Icon(
                            Icons.bookmark_border,
                            color: _isSaved ? BaseColor.red : Colors.white,
                          ),
                          onPressed: () {
                            final data = HiveMangaModel(
                              title: widget.data.title,
                              type: widget.data.type,
                              thumb: widget.data.thumb,
                              manga_endpoint: widget.data.manga_endpoint,
                            );
                            int count = manga.length;
                            bool deleted = false;
                            for (int i = 0; i < count; i++) {
                              mangaModel = mangaBox.getAt(i);
                              if (mangaModel.manga_endpoint ==
                                  widget.data.manga_endpoint) {
                                print('exist');
                                mangaBox.deleteAt(i);
                                deleted = true;
                                setState(() {
                                  _isSaved = false;
                                });
                                Toast.show('Di Hapus', context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.CENTER);
                                break;
                              }
                            }
                            if (!deleted) {
                              print('not exist');
                              mangaBox.add(data);
                              setState(() {
                                _isSaved = true;
                              });
                              Toast.show('Di Simpan', context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.CENTER);
                            }
                          },
                        ),
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
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.4)),
                  child: Center(
                      child: Text(
                    data.type,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
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
              Text(
                'Genre',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              _genre(data),
              Divider(),
              Row(
                children: [
                  Text(
                    'Chapter',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.sort_by_alpha),
                    onPressed: _sortByName,
                  )
                ],
              ),
              ChapterList(data, isReversed,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _detail(MangaDetailModel data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _detailRow(key: 'Status', value: data.status),
        _detailRow(key: 'Author', value: data.author),
        _detailRow(key: 'Type', value: data.type),
        _detailRow(key: 'Total Chapter',value: _totalChapter.toString()),
      ],
    );
  }
  Widget _detailRow({String key, String value}) {
    return Row(
      children: [
        Text(
          '$key : \t',
          style: TextStyle(fontSize: 17),
        ),
        Text(
          value.length > 25 ? '${value.substring(0, 25)}..' : value,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        )
      ],
    );
  }


  Widget _genre(MangaDetailModel data) {
    return SizedBox(
      height: 150.h,
      width: double.infinity,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.genreList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: InkWell(
                onTap: () {
                  print('tapped');
                },
                child: Container(
                  color: BaseColor.red,
                  height: 20,
                  width: 100,
                  child: Center(
                      child: Text(
                    data.genreList[i].genre_name,
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChapterList extends StatefulWidget {
  final MangaDetailModel data;
  bool isReversed;

  ChapterList(this.data, this.isReversed, );

  @override
  _ChapterListState createState() => _ChapterListState();
}

class _ChapterListState extends State<ChapterList> {
  bool get isReversed => widget.isReversed;
  var chapterBox = Hive.box('chapter');
  var mangaBox = Hive.box('manga');
  var lastBox = Hive.box('lastOpenedChapter');
  int _isClicked;
  HiveChapterOpenedModel lastModel;

  @override
  void initState() {
    super.initState();
    _setIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.separated(
        reverse: isReversed ? true : false,
        separatorBuilder: (context,j) => Divider(color: BaseColor.grey2,),
        itemCount: widget.data.chapterList.length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: InkWell(
              onTap: () {
                var data = HiveChapterOpenedModel(
                  manga_endpoint: widget.data.manga_endpoint,
                  lastChapter: index,
                  chapter_endpoint:
                      widget.data.chapterList[index].chapter_endpoint,
                );
                int count = lastBox.length;
                bool isExist = false;
                setState(() {
                  _isClicked = index;
                });
                for (int i = 0; i < count; i++) {
                  lastModel = lastBox.getAt(i);
                  if (lastModel.manga_endpoint == widget.data.manga_endpoint) {
                    lastBox.putAt(i, data);
                    setState(() {
                      isExist = true;
                    });
                    break;
                  }
                }
                if(!isExist){
                  lastBox.add(data);
                }
                Navigator.pushNamed(context, '/chapter',
                    arguments: widget.data.chapterList[index].chapter_endpoint);
              },
              child: Container(
                color: _isClicked == index
                    ? BaseColor.grey1
                    : BaseColor.red,
                height: 50,
                child: Center(
                    child: Text(
                  widget.data.chapterList[index].chapter_title,
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          );
        },
      ),
    );
  }
  void _setIndex(){
    int count = lastBox.length;
    for(int i =0;i<count;i++){
      lastModel = lastBox.getAt(i);
      if(lastModel.manga_endpoint == widget.data.manga_endpoint){
        setState(() {
          _isClicked = lastModel.lastChapter;
        });
      }
    }
  }
}
