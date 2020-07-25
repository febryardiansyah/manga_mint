import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/screens/lainnya_screen/detail_lainnya.dart';
import 'package:mangamint/screens/lainnya_screen/privacy.dart';
import 'package:mangamint/screens/lainnya_screen/tos.dart';
import 'package:url_launcher/url_launcher.dart';

class LainnyaScreen extends StatefulWidget {
  @override
  _LainnyaScreenState createState() => _LainnyaScreenState();
}

class _LainnyaScreenState extends State<LainnyaScreen> {
  List<_listTileModel> _list = [
    _listTileModel(
      onPressed: (){
      },
      leading: Icons.assignment_late,
      title: 'Privacy Policy'
    ),
    _listTileModel(
      onPressed: (){},
      leading: Icons.assignment,
      title: 'Terms & Conditions'
    ),
    _listTileModel(
      onPressed: (){},
      leading: Icons.info,
      title: 'About this app'
    ),
  ];

  List<_sosmedModel> sosmedList = [
    _sosmedModel(
      icon: FontAwesomeIcons.facebook,
      onTap: ()async{
        await launch('https://www.facebook.com/febry.ardiansyah.792/urlString');
      }
    ),
    _sosmedModel(
        icon: FontAwesomeIcons.instagram,
        onTap: ()async{
          await launch('https://instagram.com/febry_ardiansyah24');
        }
    ),
    _sosmedModel(
        icon: FontAwesomeIcons.youtube,
        onTap: ()async{
          await launch('https:/youtube.com/muhammadfebry');
        }
    )
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return Scaffold(
      body: Column(
        children: [
          _topBar(context),
          _buildListTile(),
          Spacer(),
          _aboutDeveloper(context)
        ],
      ),
    );
  }

  Widget _topBar(BuildContext context){
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 600.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/tenkinokowp.png'),
              fit: BoxFit.fill
            )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 200.h),
          child: Center(
            child: Container(
              height: 170.h,
              width: 650.h,
              child: Center(child: Text('MangaMint',style: GoogleFonts.modak(color: BaseColor.red,fontSize: 30,),)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          child: Image.asset('assets/images/aqua-chibi.png',
          fit: BoxFit.fill,height: 100,width: 100,),
        )
      ],
    );
  }

  Widget _buildListTile()=>ListView.separated(
   itemCount: _list.length,
    physics: ClampingScrollPhysics(),
    shrinkWrap: true,
    separatorBuilder: (context,i) => Divider(color: BaseColor.grey2,height: 0,),
    itemBuilder:(context,i)=> ListTile(
      title: Text(_list[i].title,style: TextStyle(color: BaseColor.black),),
      onTap: (){
        if(_list[i].title == 'Privacy Policy'){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => DetailLainnya(
             title: 'Privacy Policy',
              body: PRIVACY,
            ),
            fullscreenDialog: true
          ));
        }else if(_list[i].title == 'Terms & Conditions'){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => DetailLainnya(
                title: 'Terms & Conditions',
                body: TOS,
              ),
              fullscreenDialog: true
          ));
        }else{
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => DetailLainnya(
                title: 'About This App',
                body: ABOUT_THIS_APP,
              ),
              fullscreenDialog: true
          ));
        }
      },
      leading: Icon(_list[i].leading,color: BaseColor.black,),
    ),
  );

  Widget _aboutDeveloper(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('dikembangkan oleh'),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/aqua.JPG',width: 200.h,
              height: 200.w,fit: BoxFit.cover,),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Febry Ardiansyah',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text('Febry#4750 ~ Discord')
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sosmedList.map((e) => IconButton(
            onPressed: e.onTap,
            icon: FaIcon(e.icon,size: 20,),
          )).toList(),
        )
      ],
    );
  }
}
class _sosmedModel{
  IconData icon;
  Function onTap;

  _sosmedModel({this.icon, this.onTap});
}
class _listTileModel{
  String title;
  Function onPressed;
  IconData leading;

  _listTileModel({this.title, this.onPressed, this.leading});
}

const String ABOUT_THIS_APP = '''MangaMint adalah aplikasi baca manga dan komik bahasa indonesia yang memiliki fitur seperti aplikasi manga lainnya, 
tujuan membuat aplikasi ini karena emang lagi gabut aja. Gak ada niatan pengen jadi top 1 aplikasi manga atau semacamnya, kalo ada yang pake ya sykur kalo
enggak ada ya pake sendiri hahahah 🤣''';