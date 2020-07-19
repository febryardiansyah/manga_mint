import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangamint/bloc/terbaru_bloc/bloc.dart';
import 'package:mangamint/components/build_error.dart';
import 'package:mangamint/components/item_big.dart';
import 'package:mangamint/components/my_shimmer.dart';
import 'package:mangamint/constants/base_color.dart';

class TerbaruCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<TerbaruBloc,TerbaruState>(
        builder: (context,state){
          if (state is TerbaruLoadingState) {
            return MyShimmer(
              child: Container(
                color: BaseColor.red,
                width: MediaQuery.of(context).size.width,
                height: 100,
              ),
            );
          }else if (state is TerbaruLoadedState) {
            var mystate = state.terbaruList;
            return ItemBig(
              itemCount: mystate.getRange(0, 16).length,
              itemBuilder: (context,i){
                var index = mystate[i];
                return ItemBigChild(
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
            );
          }else if(state is TerbaruFailureState){
            return Scaffold(body: BuildError(msg: state.msg,),);
          }
          return Container();
        },
      ),
    );
  }
}
