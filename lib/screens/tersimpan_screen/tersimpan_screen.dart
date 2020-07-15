import 'package:flutter/cupertino.dart';
import 'package:mangamint/components/my_body.dart';
import 'package:mangamint/constants/base_color.dart';

class TersimpanScreen extends StatefulWidget {
  @override
  _TersimpanScreenState createState() => _TersimpanScreenState();
}

class _TersimpanScreenState extends State<TersimpanScreen> {
  @override
  Widget build(BuildContext context) {
    return MyBody(
      title: Text('Tersimpan',style: TextStyle(color: BaseColor.black,fontWeight: FontWeight.bold),),
    );
  }
}
