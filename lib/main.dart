import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:mangamint/bloc/bloc.dart';
import 'package:mangamint/bloc/chapter_bloc/bloc.dart';
import 'package:mangamint/bloc/genre_list_bloc/bloc.dart';
import 'package:mangamint/bloc/manga_detail_bloc/bloc.dart';
import 'package:mangamint/bloc/mangabygenre_bloc/bloc.dart';
import 'package:mangamint/bloc/manhuamanhwa/bloc.dart';
import 'package:mangamint/bloc/popular_bloc/bloc.dart';
import 'package:mangamint/bloc/recomended_bloc/bloc.dart';
import 'package:mangamint/bloc/search_bloc/bloc.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/helper/hive/hive_chapter_model.dart';
import 'package:mangamint/helper/hive/hive_chapter_opened_model.dart';
import 'package:mangamint/helper/hive/hive_manga_model.dart';
import 'package:mangamint/helper/routes.dart';
import 'package:mangamint/repositories/chapter_repo.dart';
import 'package:mangamint/repositories/genre_list_repo.dart';
import 'package:mangamint/repositories/manga_detail_repo.dart';
import 'package:mangamint/repositories/manga_list_repo.dart';
import 'package:mangamint/repositories/manhua_manhwa_repo.dart';
import 'package:mangamint/repositories/popular_repo.dart';
import 'package:mangamint/repositories/recommended_repo.dart';
import 'package:mangamint/repositories/search_repo.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.openBox('manga');
  Hive.openBox('chapter');
  Hive.openBox('lastOpenedChapter');
  Hive.registerAdapter(HiveChapterModelAdapter());
  Hive.registerAdapter(HiveMangaModelAdapter());
  Hive.registerAdapter(HiveChapterOpenedModelAdapter());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          BlocProvider<MangaListBloc>(
              create: (context) => MangaListBloc(MangaListRepo())),
          BlocProvider<MangaDetailBloc>(
            create: (context) => MangaDetailBloc(MangaDetailRepo()),
          ),
          BlocProvider<ChapterBlocBloc>(
            create: (context) => ChapterBlocBloc(ChapterRepo()),
          ),
          BlocProvider<RecomendedBloc>(
            create: (_) => RecomendedBloc(RecommendedRepo()),
          ),
          BlocProvider<GenreListBloc>(
            create: (_) => GenreListBloc(GenreListRepo()),
          ),
          BlocProvider<PopularBloc>(
            create: (_) => PopularBloc(PopularRepo()),
          ),
          BlocProvider<SearchBlocBloc>(
            create: (_) => SearchBlocBloc(SearchRepo()),
          ),
          BlocProvider<MangaByGenreBloc>(
            create: (_) => MangaByGenreBloc(MangaByGenreRepo()),
          ),
          BlocProvider<ManhuamanhwaBloc>(
            create: (_) => ManhuamanhwaBloc(ManhuaManhwaRepo()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            textTheme: TextTheme(
              button: GoogleFonts.roboto(),
              caption: GoogleFonts.roboto()
            ),
            appBarTheme: AppBarTheme(
              actionsIconTheme: IconThemeData(color: BaseColor.black),
              color: Colors.white,
              iconTheme: IconThemeData(color: BaseColor.red)
            )
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: generateRoute,
        )
    );
  }
}
