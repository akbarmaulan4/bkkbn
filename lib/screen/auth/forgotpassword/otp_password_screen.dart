import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class OTPPasswordScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPPasswordScreen> {
  AuthBloc bloc = new AuthBloc();
  FocusNode _focus1 = FocusNode();
  FocusNode _focus2 = FocusNode();
  FocusNode _focus3 = FocusNode();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
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
      body: MediaQuery(
        data: scaleFactor,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          color: Colors.white,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Center(
                  child: Column(
                    children: [
                      Image.asset(ImageConstant.icMailOpen, width: 100,),
                      TextAvenir(
                        'Silahkan check email anda',
                        size: 23,
                        color: Utils.colorFromHex(ColorCode.bluePrimary),
                      ),
                      SizedBox(height: 3),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                TextAvenirBook(
                  'Kami telah mengirimkan kode verifikasi ke Email anda.\nMohon check Inbox atau Spambox',
                  size: 16,
                  height: 1.5,
                  color: Colors.grey,
                ),
                SizedBox(height: 25),
                // Row(
                //   children: [
                //     TextAvenir(
                //       'Kode Verifikasi',
                //       size: 14,
                //       color: Utils.colorFromHex(ColorCode.bluePrimary),
                //     ),
                //     Expanded(child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Container(
                //           width: 25,
                //           height: 25,
                //           decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             border: Border.all(color: Colors.grey[300]),
                //           ),
                //           child: Icon(Icons.done, size: 14),
                //         ),
                //       ],
                //     ))
                //   ],
                // ),
                // SizedBox(height: 5),
                // Row(
                //   children: [
                //     Expanded(
                //       flex: 4,
                //       child: containerBox(
                //           TextField(
                //             textAlign: TextAlign.center,
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //             keyboardType: TextInputType.number,
                //             textInputAction: TextInputAction.next,
                //             decoration: InputDecoration(
                //               border: InputBorder.none,
                //             ),
                //             onChanged: (val){
                //               if(val.length > 0){
                //                 val = val.substring(0);
                //                 FocusScope.of(context).requestFocus(_focus1);
                //               }
                //             },
                //           )
                //       )
                //     ),
                //     SizedBox(width: 10),
                //     Expanded(
                //       flex: 4,
                //       child: containerBox(
                //           TextField(
                //             focusNode: _focus1,
                //             textAlign: TextAlign.center,
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //             keyboardType: TextInputType.number,
                //             textInputAction: TextInputAction.next,
                //             decoration: InputDecoration(
                //               border: InputBorder.none,
                //             ),
                //             onChanged: (val){
                //               if(val.length > 0){
                //                 val = val.substring(0);
                //                 FocusScope.of(context).requestFocus(_focus2);
                //               }
                //             },
                //           )
                //       )
                //     ),
                //     SizedBox(width: 10),
                //     Expanded(
                //       flex: 4,
                //       child: containerBox(
                //           TextField(
                //             focusNode: _focus2,
                //             textAlign: TextAlign.center,
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //             keyboardType: TextInputType.number,
                //             textInputAction: TextInputAction.next,
                //             decoration: InputDecoration(
                //               border: InputBorder.none
                //             ),
                //             onChanged: (val){
                //               if(val.length > 0){
                //                 val = val.substring(0);
                //                 FocusScope.of(context).requestFocus(_focus3);
                //               }
                //             },
                //           )
                //       )
                //     ),
                //     SizedBox(width: 10),
                //     Expanded(
                //       flex: 4,
                //       child: containerBox(
                //           TextField(
                //             focusNode: _focus3,
                //             textAlign: TextAlign.center,
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //             keyboardType: TextInputType.number,
                //             textInputAction: TextInputAction.done,
                //             decoration: InputDecoration(
                //               border: InputBorder.none,
                //             ),
                //             onChanged: (val){
                //               if(val.length > 0){
                //                 val = val.substring(0);
                //                 FocusScope.of(context).requestFocus(FocusNode());
                //               }
                //             }
                //           ),
                //       )
                //     )
                //   ],
                // ),
                // SizedBox(height: 20),
                // TextAvenir(
                //   'Kata Sandi Baru',
                //   size: 14,
                //   color: Utils.colorFromHex(ColorCode.bluePrimary),
                // ),
                // SizedBox(height: 5),
                // BoxBorderDefault(
                //     child: TextField(
                //       controller: bloc.edtForgotPassword,
                //       textAlignVertical: TextAlignVertical.center,
                //       decoration: InputDecoration(
                //         border: InputBorder.none,
                //         // hintText: 'NIK(KTP/SIM)'
                //       ),
                //     )
                // ),
                // SizedBox(height: 20),
                // TextAvenir(
                //   'Ulangi Kata Sandi Baru',
                //   size: 14,
                //   color: Utils.colorFromHex(ColorCode.bluePrimary),
                // ),
                // SizedBox(height: 5),
                // BoxBorderDefault(
                //     child: TextField(
                //       controller: bloc.edtForgotPassword,
                //       textAlignVertical: TextAlignVertical.center,
                //       decoration: InputDecoration(
                //         border: InputBorder.none,
                //         // hintText: 'NIK(KTP/SIM)'
                //       ),
                //     )
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.11,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        color: Colors.white,
        child: InkWell(
          onTap: ()=> Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false),
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
                'Selesai',
                size: 20,
                color: Colors.white,
              )),
        ),
      ),
    );
  }

  containerBox(Widget child){
    return Container(
      // padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.grey.shade300)
      ),
      child: child,
    );
  }
}
