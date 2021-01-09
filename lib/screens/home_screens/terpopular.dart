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
          if(state is PopularLoadingState || state is PopularFailureState){
            return MyShimmer(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 3,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,mainAxisSpacing: 2,crossAxisSpacing: 2
                ),
                itemBuilder: (context,i){
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          color: BaseColor.red,
                        ),
                      ),
                      SizedBox(height: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 10,
                          width: MediaQuery.of(context).size.width,
                          color: BaseColor.red,
                        ),
                      )
                    ],
                  );
                },
              )
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
          }
          return Container();
        },
      ),
    );
  }
}
