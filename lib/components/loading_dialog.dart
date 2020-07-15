import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mangamint/constants/base_color.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        height: 100,
        width: 100,
        child: SpinKitPouringHourglass(color: BaseColor.red,),
      ),
    );
  }
}
