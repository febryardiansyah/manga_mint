import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mangamint/bloc/search_bloc/bloc.dart';
import 'package:mangamint/components/my_body.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/helper/color_manga_type.dart';

class ResultScreen extends StatefulWidget {
  final String query;

  ResultScreen({this.query});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  SearchBlocBloc _searchBlocBloc;
  @override
  void initState() {
    super.initState();
    _searchBlocBloc = BlocProvider.of<SearchBlocBloc>(context)..add(FetchSearch(query: widget.query));
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MyBody(
      showSearch: false,
      showRefresh: false,
      title: Text('Hasil Pencarian ${widget.query}',style: TextStyle(color: BaseColor.black),),
      body: BlocBuilder<SearchBlocBloc,SearchBlocState>(
        builder: (context,state){
          if(state is SearchLoadingState){
            return Center(
              child: SpinKitCubeGrid(color: BaseColor.red,),
            );
          }else if (state is SearchLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                separatorBuilder: (context,index)=>Divider(color: BaseColor.grey2,),
                itemCount: state.searchList.length,
                itemBuilder: (context,i){
                  return ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, '/detailmanga',arguments: state.searchList[i].endpoint);
                    },
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.searchList[i].type,style: TextStyle(
                            color: mangaTypeColor(state.searchList[i].type)
                        ),),
                        Text(state.searchList[i].updated_on,style: TextStyle(
                            color: BaseColor.grey1
                        ),),
                      ],
                    ),
                    leading: Image.network(
                      state.searchList[i].thumb,
                      height: MediaQuery.of(context).size.height,
                      width: 200.w,
                      fit: BoxFit.cover,
                    ),
                    title: Text(state.searchList[i].title.length >= 30 ?'${
                        state.searchList[i].title.substring(0,30)
                    }..':state.searchList[i].title),

                  );
                },
              ),
            );
          }else if(state is SearchFailureState){
            return Center(child: Text('kosong gan'));
          }
          return Container();
        },
      ),
    );
  }

}