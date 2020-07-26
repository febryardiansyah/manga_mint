import 'package:equatable/equatable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/helper/hive/hive_chapter_model.dart';
import 'package:mangamint/models/chapter_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChapterScreen extends StatefulWidget {
  final ChapterModel data;
  int currentIndex;
  ChapterScreen({this.data, this.currentIndex});

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> with TickerProviderStateMixin{
  final List<RadioGroup> _listRadio = [
    RadioGroup(index: 1, name: 'Vertical'),
    RadioGroup(index: 2, name: 'Horizontal')
  ];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isHorizontal = false;
  int _group = 1;
  var chapterBox = Hive.box('chapter');

  void checkReadingMode()async{
    SharedPreferences prefs = await _prefs;
    if(prefs.getBool('isHorizontal') == true){
      setState(() {
        _isHorizontal = true;
        _group = 2;
      });
    }else{
      setState(() {
        _isHorizontal = false;
        _group =1 ;
      });
    }

  }

  Animation _animation;
  AnimationController _animationController;
  var animationListener;

  @override
  void initState() {
    super.initState();
    checkReadingMode();
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
  }
  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return Scaffold(
        backgroundColor: BaseColor.black,
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.3),
          elevation: 0,
          title: Text(widget.data.title.length > 20
              ? widget.data.title.substring(0, 20) + '..'
              : widget.data.title),
          actions: [
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.settings),
              onPressed: _viewSettings,
            )
          ],
        ),
        body: WatchBoxBuilder(
          box: chapterBox,
          builder:(context,chapter) => Scrollbar(
            child: Stack(
              children: [
//                PhotoViewGallery.builder(
//                  pageController: PageController(
//                      initialPage: widget.currentIndex,
//                  ),
//                  itemCount: widget.data.chapterImage.length,
//                  scrollPhysics: BouncingScrollPhysics(),
//                  builder: (context, i) {
//                    return PhotoViewGalleryPageOptions(
//                        imageProvider: NetworkImage(
//                            widget.data.chapterImage[i].chapter_image_link),
//                      minScale:  PhotoViewComputedScale.contained * 1,
//                        maxScale: PhotoViewComputedScale.covered * 2.0,
//                        initialScale: PhotoViewComputedScale.contained * 1.0,
//                        heroAttributes: PhotoViewHeroAttributes(
//                            tag: widget.data.chapterImage[i].number));
//                  },
//                  scrollDirection:_isHorizontal? Axis.horizontal:Axis.vertical,
//                  onPageChanged: (int value){
//                    final data = HiveChapterModel(
//                      index: value,
//                      endpoint: widget.data.chapter_endpoint
//                    );
//                   chapter.add(data);
//                    setState(() {
//                      widget.currentIndex = value;
//                    });
//                  },
//                  loadFailedChild: Text('Failed Load image'),
//                  loadingBuilder: (context, event) => Center(
//                    child: Container(
//                      width: 20.0,
//                      height: 20.0,
//                      child: CircularProgressIndicator(
//                        value: event == null
//                            ? 0
//                            : event.cumulativeBytesLoaded /
//                                event.expectedTotalBytes,
//                      ),
//                    ),
//                  ),
//                ),
              ExtendedImageGesturePageView.builder(
                itemCount: widget.data.chapterImage.length,
                  scrollDirection:_isHorizontal? Axis.horizontal:Axis.vertical,
                controller: PageController(
                      initialPage: widget.currentIndex,
                  ),
                itemBuilder: (context,i){
                  return ExtendedImage.network(widget.data.chapterImage[i].chapter_image_link,
                  onDoubleTap: (state){
                    var pointerDownPosition = state.pointerDownPosition;
                    double begin = state.gestureDetails.totalScale;
                    double end;

                    _animation?.removeListener(animationListener);
                    _animationController.stop();
                    _animationController.reset();

                    (begin == 1.0) ? end = 3.0 : end =  1.0;

                    animationListener = () {
                      state.handleDoubleTap(
                          scale: _animation.value,
                          doubleTapPosition: pointerDownPosition);
                    };

                    _animation = _animationController.drive(Tween<double>(begin: begin, end: end));
                    _animation.addListener(animationListener);
                    _animationController.forward();
                  },
                  mode: ExtendedImageMode.gesture,
                    initGestureConfigHandler: (state)=>GestureConfig(
                      minScale: 0.9,
                      animationMinScale: 0.7,
                      maxScale: 3.0,
                      animationMaxScale: 3.5,
                      speed: 1.0,
                      inertialSpeed: 100.0,
                      initialScale: 1.0,
                      inPageView: true,
                      cacheGesture: false
                    ),
                  );
                },
                onPageChanged: (value){
                  final data = HiveChapterModel(
                      index: value,
                      endpoint: widget.data.chapter_endpoint
                  );
                  chapter.add(data);
                  setState(() {
                    widget.currentIndex = value;
                  });
                },
                physics: BouncingScrollPhysics(),
              ),
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: Text('${widget.currentIndex+1} /${widget.data.chapterImage.length} ',style: TextStyle(color: Colors.white,fontSize: 20),),
                )
              ],
            ),
          ),
        ));
  }

  void _viewSettings() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: BaseColor.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(
              'Reading Mode',
              style: TextStyle(color: Colors.white),
            ),
            content: SizedBox(
              height: 100,
              child: Column(
                  children: _listRadio.map((e) {
                return RadioListTile(
                  title: Text(e.name,style: TextStyle(color: Colors.white),),
                  value: e.index,
                  dense: true,
                  groupValue: _group,
                  activeColor: BaseColor.red,
                  onChanged: (newValue) async{
                    final SharedPreferences prefs = await _prefs;
                    if (e.name == 'Vertical') {
                      setState(() {
                        prefs.setBool('isHorizontal', false);
                        _isHorizontal = false;
                      });
                    } else {
                      setState(() {
                        prefs.setBool('isHorizontal', true);
                        _isHorizontal = true;
                      });
                    }
                    setState(() {
                      _group = newValue;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList()),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Batal',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}

class RadioGroup extends Equatable {
  String name;
  int index;

  RadioGroup({this.name, this.index});

  @override
  List<Object> get props => [name, index];
}
