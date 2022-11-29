import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangamint/bloc/mangabygenre_bloc/bloc.dart';
import 'package:mangamint/components/bottom_loader.dart';
import 'package:mangamint/components/my_body.dart';
import 'package:mangamint/components/my_shimmer.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/helper/color_manga_type.dart';

class MangaByGenreScreen extends StatefulWidget {
  final String endpoint;

  MangaByGenreScreen({Key key, this.endpoint}) : super(key: key);

  @override
  _MangaByGenreScreenState createState() => _MangaByGenreScreenState();
}

class _MangaByGenreScreenState extends State<MangaByGenreScreen> {
  MangaByGenreBloc _mangaByGenreBloc;

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _mangaByGenreBloc.add(FetchMangByGenre(endpoint: widget.endpoint));
    }
//    final maxScroll = _scrollController.position.maxScrollExtent;
//    final currentScroll = _scrollController.position.pixels;
//    if (maxScroll - currentScroll <= _scrollThreshold) {
//      _mangaByGenreBloc.add(FetchMangByGenre(endpoint: widget.endpoint));
//    }
  }

  @override
  void initState() {
    super.initState();
    _mangaByGenreBloc = BlocProvider.of<MangaByGenreBloc>(context)
      ..add(InitialMangaByGenreEvent(endpoint: widget.endpoint));
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MyBody(
      onSearch: () {
        Navigator.pushNamed(context, '/search');
      },
      onRefresh: () {
        _mangaByGenreBloc = BlocProvider.of<MangaByGenreBloc>(context)
          ..add(InitialMangaByGenreEvent(endpoint: widget.endpoint));
      },
      title: Text(
        '${widget.endpoint[0].toUpperCase()}${widget.endpoint.substring(1, widget.endpoint.length - 1)}',
        style: TextStyle(color: BaseColor.black),
      ),
      body: BlocConsumer<MangaByGenreBloc, MangaByGenreState>(
        listener: (context, state) {
          if (state is MangaByGenreFailureState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: const Text('Njir bruh, gk ada paketan kah ?')));
          }
        },
        builder: (context, state) {
          print(state);
          if (state is MangaByGenreLoadingState ||
              state is MangaByGenreFailureState) {
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
          } else if (state is MangaByGenreLoadedState) {
            if (state.list.isEmpty) {
              return Text('no manga');
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.list.length
                  : state.list.length + 1,
              itemBuilder: (context, i) {
//                print('list ${state.list.length}');
//                print('index $i');
                print('max ? ${state.hasReachedMax}');
                return i >= state.list.length
                    ? BottomLoader()
                    : ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/detailmanga',
                              arguments: state.list[i].endpoint);
                        },
                        subtitle: Text(
                          state.list[i].type,
                          style: TextStyle(
                              color: mangaTypeColor(state.list[i].type)),
                        ),
                        leading: Image.network(
                          state.list[i].thumb ??
                              'https://webhostingmedia.net/wp-content/uploads/2018/01/http-error-404-not-found.png',
                          height: MediaQuery.of(context).size.height,
                          width: 200.w,
                          fit: BoxFit.cover,
                        ),
                        title: Text(state.list[i].title.length >= 30
                            ? '${state.list[i].title.substring(0, 30)}..'
                            : state.list[i].title),
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
