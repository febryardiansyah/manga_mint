import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mangamint/constants/base_color.dart';

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        color: BaseColor.red,
      ),
    );
  }
}
