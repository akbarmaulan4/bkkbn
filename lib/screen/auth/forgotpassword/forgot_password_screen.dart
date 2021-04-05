import 'package:flutter/material.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';
import 'package:kua/widgets/box_border.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  AuthBloc bloc = new AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    bloc.forgotPass.listen((event) {
      if(event != null){
        Utils.infoDialog(context, 'informasi', event, () {
          Navigator.popAndPushNamed(context, '/otp_password');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextAvenir(
          'Lupa Kata Sandi',
          size: 20,
          color: Utils.colorFromHex(ColorCode.bluePrimary),
        ),
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: ()=>Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))),
        bottom: PreferredSize(
            child: Container(
              color: Utils.colorFromHex(ColorCode.lightBlueDark),
              height: 1,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            TextAvenir(
              'Silahkan isi email yang didaftarkan.',
              size: 16,
              color: Colors.grey,
            ),
            SizedBox(height: 3),
            TextAvenir(
              'Link untuk memperbaharui kata sandi akan dikirim',
              size: 16,
              color: Colors.grey,
            ),
            SizedBox(height: 3),
            TextAvenir(
              'ke alamat email tersebut.',
              size: 16,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            TextAvenir(
              'Alamat email',
              size: 14,
              color: Utils.colorFromHex(ColorCode.bluePrimary),
            ),
            SizedBox(height: 5),
            BoxBorderDefault(
                child: TextField(
                  controller: bloc.edtForgotPassword,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: ConstantStyle.decorTextField,
                )
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.11,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        color: Colors.white,
        child: InkWell(
          onTap: (){
            bloc.forgotPassword(context);
          },
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
                'Kirim',
                size: 20,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
