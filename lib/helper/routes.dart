import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangamint/components/bottom_nav_bar.dart';
import 'package:mangamint/components/splash_screen.dart';
import 'package:mangamint/screens/chapter_screen/index_chapter.dart';
import 'package:mangamint/screens/detail_screen/index_detail.dart';
import 'package:mangamint/screens/result_screen/manga_by_genre_screen.dart';
import 'package:mangamint/screens/result_screen/result_screen.dart';
import 'package:mangamint/screens/result_screen/search_screen.dart';
import 'package:mangamint/screens/result_screen/terpopuler_screen.dart';

MaterialPageRoute pageRoute({RouteSettings routeSettings,Widget builder,bool isFullscreen = false}){
  return MaterialPageRoute(
    builder: (BuildContext context) => builder,
    settings: routeSettings,
    fullscreenDialog: isFullscreen,
  );
}
Route generateRoute(RouteSettings routeSettings){
  final args = routeSettings.arguments;
  switch(routeSettings.name){
    case '/':
      return pageRoute(routeSettings: routeSettings,builder: SplashScreen());
    case '/navbar':
      return pageRoute(routeSettings: routeSettings,builder: BottomNavBar());
    case '/detailmanga':
      return pageRoute(routeSettings: routeSettings,builder: IndexDetail(endpoint: args,));
    case '/chapter':
      return pageRoute(routeSettings: routeSettings,builder: IndexChapter(endpoint: args,),isFullscreen: true);
    case '/popular':
      return pageRoute(routeSettings: routeSettings,builder: TerpopulerScreen());
    case '/search':
      return pageRoute(routeSettings: routeSettings,builder: SearchScreen(),isFullscreen: true);
    case '/result':
      return pageRoute(routeSettings: routeSettings,builder: ResultScreen(query: args,));
    case '/mangabygenre':
      return pageRoute(routeSettings: routeSettings,builder: MangaByGenreScreen(endpoint: args,));
  }
}