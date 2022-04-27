import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/debouncher.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterData extends StatefulWidget {
  AuthBloc bloc;
  RegisterData({this.bloc});
  @override
  _NewRegisterScreenState createState() => _NewRegisterScreenState();
}

class _NewRegisterScreenState extends State<RegisterData> {

  //contoh
  GoogleSignIn _googleSignIn = GoogleSignIn();
  signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    if(googleSignInAuthentication != null){
      widget.bloc.edtEmail.text = googleSignInAccount.email;
      widget.bloc.edtNamaLengkap.text = googleSignInAccount.displayName;
      // Utils.alertError(context, 'Berhasil masuk dengan akun google ${googleSignInAccount.displayName}', () { });
      // FirebaseUser user = await _auth.signInWithGoogle(
      //     accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);
    }
    return googleSignInAuthentication != null ? 'sukses':'';
  }
  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleSignOut();
    widget.bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    widget.bloc.emailPass.listen((event) {
      if(event != null){
        if(event){
          widget.bloc.changeViewRegist(1);
        }
      }
    });

    widget.bloc.emailHasTaken.listen((event) {
      if(event != null){
        // Utils.dialogInfo(context: context, title: event, ok: () {
        //   FocusScope.of(context).requestFocus(new FocusNode());
        // });
        FocusScope.of(context).requestFocus(new FocusNode());
        Utils.showDialogEmail(
          context: context,
          title: "Peringatan",
          message: event,
          onNext: ()=>widget.bloc.changeViewRegist(1)
        );
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


  var debouncher = new Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: scaleFactor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextAvenir(
              'Nama Lengkap',
              size: 14,
              color: Utils.colorFromHex(ColorCode.bluePrimary),
            ),
            SizedBox(height: 5),
            BoxBorderDefault(
                child: TextField(
                  controller: widget.bloc.edtNamaLengkap,
                  textAlignVertical: TextAlignVertical.center,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                    LengthLimitingTextInputFormatter(30)],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nama lengkap sesuai KTP',
                    hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                    contentPadding: EdgeInsets.only(bottom:16)
                  ),
                )
            ),
            SizedBox(height: 15),
            TextAvenir(
              'No Telepon',
              size: 14,
              color: Utils.colorFromHex(ColorCode.bluePrimary),
            ),
            SizedBox(height: 5),
            BoxBorderDefault(
                child: Row(
                  children: [
                    Text('+62', style: TextStyle(fontSize: 16), textScaleFactor: 1.0,),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: widget.bloc.edtNoTlp,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                          new BlacklistingTextInputFormatter(
                              new RegExp('[\\-|\\,|\\.|\\#|\\*]')),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom:15)
                        ),
                        onChanged: (val){
                          debouncher.run(() {
                            if(val[0] == '0'){
                              widget.bloc.edtNoTlp.text = val.substring(1);
                              var str = widget.bloc.edtNoTlp.text;
                              // widget.bloc.edtNoTlp.text = val;
                              widget.bloc.edtNoTlp.selection = TextSelection.fromPosition(TextPosition(offset: str.length));
                            }
                          });
                          // if(val[0] == '0'){
                          //   widget.bloc.edtNoTlp.text = val.replaceFirst(new RegExp(r'^0+'), '');
                          //   FocusScope.of(context).requestFocus(FocusNode());
                          // }
                        },
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 15),
            TextAvenir(
              'Email',
              size: 14,
              color: Utils.colorFromHex(ColorCode.bluePrimary),
            ),
            SizedBox(height: 5),
            BoxBorderDefault(
                child: TextField(
                  controller: widget.bloc.edtEmail,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email aktif anda',
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
              stream: widget.bloc.typingPass,
              builder: (context, snapshot) {
                var type = false;
                if(snapshot.data != null){
                  type = snapshot.data;
                }
                return BoxBorderDefault(
                    child: StreamBuilder(
                      stream: widget.bloc.showPassData,
                      builder: (context, snapshot) {
                        var showPass = false;
                        if(snapshot.data != null){
                          showPass = snapshot.data;
                        }
                        return TextField(
                          controller: widget.bloc.edtPass,
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: showPass ? false : true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Kata sandi minimal 4 digit karakter',
                            hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                            suffixIcon: type ? InkWell(
                              onTap: ()=>widget.bloc.openPassData(!showPass),
                                child: Icon(Icons.remove_red_eye, size: 20, color: Colors.grey)):SizedBox()
                          ),
                          onChanged: (val){
                            if(val.length > 0){
                              widget.bloc.passDataTyping(true);
                            }else{
                              widget.bloc.passDataTyping(false);
                            }

                          },
                        );
                      }
                    )
                );
              }
            ),
            SizedBox(height: 15),
            TextAvenir(
              'Ulangi Kata Sandi',
              size: 14,
              color: Utils.colorFromHex(ColorCode.bluePrimary),
            ),
            SizedBox(height: 5),
            StreamBuilder(
              stream: widget.bloc.typingRePass,
              builder: (context, snapshot) {
                var type = false;
                if(snapshot.data != null){
                  type = snapshot.data;
                }
                return BoxBorderDefault(
                    child: StreamBuilder(
                      stream: widget.bloc.showRePassData,
                      builder: (context, snapshot) {
                        var showPass = false;
                        if(snapshot.data != null){
                          showPass = snapshot.data;
                        }
                        return TextField(
                          controller: widget.bloc.edtRePass,
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: showPass ? false : true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ulangi Kata sandi',
                            hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                            suffixIcon: type ? InkWell(
                              onTap: ()=>widget.bloc.openRePassData(!showPass),
                                child: Icon(Icons.remove_red_eye, size: 20, color: Colors.grey)):SizedBox()
                          ),
                          onChanged: (val){
                            if(val.length > 0){
                              widget.bloc.rePassDataTyping(true);
                            }else{
                              widget.bloc.rePassDataTyping(false);
                            }
                          },
                        );
                      }
                    )
                );
              }
            ),
            // quiz,
            SizedBox(height: 40),
            InkWell(
              onTap: (){
                // var dasdsa = quiz.takeAnswer();
                // String sds = quiz.answerTxt;
                widget.bloc.validasiDataUser();
                // widget.bloc.changeViewRegist(1);
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: ConstantStyle.boxShadowButon(
                  color: Utils.colorFromHex(ColorCode.blueSecondary),
                  radius: 10,
                  spreadRadius: 2,
                  blurRadius: 7,
                  colorShadow: Utils.colorFromHex(ColorCode.lightGreyElsimil),
                  offset: Offset(0, 0)
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Center(
                  child: TextAvenir(
                    'Lanjutkan',
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: ()=> signInGoogle(),
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(ImageConstant.google),
                    SizedBox(width: 10),
                    TextAvenir(
                      'Daftar dengan Google',
                      size: 17,
                      color: Utils.colorFromHex(ColorCode.colorGreyText)
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: is5Inc() ? 30:0,)
          ],
        ),
      ),
    );
  }
}
