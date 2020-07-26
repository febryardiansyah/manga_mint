import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangamint/components/image_cache_loading.dart';
import 'package:mangamint/constants/base_color.dart';

class ItemSmall extends StatelessWidget {
  final String title, thumb, subtitle, bottom;
  final GestureTapCallback onTap;

  ItemSmall({this.title, this.thumb, this.subtitle, this.bottom,this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.init();
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: ImageCacheLoading(
                  imgUrl: thumb,
                  imageBuilder: (context,imgProvider){
                    return Container(
                      height: 300.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imgProvider,
                              fit: BoxFit.fill
                          )
                      ),
                    );
                  },
                )),
            SizedBox(height: 10,),
            Text(
              title.length > 15 ? '${title.substring(0, 15)}..' : title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(subtitle,style: TextStyle(color: BaseColor.red),),
            Expanded(child: Text(bottom,style: TextStyle(color: BaseColor.grey1),))
          ],
        ),
      ),
    );
  }
}
