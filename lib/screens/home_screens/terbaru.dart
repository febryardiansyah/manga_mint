import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangamint/bloc/manga_list_bloc/bloc.dart';
import 'package:mangamint/components/item_big.dart';
import 'package:mangamint/components/my_shimmer.dart';
import 'package:mangamint/constants/base_color.dart';

class TerbaruCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<MangaListBloc,MangaListState>(
        builder: (context,state){
          if (state is MangaListLoadingState || state is MangaListStateFailure) {
            return MyShimmer(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,mainAxisSpacing: 1,crossAxisSpacing: 2,
                ),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 10,
                itemBuilder:(context,i)=> Container(
                  color: BaseColor.red,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                ),
              ),
            );
          }else if (state is MangaListStateLoaded) {
            var mystate = state.mangaList;
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
                  update: index.updated_on,
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
