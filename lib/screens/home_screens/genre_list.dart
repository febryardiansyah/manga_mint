import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangamint/bloc/genre_list_bloc/bloc.dart';
import 'package:mangamint/components/my_shimmer.dart';
import 'package:mangamint/constants/base_color.dart';

class GenreListHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: BlocBuilder<GenreListBloc,GenreListState>(
        builder: (context,state){
          if (state is GenreListLoadingState) {
            return MyShimmer(
              child: _myGridview(
                itemCount: 16,
                  itemBuilder: (context,i){
                    return Container(
                      color: BaseColor.red,
                      height: 10,
                    );
                  }
              ),
            );
          } else if(state is GenreListLoadedState){
            return _myGridview(
              itemCount: state.genreList.length,
              itemBuilder: (context,i){
                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/mangabygenre',arguments: state.genreList[i]
                      .endpoint);
                    },
                    child: Container(
                      color: BaseColor.red,
                      height: 20,
                      child: Center(child: Text(state.genreList[i].title,style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                );
              }
            );
          }
          return Container();
        },
      ),
    );
  }
  Widget _myGridview({int itemCount,itemBuilder,}){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 5,
        crossAxisSpacing: 4,
        childAspectRatio: 3,
      ),
      itemCount: itemCount,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: itemBuilder,
    );
  }
}
