import 'package:flutter/material.dart';
import 'package:mangamint/repositories/recommended_repo.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      body: Center(
        child: Text('splashscreen'),
      ),
    );
  }
}
