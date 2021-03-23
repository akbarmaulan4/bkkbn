import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bgLogin),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.10),
                    Image.asset(ImageConstant.logoPutih, height: 70,),
                  ],
                )
            ),
            Expanded(
                flex: 2,
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
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white
                        ),
                        child: TextAvenir(
                          'Masuk ke Aplikasi',
                          size: 20,
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
                        decoration: BoxDecoration(
                            color: Utils.colorFromHex(ColorCode.bluePrimary),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: TextAvenir(
                          'Registrasi',
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.08),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
