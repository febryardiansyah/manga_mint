import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangamint/bloc/bloc.dart';
import 'package:mangamint/components/bottom_loader.dart';
import 'package:mangamint/components/build_error.dart';
import 'package:mangamint/components/my_shimmer.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/helper/color_manga_type.dart';

class SemuanyaCategory extends StatefulWidget {
  @override
  _SemuanyaCategoryState createState() => _SemuanyaCategoryState();
}

class _SemuanyaCategoryState extends State<SemuanyaCategory> {
  final _scrollCtrl = ScrollController();
  final _scrollThreshold = 200.0;
  MangaListBloc _mangaListBloc;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      final maxScroll = _scrollCtrl.position.maxScrollExtent;
      final currentScroll = _scrollCtrl.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold) {
        _mangaListBloc = BlocProvider.of<MangaListBloc>(context);
        _mangaListBloc.add(FetchManga());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<MangaListBloc, MangaListState>(
        builder: (context, state) {
          if (state is MangaListLoadingState) {
            return MyShimmer(
              child: ListView.builder(
                itemCount: 10,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: Container(
                      height: 100.h,
                      width: 200.w,
                      color: BaseColor.red,
                    ),
                    title: Container(
                      height: 100.h,
                      width: MediaQuery.of(context).size.width,
                      color: BaseColor.red,
                    ),
                  );
                },
              ),
            );
          } else if (state is MangaListStateLoaded) {
            return Scrollbar(
              child: ListView.separated(
                separatorBuilder: (context,index)=>Divider(color: BaseColor.grey2,),
                itemCount: state.hasReachedMax
                    ? state.mangaList.length
                    : state.mangaList.length + 1,
                controller: _scrollCtrl,
                itemBuilder: (context, i) {
                  return i >= state.mangaList.length
                      ? BottomLoader()
                      : ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, '/detailmanga',
                                arguments: state.mangaList[i].endpoint);
                          },
                          title: Text(state.mangaList[i].title.length > 20
                              ? '${state.mangaList[i].title.substring(0, 20)}..'
                              : state.mangaList[i].title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.mangaList[i].type,
                                style: TextStyle(
                                    color: mangaTypeColor(state.mangaList[i].type)),
                              ),
                              Text(
                                state.mangaList[i].updated_on,
                                style: TextStyle(
                                    color: BaseColor.grey1),
                              ),
                            ],
                          ),
                          leading: Image.network(
                            state.mangaList[i].thumb,
                            height: MediaQuery.of(context).size.height,
                            width: 200.w,
                            fit: BoxFit.cover,
                          ),
                          trailing: SizedBox(
                            height: 100.h,
                            width: 200.w,
                            child: Text(
                              state.mangaList[i].chapter,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                },
              ),
            );
          }else if(state is MangaListStateFailure){
            return BuildError();
          }
          return Container();
        },
      ),
    );
  }
}
