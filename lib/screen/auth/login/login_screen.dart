import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.28),
              Image.asset(ImageConstant.logo, height: size.height * 0.10,),
              SizedBox(height: size.height * 0.07),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  // color: Colors.blue[100]
                  border: Border.all(color: Colors.grey[300])
                ),
                padding: EdgeInsets.only(right: 25),
                child: TextField(
                  controller: bloc.edtUsername,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    fillColor: Colors.blue[100],
                    prefixIcon: Icon(Icons.person, size: 20, color: Utils.colorFromHex(ColorCode.blueSecondary)),
                  ),
                ),
              ),
              SizedBox(height: 15),
              StreamBuilder(
                stream: bloc.typing,
                builder: (context, snapshot) {
                  bool type = false;
                  if(snapshot.data != null){
                    type = snapshot.data;
                  }
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.grey[300])
                    ),
                    child: StreamBuilder(
                      stream: bloc.showPass,
                      builder: (context, snapshot) {
                        var showPass = false;
                        if(snapshot.data != null){
                          showPass = snapshot.data;
                        }
                        return TextField(
                          controller: bloc.edtPassword,
                          obscureText: showPass ? false:true,
                          textInputAction: TextInputAction.done,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              fillColor: Colors.blue[100],
                            prefixIcon: Icon(Icons.lock, size: 20, color: Utils.colorFromHex(ColorCode.blueSecondary)),
                            suffixIcon: type ? InkWell(
                              onTap: (){
                                bloc.showPassword(!showPass);
                              },
                              child: Icon(Icons.remove_red_eye, size: 20, color: Utils.colorFromHex(ColorCode.blueSecondary))) : SizedBox()
                          ),
                          onChanged: (val){
                            if(val.isNotEmpty){
                              bloc.passTyping(true);
                            }else{
                              bloc.passTyping(false);
                            }
                          },
                        );
                      }
                    ),
                  );
                }
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    // StreamBuilder(
                    //     stream: bloc.remember,
                    //     builder: (context, snapshot) {
                    //       bool remember = false;
                    //       if(snapshot.data != null){
                    //         remember = snapshot.data;
                    //       }
                    //       return Checkbox(
                    //         value: remember,
                    //         activeColor: Utils.colorFromHex(ColorCode.bluePrimary),
                    //         onChanged: (value) {
                    //           bloc.changeRemember(value);
                    //         },
                    //       );
                    //     }
                    // ),
                    // Text('Remeber me',
                    //   style: TextStyle(fontSize: 13),),
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

      bottomNavigationBar: Container(
        height: size.height * 0.11,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        color: Colors.white,
        child: InkWell(
          onTap: ()=> bloc.validasiLogin(context),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Utils.colorFromHex(ColorCode.blueSecondary)
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
