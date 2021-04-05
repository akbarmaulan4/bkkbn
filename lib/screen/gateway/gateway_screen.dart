import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';
import 'dart:math' as math;

class GatewayScreen extends StatefulWidget {
  @override
  _GatewayScreenState createState() => _GatewayScreenState();
}

class _GatewayScreenState extends State<GatewayScreen> {

  // delay() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.location,
  //     Permission.storage,
  //     // Permission.phone,
  //   ].request();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // PermissionActions
  }

  is5Inc(){
    var size = MediaQuery.of(context).size;
    if(size.height < 650){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        // color: Utils.colorFromHex(ColorCode.bluePrimary),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bgElsimil),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.20),
                    Stack(
                      children: [
                        Image.asset(ImageConstant.logoElsimil, height: 80,),
                        Positioned(
                          right: 0,
                          child: Image.asset(ImageConstant.logo, height: 30),
                        ),
                      ],
                    ),
                  ],
                )
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: size.height * 0.20,
                          color: Utils.colorFromHex(ColorCode.bluePrimary),
                        )
                    ),
                  ),
                  Container(
                    // height: size.height * 0.50,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: is5Inc() ? 30 : 60),
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageConstant.bgEllips),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: is5Inc() ? 50 : 45),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: ConstantStyle.boxShadowButon(
                                  radius: 5,
                                  color: Colors.white,
                                  colorShadow: Utils.colorFromHex(ColorCode.lightBlueDark),
                                  spreadRadius: 1.5,
                                  blurRadius: 4,
                                  offset: Offset(0,0)
                              ),
                              child: TextAvenir(
                                'Masuk ke Aplikasi',
                                size: is5Inc() ? 17 : 20,
                                color: Utils.colorFromHex(ColorCode.bluePrimary),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
                          TextAvenir(
                            'Belum punya akun?',
                            size: 12,
                            color: Utils.colorFromHex(ColorCode.lightGreyElsimil),
                          ),
                          SizedBox(height: size.height * 0.05),
                          InkWell(
                            onTap: () {
                              Navigator.popAndPushNamed(context, '/register');
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: ConstantStyle.boxButton(
                                color: Utils.colorFromHex(ColorCode.blueSecondary),
                                radius: 5
                              ),
                              child: TextAvenir(
                                'Registrasi',
                                size: is5Inc() ? 17 : 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: is5Inc() ?  size.height * 0.04 : size.height * 0.06),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  screen5inc(){
    return Container(

    );
  }
}
