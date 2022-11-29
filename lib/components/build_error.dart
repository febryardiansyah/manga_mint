import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangamint/constants/base_color.dart';

class BuildError extends StatelessWidget {
  final String msg;
  final Function onRefresh;

  const BuildError({Key key, this.msg, this.onRefresh}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            msg ??
                'Njir, mungkin server bermasalah\nklo gk lu gk ada paketan 😞',
            textAlign: TextAlign.center,
          ),
          Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: BaseColor.green,
                    ),
                    child: Text(
                      'Kembali',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: BaseColor.green,
                    ),
                    child: Text(
                      'Muat ulang cuy !!',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: onRefresh,
                  )
                ],
              ))
        ],
      )),
    );
  }
}
