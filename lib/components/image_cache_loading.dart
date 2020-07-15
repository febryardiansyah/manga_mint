import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mangamint/constants/base_color.dart';

class ImageCacheLoading extends StatelessWidget {
  final String imgUrl;
  final ImageWidgetBuilder imageBuilder;
  final double width, height;

  const ImageCacheLoading({Key key, this.imgUrl, this.imageBuilder,
  this.height,this.width})
      : assert(imgUrl != null),
        assert(imageBuilder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imgUrl,
        height: height ?? 300.h,
        width: width ?? 300.w,
        errorWidget: (context, i, _) => Center(
              child: Icon(Icons.error),
            ),
        placeholder: (context, _) => Center(
              child: SpinKitRipple(
                color: BaseColor.red,
              ),
            ),
        imageBuilder: imageBuilder);
  }
}
