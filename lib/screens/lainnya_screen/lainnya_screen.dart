import 'package:flutter/material.dart';
import 'package:mangamint/components/my_body.dart';
import 'package:mangamint/constants/base_color.dart';

class LainnyaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyBody(
      title: Text('Lainnya',style: TextStyle(color: BaseColor.black),),
      showRefresh: false,
    );
  }
}
