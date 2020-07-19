import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangamint/bloc/terbaru_bloc/bloc.dart';
import 'package:mangamint/components/bottom_loader.dart';
import 'package:mangamint/components/build_error.dart';
import 'package:mangamint/components/item_big.dart';
import 'package:mangamint/components/my_body.dart';
import 'package:mangamint/constants/base_color.dart';

class TerbaruScreen extends StatefulWidget {
  @override
  _TerbaruScreenState createState() => _TerbaruScreenState();
}

class _TerbaruScreenState extends State<TerbaruScreen> {
  TerbaruBloc _terbaruBloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _terbaruBloc.add(FetchTerbaru());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _terbaruBloc = BlocProvider.of<TerbaruBloc>(context);

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TerbaruBloc,TerbaruState>(
      builder: (context,state){
        if(state is TerbaruLoadedState){
          var mystate = state.terbaruList;
          return MyBody(
            showRefresh: false,
            title: Text('Terbaru',style: TextStyle(fontWeight: FontWeight.bold,color: BaseColor.black),),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ItemBig(
                controller: _scrollController,
                itemCount: state.hasReachedMax?mystate.length:mystate.length,
                itemBuilder: (context,i){
                  var index = mystate[i];
                  return i>=mystate.length?BottomLoader(): ItemBigChild(
                    onTap: (){
                      Navigator.pushNamed(context, '/detailmanga',arguments: index.endpoint);
                    },
                    title: index.title,
                    thumb: index.thumb,
                    type: index.type,
                    chapter: index.chapter,
                    update: index.update,
                  );
                },
              ),
            ),
          );
        }else if(state is TerbaruFailureState){
          return Scaffold(body: BuildError(msg: state.msg,),);
        }
        return Container();
      },
    );
  }
}
