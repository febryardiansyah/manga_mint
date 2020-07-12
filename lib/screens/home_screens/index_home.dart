import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangamint/bloc/bloc.dart';
import 'package:mangamint/components/build_error.dart';
import 'package:mangamint/components/my_body.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/screens/home_screens/home_screen.dart';

class IndexHome extends StatefulWidget {
  @override
  _IndexHomeState createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome> {
  MangaListBloc _mangaListBloc;

  @override
  void initState() {
    super.initState();
    _mangaListBloc = BlocProvider.of<MangaListBloc>(context);
    _mangaListBloc.add(FetchManga());
  }
  @override
  Widget build(BuildContext context) {
    return MyBody(
      onRefresh: (){},
      title: Text('MangaMint',style: GoogleFonts.modak(color: BaseColor.red),),
//      body:  BlocBuilder<MangaListBloc,MangaListState>(
//        builder: (context,state){
//          if(state is MangaListLoadingState){
//            return Center(child: Text('Loading'),);
//          }else if (state is MangaListStateLoaded) {
//            return HomeScreen(state: state,);
//          }else if(state is MangaListStateFailure){
//            return BuildError(msg: state.msg,);
//          }
//          return Container();
//        },
//      ),
    );
  }
}
