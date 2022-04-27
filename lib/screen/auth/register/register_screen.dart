import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/screen/auth/register/register_data.dart';
import 'package:kua/screen/auth/register/register_data_diri.dart';
import 'package:kua/screen/auth/register/register_foto.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';

import '../../../widgets/font/avenir_text.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  AuthBloc bloc = new AuthBloc();

  Future<bool> onWillPop() {
    if((bloc.registViewAt-1) < 0){
      Navigator.of(context).pushNamedAndRemoveUntil('/gateway', (Route<dynamic> route) => false);
    }else{
      bloc.changeViewRegist(bloc.registViewAt-1);
      return Future.value(false);
    }
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
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: MediaQuery(
          data: scaleFactor,
          child: Container(
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.06,),
                  // Text("REGISTRASI", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: ()=>Navigator.of(context).pushNamedAndRemoveUntil('/gateway', (Route<dynamic> route) => false),
                      child: Align(
                        alignment: Alignment.centerLeft,
                          child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary), size: 20,)),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextAvenir(
                    'REGISTRASI',
                    size: 24,
                    color: Utils.colorFromHex(ColorCode.bluePrimary),
                  ),
                  SizedBox(height: 25),
                  StreamBuilder(
                    stream: bloc.regisScreen,
                    builder: (context, snapshot) {
                      int screenAt = bloc.registViewAt;
                      if(snapshot.data != null){
                        screenAt = snapshot.data;
                      }
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 80),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        color:Utils.colorFromHex(ColorCode.bluePrimary),
                                      ),
                                    )
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        color: screenAt > 1 ? Utils.colorFromHex(ColorCode.bluePrimary) : Colors.grey[300],
                                      ),
                                    )
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        color: screenAt > 2 ? Utils.colorFromHex(ColorCode.bluePrimary) : Colors.grey[300],
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
                          loadScreenRegist(screenAt)
                        ],
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loadScreenRegist(int val){
    switch(val){
      case 0:
        // return RegisterDataDiri(bloc: bloc);
        return RegisterData(bloc: bloc);
      case 1:
        return RegisterFoto(bloc: bloc);
      case 2:
        return RegisterDataDiri(bloc: bloc);
      default:
        return RegisterData(bloc: bloc);
    }
  }
}
