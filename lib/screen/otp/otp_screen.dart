import 'package:flutter/material.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/widgets/avenir_text.dart';
import 'package:kua/widgets/box_border.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  AuthBloc bloc = new AuthBloc();
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
              color: Colors.grey[300],
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
              'Silahkan isi masukan kode OTP',
              size: 16,
              color: Colors.grey,
            ),
            SizedBox(height: 3),
            TextAvenir(
              'yang telaj dikirim ke email anda.',
              size: 16,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            TextAvenir(
              'Kode OTP',
              size: 14,
              color: Utils.colorFromHex(ColorCode.bluePrimary),
            ),
            SizedBox(height: 5),
            BoxBorderDefault(
                child: TextField(
                  controller: bloc.edtForgotPassword,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // hintText: 'NIK(KTP/SIM)'
                  ),
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
          // onTap: ()=>Navigator.popAndPushNamed(context, '/home'),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Utils.colorFromHex(ColorCode.blueSecondary)
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
