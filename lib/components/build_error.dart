import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangamint/constants/base_color.dart';

class BuildError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text('Njir, mungkin server bermasalah\nklo gk lu gk ada paketan 😞',textAlign: TextAlign.center,),
           FlatButton(
             child: Text('Kembali',style: TextStyle(color: Colors.white),),
             color: BaseColor.red,
             onPressed: (){
               Navigator.pop(context);
             },
           )
         ],
        )
      ),
    );
  }
}
