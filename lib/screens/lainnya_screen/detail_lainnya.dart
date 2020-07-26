import 'package:flutter/material.dart';
import 'package:mangamint/constants/base_color.dart';

class DetailLainnya extends StatelessWidget {
  final String title,body;

  DetailLainnya({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,style: TextStyle(color: BaseColor.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(child: Text(body,textAlign: TextAlign.justify,)),
      ),
    );
  }
}
