import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangamint/bloc/bloc.dart';
import 'package:mangamint/bloc/genre_list_bloc/bloc.dart';
import 'package:mangamint/bloc/popular_bloc/bloc.dart';
import 'package:mangamint/bloc/recomended_bloc/bloc.dart';
import 'package:mangamint/components/my_body.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/models/manga_list_model.dart';
import 'package:mangamint/repositories/recommended_repo.dart';
import 'package:mangamint/screens/detail_screen/index_detail.dart';
import 'package:mangamint/screens/home_screens/genre_list.dart';
import 'package:mangamint/screens/home_screens/my_carousel.dart';
import 'package:mangamint/screens/home_screens/terpopular.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  MangaListBloc _mangaListBloc;
//  final ScrollController _scrollController = ScrollController();
//  final _scrollThreshold = 200.0;
//
//  MangaListStateLoaded get state => widget._state;
//  @override
//  void initState() {
//    super.initState();
//    _scrollController.addListener(() {
//      final maxScroll = _scrollController.position.maxScrollExtent;
//      final currentScroll = _scrollController.position.pixels;
//      if(maxScroll - currentScroll <= _scrollThreshold){
//        _mangaListBloc = BlocProvider.of<MangaListBloc>(context);
//        _mangaListBloc.add(FetchManga());
//      }
//    });
//  }
  RecomendedBloc _recomendedBloc;
  GenreListBloc _genreListBloc;
  PopularBloc _popularBloc;
  @override
  void initState() {
    super.initState();
    _recomendedBloc = BlocProvider.of<RecomendedBloc>(context);
    _recomendedBloc.add(FetchRecommended());
    _popularBloc = BlocProvider.of<PopularBloc>(context);
    _popularBloc.add(FetchPopular());
    _genreListBloc = BlocProvider.of<GenreListBloc>(context);
    _genreListBloc.add(FetchGenreList());

  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MyBody(
      title: Text('MangaMint',style: GoogleFonts.modak(color: BaseColor.red),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 15),
        child: ListView(
          children: [
            MyCarousel(),
            _rowTitle(
              title: 'Popular',
              seemore: (){},
              child: Terpopular()
            ),
            _categoryTitle('Genre'),
            GenreListHome(),
          ],
        ),
      ),
    );
  }
  Widget _categoryTitle(String title){
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(title,
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
    );
  }
  Widget _rowTitle({String title,Function seemore,Widget child}){
    return Column(
      children: [
        Row(
          children: [
            _categoryTitle(title),
            Spacer(),
            InkWell(
              onTap: seemore,
                child: Text('lihat selengkapnya')),
          ],
        ),
        child
      ],
    );
  }
}