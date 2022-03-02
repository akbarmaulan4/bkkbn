import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/util/local_data.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../widgets/font/avenir_text.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  AuthBloc bloc = new AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupPlayerId();
    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    bloc.loginSucces.listen((event) {
      if(event != null){
        if(event){
          Navigator.popAndPushNamed(context, '/home', arguments: {'loadFirstMenu':0});
        }
      }
    });
  }

  is5Inc(){
    var size = MediaQuery.of(context).size;
    if(size.height < 650){
      return true;
    }else{
      return false;
    }
  }

  void setupPlayerId() async {
    var hasPlayerId = await LocalData.getPlayerId();
    if (hasPlayerId == null) {
      var status = await OneSignal.shared.getPermissionSubscriptionState();
      var playerId = status.subscriptionStatus.userId;
      bloc.setPlayerId(playerId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return Scaffold(
      body: MediaQuery(
        data: scaleFactor,
        child: Container(
          color: Colors.white,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: is5Inc() ? size.height * 0.25 : size.height * 0.28),
                Stack(
                  children: [
                    Image.asset(ImageConstant.logoElsimil, height: 80,),
                    Positioned(
                      right: 0,
                      child: Image.asset(ImageConstant.logo, height: 30),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.07),
                TextAvenir(
                  'Email atau No. Telepon',
                  size: 14,
                  color: Utils.colorFromHex(ColorCode.bluePrimary),
                ),
                SizedBox(height: 5),
                BoxBorderDefault(
                    child: TextField(
                      controller: bloc.edtUsername,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email atau No Telepon anda',
                          hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                          contentPadding: EdgeInsets.only(bottom:16)
                      ),
                    )
                ),
                SizedBox(height: 15),
                TextAvenir(
                  'Kata Sandi',
                  size: 14,
                  color: Utils.colorFromHex(ColorCode.bluePrimary),
                ),
                SizedBox(height: 5),
                StreamBuilder(
                    stream: bloc.typing,
                    builder: (context, snapshot) {
                      var type = false;
                      if(snapshot.data != null){
                        type = snapshot.data;
                      }
                      return BoxBorderDefault(
                          child: StreamBuilder(
                              stream: bloc.showPass,
                              builder: (context, snapshot) {
                                var showPass = false;
                                if(snapshot.data != null){
                                  showPass = snapshot.data;
                                }
                                return TextField(
                                  controller: bloc.edtPassword,
                                  textAlignVertical: TextAlignVertical.center,
                                  obscureText: showPass ? false : true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Kata sandi',
                                      hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                      suffixIcon: type ? InkWell(
                                          onTap: ()=>bloc.showPassword(!showPass),
                                          child: Icon(Icons.remove_red_eye, size: 20, color: Colors.grey)):SizedBox()
                                  ),
                                  onChanged: (val){
                                    if(val.length > 0){
                                      bloc.passTyping(true);
                                    }else{
                                      bloc.passTyping(false);
                                    }
                                  },
                                );
                              }
                          )
                      );
                    }
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: ()=>Navigator.pushNamed(context, '/forgot_password'),
                          child: Container(
                            alignment: Alignment.centerRight,
                            // padding: EdgeInsets.only(right: 10),
                            margin: EdgeInsets.only(top: 10),
                            child: TextAvenir(
                              'Lupa kata sandi?',
                              size: 14,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: is5Inc() ? size.height * 0.15 : size.height * 0.12,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        color: Colors.white,
        child: InkWell(
          onTap: ()=> bloc.validasiLogin(context),
          child: Container(
            decoration: ConstantStyle.boxShadowButon(
                color: Utils.colorFromHex(ColorCode.blueSecondary),
                radius: 10,
                spreadRadius: 2,
                blurRadius: 7,
                colorShadow: Utils.colorFromHex(ColorCode.lightGreyElsimil),
                offset: Offset(0, 0)
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: TextAvenir(
              'Masuk',
              size: 20,
              color: Colors.white,
            )),
          ),
        ),
    );
  }
}
