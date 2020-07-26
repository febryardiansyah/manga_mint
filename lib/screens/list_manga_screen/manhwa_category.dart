import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangamint/bloc/manhuamanhwa/bloc.dart';
import 'package:mangamint/components/bottom_loader.dart';
import 'package:mangamint/components/build_error.dart';
import 'package:mangamint/components/my_shimmer.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/helper/color_manga_type.dart';

class ManhwaCategory extends StatefulWidget {
  ManhwaCategory({Key key}) : super(key: key);

  @override
  _ManhwaCategoryState createState() => _ManhwaCategoryState();
}

class _ManhwaCategoryState extends State<ManhwaCategory> {
  ManhuamanhwaBloc _manhuamanhwaBloc;
  final _scrollCtrl = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _manhuamanhwaBloc = BlocProvider.of<ManhuamanhwaBloc>(context)
    ..add(FetchManhwa());
    _scrollCtrl.addListener(() {
      final maxScroll = _scrollCtrl.position.maxScrollExtent;
      final currentScroll = _scrollCtrl.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold) {
        _manhuamanhwaBloc = BlocProvider.of<ManhuamanhwaBloc>(context);
        _manhuamanhwaBloc.add(FetchManhwa());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return Padding(
      padding: EdgeInsets.all(8),
      child: BlocBuilder<ManhuamanhwaBloc,ManhuamanhwaState>(
        builder: (context,state){
          if(state is ManhuaManhwaLoadingState){
            return MyShimmer(
              child: ListView.builder(
                itemCount: 10,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,i){
                  return ListTile(
                    leading: Container(
                      height: 100.h,
                      width: 200.w,
                      color: BaseColor.red,
                    ),
                    title: Container(
                      height: 100.h,
                      width:MediaQuery.of(context).size.width,
                      color: BaseColor.red,
                    ),
                  );
                },
              ),
            );
          }else if(state is ManhwaLoadedState){
            return Scrollbar(
              child: ListView.separated(
                separatorBuilder: (context,index)=>Divider(color: BaseColor.grey2,),
                itemCount: state.hasReachedMax
                    ? state.list.length
                    : state.list.length + 1,
                controller: _scrollCtrl,
                itemBuilder: (context, i) {
                  return i >= state.list.length
                      ? BottomLoader()
                      : ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, '/detailmanga',arguments:
                      state.list[i].endpoint);
                    },
                    title: Text(state.list[i].title.length > 20
                        ? '${state.list[i].title.substring(0, 20)}..'
                        : state.list[i].title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.list[i].type,style: TextStyle(
                            color: mangaTypeColor(state.list[i].type)
                        ),),
                        Text(state.list[i].updated_on,style: TextStyle(
                            color:BaseColor.grey1
                        ),),
                      ],
                    ),
                    leading: Image.network(
                      state.list[i].thumb,
                      height: MediaQuery.of(context).size.height,
                      width: 200.w,
                      fit: BoxFit.cover,
                    ),
                    trailing: SizedBox(
                      height: 100.h,
                      width: 200.w,
                      child: Text(
                        state.list[i].chapter,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }else if(state is ManhuaManhwaFailureState){
            return BuildError();
          }
          return Container();
        },
      ),
    );
  }
}