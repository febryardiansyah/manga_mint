import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangamint/bloc/popular_bloc/bloc.dart';
import 'package:mangamint/components/bottom_loader.dart';
import 'package:mangamint/components/build_error.dart';
import 'package:mangamint/components/item_small.dart';
import 'package:mangamint/components/my_body.dart';
import 'package:mangamint/components/my_shimmer.dart';
import 'package:mangamint/constants/base_color.dart';

class TerpopulerScreen extends StatefulWidget {
  TerpopulerScreen({Key key}) : super(key: key);

  @override
  _TerpopulerScreenState createState() => _TerpopulerScreenState();
}

class _TerpopulerScreenState extends State<TerpopulerScreen> {
  PopularBloc _popularBloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  @override
  void initState() {
    super.initState();
    _popularBloc = BlocProvider.of<PopularBloc>(context);
    _scrollController.addListener(_onScroll);
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return BlocBuilder<PopularBloc,PopularState>(
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
          return MyBody(
            showRefresh: false,
            title: Text('Terpopuler',style: TextStyle(color: BaseColor.black,fontWeight: FontWeight.bold),),
            body: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Scrollbar(
                child: GridView.builder(
                  itemCount: state.hasReachedMax?state.popularList.length:state.popularList.length,
                  shrinkWrap: true,
                  controller: _scrollController,
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 0.7
                  ),
                  itemBuilder: (context,i){
                    var data = state.popularList[i];
                    return i >= state.popularList.length?BottomLoader()
                    :InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/detailmanga',arguments:
                        state.popularList[i].endpoint);
                      },
                      child: ItemSmall(
                        title: data.title,
                        subtitle: data.type ?? '',
                        bottom: data.upload_on  ?? '',
                        thumb: data.thumb ?? '',
                        onTap: (){
                          Navigator.pushNamed(context, '/detailmanga',arguments: data.endpoint);
                        },
                      )
                    );
                  },
                ),
              ),
            ),
          );
        } else if (state is PopularFailureState) {
          return BuildError();
        }
        return Container();
      },
    );
  }
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _popularBloc.add(FetchPopular());
    }
  }
}