import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/util/local_data.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 4000), () {
      // Utility.saveFromLogin('N');
      // if (firstTime && user == null) {
      //   Navigator.popAndPushNamed(context, '/intro');
      // } else {
      //   goToMain();
      // }
      checkUser();
    });
  }


  checkUser() async{
    var user = await LocalData.getUser();
    if(user != null){
      Navigator.popAndPushNamed(context, '/home');
    }else{
      Navigator.popAndPushNamed(context, '/gateway');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40),
      color: Colors.white,
      child: Image.asset(
        ImageConstant.logo,
        width: 70),
    );
  }
}
