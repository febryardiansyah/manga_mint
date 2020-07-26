import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangamint/bloc/popular_bloc/bloc.dart';
import 'package:mangamint/components/item_small.dart';
import 'package:mangamint/components/my_shimmer.dart';
import 'package:mangamint/constants/base_color.dart';

class TerpopularCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: BlocBuilder<PopularBloc,PopularState>(
        builder: (context,state){
          if(state is PopularLoadingState){
            return MyShimmer(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: BaseColor.red,
              ),
            );
          }else if (state is PopularLoadedState) {
            return SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: state.popularList.getRange(0, 10).length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,i){
                  var data = state.popularList[i];
                  return ItemSmall(
                    title: data.title,
                    subtitle: data.type,
                    bottom: data.upload_on,
                    thumb: data.thumb,
                    onTap: (){
                      Navigator.pushNamed(context, '/detailmanga',arguments: data.endpoint);
                    },
                  );
                },
              ),
            );
          } else if(state is PopularFailureState){
            print(state.msg);
            return Text('Cek internet mu euy atau tunggu nanti');
          }
          return Container();
        },
      ),
    );
  }
}
