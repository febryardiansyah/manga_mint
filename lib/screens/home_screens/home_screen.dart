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
import 'package:mangamint/screens/home_screens/genre_list.dart';
import 'package:mangamint/screens/home_screens/my_carousel.dart';
import 'package:mangamint/screens/home_screens/terbaru.dart';
import 'package:mangamint/screens/home_screens/terpopular.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecomendedBloc _recomendedBloc;
  GenreListBloc _genreListBloc;
  PopularBloc _popularBloc;
  MangaListBloc _mangaListBloc;
  @override
  void initState() {
    super.initState();
    init();

  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MyBody(
      onRefresh: (){
        _onRefresh();
      },
      title: Text('MangaMint',style: GoogleFonts.modak(color: BaseColor.red),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 15),
        child: ListView(
          children: [
            MyCarousel(),
            _rowTitle(
              title: 'Popular',
              seemore: (){
                Navigator.pushNamed(context, '/popular');
              },
              child: TerpopularCategory()
            ),
            _rowTitle(
              showMore: false,
                title: 'Terbaru',
                child: TerbaruCategory()
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
  Widget _rowTitle({String title,Function seemore,Widget child,bool showMore = true}){
    return Column(
      children: [
        Row(
          children: [
            _categoryTitle(title),
            Spacer(),
            showMore?InkWell(
              onTap: seemore,
                child: Text('lihat selengkapnya')):Center(),
          ],
        ),
        child
      ],
    );
  }
  void init(){
    _recomendedBloc = BlocProvider.of<RecomendedBloc>(context);
    _recomendedBloc.add(FetchRecommended());
    _popularBloc = BlocProvider.of<PopularBloc>(context);
    _popularBloc.add(InitialFetchPopular());
    _genreListBloc = BlocProvider.of<GenreListBloc>(context);
    _genreListBloc.add(FetchGenreList());
    _mangaListBloc = BlocProvider.of(context)..add(InitialFetchMangaEvent());

  }
  void _onRefresh(){
    _recomendedBloc.add(RefreshRecommended());
    _popularBloc.add(RefreshPopular());
    _genreListBloc.add(RefreshGenreList());
    _mangaListBloc.add(RefreshMangaEvent());
  }
}