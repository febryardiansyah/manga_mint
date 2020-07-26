import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangamint/bloc/bloc.dart';
import 'package:mangamint/components/my_body.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/screens/list_manga_screen/manhua_category.dart';
import 'package:mangamint/screens/list_manga_screen/manhwa_category.dart';
import 'package:mangamint/screens/list_manga_screen/semuanya_category.dart';

class indexMangaLIst extends StatefulWidget {
  @override
  _indexMangaLIstState createState() => _indexMangaLIstState();
}

class _indexMangaLIstState extends State<indexMangaLIst> {
  TabController _tabController;
  MangaListBloc _mangaListBloc;
  void _init_(){
    _mangaListBloc = BlocProvider.of<MangaListBloc>(context);
    _mangaListBloc.add(InitialFetchMangaEvent());
  }
  @override
  void initState() {
    super.initState();
    _init_();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MyBody(
        showRefresh: false,
        title: Text('Daftar Manga',style: TextStyle(color: BaseColor.black,fontWeight: FontWeight.bold),),
        bottomAppBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: TabBar(
              controller: _tabController,
              unselectedLabelColor: BaseColor.red,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              indicator: BoxDecoration(
                color: BaseColor.red,
                borderRadius: BorderRadius.circular(8),
              ),
              tabs: [
                Tab(text: 'Semuanya',),
                Tab(
                  text: 'Manhua',
                ),
                Tab(
                  text: 'Manhwa',
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SemuanyaCategory(),
            ManhuaCategory(),
            ManhwaCategory(),
          ],
        ),
      ),
    );
  }
}
