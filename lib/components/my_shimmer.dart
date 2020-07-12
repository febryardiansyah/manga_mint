import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  final Widget child;

  const MyShimmer({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(child:child ,baseColor: BaseColor.grey2,
      highlightColor: Colors.white,);
  }
}
