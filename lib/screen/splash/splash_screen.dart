import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/util/local_data.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delay();
  }

  delay() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.phone,
    ].request();

    Future.delayed(Duration(milliseconds: 4000), () {
      checkUser();
    });
  }


  checkUser() async{
    var user = await LocalData.getUser();
    if(user.id != null){
      Navigator.popAndPushNamed(context, '/home', arguments: {'loadFirstMenu':0});
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
        ImageConstant.logoElsimil,
        width: 70),
    );
  }
}
