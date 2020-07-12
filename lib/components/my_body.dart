import 'package:flutter/material.dart';
import 'package:mangamint/constants/base_color.dart';

class MyBody extends StatelessWidget {
  final Widget title;
  final Widget body;
  final Function onRefresh;

  const MyBody({Key key, this.title, this.body, this.onRefresh}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: [
          IconButton(
            onPressed: onRefresh,
            icon: Icon(Icons.refresh),
          ),
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


