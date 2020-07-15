import 'package:flutter/material.dart';
import 'package:mangamint/constants/base_color.dart';

class MyBody extends StatelessWidget {
  final Widget title;
  final Widget body;
  final GestureTapCallback onRefresh;
  final PreferredSizeWidget bottomAppBar;
  final bool showRefresh;

  const MyBody({Key key, this.title, this.body, this.onRefresh,this.bottomAppBar,
  this.showRefresh = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: bottomAppBar,
        title: title,
        actions: [
          showRefresh?IconButton(
            onPressed: onRefresh,
            icon: Icon(Icons.refresh),
          ):Center(),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: body,
    );
  }
}


