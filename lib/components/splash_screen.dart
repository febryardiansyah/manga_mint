import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangamint/constants/base_color.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime()async{
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, '/navbar');
    });
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                ),
                Positioned(
                  top: 20,
                    left: 240.w,
                    child: Text('MangaKah ?',style: TextStyle(color: BaseColor.grey1),)),
                Positioned(
                  right: 20,
                    top: 0,
                    child: Image.asset('assets/images/aqua-chibi.png',fit: BoxFit.fill,height: 100,width: 100)),
                Text('MangaMint',style: GoogleFonts.modak(
                  color: BaseColor.red,fontSize: 45
                ),),
              ],
            ),
            Text('Baca Manga & Komik\nBahasa Indonesia',textAlign: TextAlign.center,),
            SizedBox(height: 40,),
            SpinKitThreeBounce(color: BaseColor.red,size: 30,)
          ],
        )
      ),
    );
  }
}
