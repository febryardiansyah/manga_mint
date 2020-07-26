import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangamint/components/image_cache_loading.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/helper/color_manga_type.dart';

class ItemBig extends StatelessWidget {
  final itemCount, itemBuilder;
  final ScrollController controller;
  const ItemBig({Key key, this.itemCount, this.itemBuilder,this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.45),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

class ItemBigChild extends StatelessWidget {
  final String type, thumb, title, chapter, update;
  final GestureTapCallback onTap;

  const ItemBigChild(
      {Key key, this.type, this.thumb, this.title, this.chapter, this.update,this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.init();
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: ImageCacheLoading(
                  imgUrl: thumb,
                  imageBuilder: (context,imgProvider){
                    return Container(
                      height: 450.h,
                      width: size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: imgProvider,fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                child: Container(
                  height: 80.h,
                  width: 200.w,
                  color: mangaTypeColor(type),
                  child: Center(
                      child: Text(
                    type,
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              )
            ],
          ),
          Text(
            title.length > 20 ? '${title.substring(0, 20)}..' : title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            chapter,
            style: TextStyle(color: BaseColor.green),
          ),
          Expanded(
            child: Text(
              update,
              style: TextStyle(color: BaseColor.grey1),
            ),
          )
        ],
      ),
    );
  }
}