import 'package:flutter/material.dart';
import 'package:mangamint/constants/base_color.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _txtEditingCtrl = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _txtEditingCtrl.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.grey1,
      appBar: AppBar(
        elevation: 0,
        title: TextFormField(
          autofocus: true,
          controller: _txtEditingCtrl,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.go,
          onFieldSubmitted: (value){
            print(value);
            Navigator.pushNamed(context, '/result',arguments: value);
          },
          decoration: InputDecoration(
            hintText: 'Cari manga kesuakaan mu ..',
            border: InputBorder.none,
            suffix:FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              child: Text('Clear'),
              onPressed: (){
                _txtEditingCtrl.clear();
              },
            )
          ),
        ),
      ),
      body: Center(),
    );
  }
}
