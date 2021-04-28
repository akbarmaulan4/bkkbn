import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kua/bloc/akun/akun_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class UbahPassword extends StatefulWidget {
  @override
  _UbahPasswordState createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> with SingleTickerProviderStateMixin{

  AkunBloc bloc = AkunBloc();
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    // bloc.loginSucces.listen((event) {
    //   if(event != null){
    //     if(event){
    //       Navigator.popAndPushNamed(context, '/home', arguments: {'loadFirstMenu':0});
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextAvenir('Pusat Bantuan', size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
              onTap: ()=>Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))
          ),
          bottom: PreferredSize(
              child: Container(
                color: Utils.colorFromHex(ColorCode.lightBlueDark),
                height: 0.5,
              ),
              preferredSize: Size.fromHeight(4.0))
      ),
      body: MediaQuery(
        data: scaleFactor,
        child: Container(
          color: Utils.colorFromHex(ColorCode.softGreyElsimil),
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextAvenir(
                  'Kata Sandi Lama',
                  size: 14,
                  color: Utils.colorFromHex(ColorCode.bluePrimary),
                ),
                SizedBox(height: 5),
                StreamBuilder(
                    stream: bloc.typingOldPass,
                    builder: (context, snapshot) {
                      var type = false;
                      if(snapshot.data != null){
                        type = snapshot.data;
                      }
                      return BoxBorderDefault(
                          child: StreamBuilder(
                              stream: bloc.showOldPass,
                              builder: (context, snapshot) {
                                var showPass = false;
                                if(snapshot.data != null){
                                  showPass = snapshot.data;
                                }
                                return TextField(
                                  controller: bloc.edtOldPass,
                                  textAlignVertical: TextAlignVertical.center,
                                  obscureText: showPass ? false : true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Kata sandi',
                                      hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                      suffixIcon: type ? InkWell(
                                          onTap: ()=>bloc.changeOldPass(!showPass),
                                          child: Icon(Icons.remove_red_eye, size: 20, color: Colors.grey)):SizedBox()
                                  ),
                                  onChanged: (val){
                                    if(val.length > 0){
                                      bloc.isTypingOldPass(true);
                                    }else{
                                      bloc.isTypingOldPass(false);
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
                  'Kata Sandi Baru',
                  size: 14,
                  color: Utils.colorFromHex(ColorCode.bluePrimary),
                ),
                SizedBox(height: 5),
                StreamBuilder(
                    stream: bloc.typingNewPass,
                    builder: (context, snapshot) {
                      var type = false;
                      if(snapshot.data != null){
                        type = snapshot.data;
                      }
                      return BoxBorderDefault(
                          child: StreamBuilder(
                              stream: bloc.showNewPass,
                              builder: (context, snapshot) {
                                var showPass = false;
                                if(snapshot.data != null){
                                  showPass = snapshot.data;
                                }
                                return TextField(
                                  controller: bloc.edtNewPass,
                                  textAlignVertical: TextAlignVertical.center,
                                  obscureText: showPass ? false : true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Kata sandi baru',
                                      hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                      suffixIcon: type ? InkWell(
                                          onTap: ()=>bloc.changeNewPass(!showPass),
                                          child: Icon(Icons.remove_red_eye, size: 20, color: Colors.grey)):SizedBox()
                                  ),
                                  onChanged: (val){
                                    if(val.length > 0){
                                      bloc.isTypingNewPass(true);
                                    }else{
                                      bloc.isTypingNewPass(false);
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
                  'Ulangi Kata Sandi Baru',
                  size: 14,
                  color: Utils.colorFromHex(ColorCode.bluePrimary),
                ),
                SizedBox(height: 5),
                StreamBuilder(
                    stream: bloc.typingRePass,
                    builder: (context, snapshot) {
                      var type = false;
                      if(snapshot.data != null){
                        type = snapshot.data;
                      }
                      return BoxBorderDefault(
                          child: StreamBuilder(
                              stream: bloc.showRePass,
                              builder: (context, snapshot) {
                                var showPass = false;
                                if(snapshot.data != null){
                                  showPass = snapshot.data;
                                }
                                return TextField(
                                  controller: bloc.edtRePass,
                                  textAlignVertical: TextAlignVertical.center,
                                  obscureText: showPass ? false : true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Ulangi kata sandi baru',
                                      hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                      suffixIcon: type ? InkWell(
                                          onTap: ()=>bloc.changeRePass(!showPass),
                                          child: Icon(Icons.remove_red_eye, size: 20, color: Colors.grey)):SizedBox()
                                  ),
                                  onChanged: (val){
                                    if(val.length > 0){
                                      bloc.isTypingRePass(true);
                                    }else{
                                      bloc.isTypingRePass(false);
                                    }
                                  },
                                );
                              }
                          )
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: InkWell(
        onTap: (){
          bloc.validasiPassword(context);
        },
        child: Container(
            alignment: Alignment.bottomCenter,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Utils.colorFromHex(ColorCode.blueSecondary),
              boxShadow: [
                BoxShadow(
                  color: Utils.colorFromHex('#939CBC'),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0,0),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: TextAvenir('Simpan', color: Colors.white, size: 18,),
            )
        ),
      ),
      // floatingActionButton:  new Container(
      //   child: new Material(
      //     child: new InkWell(
      //       onTap: (){print("tapped");},
      //       child: new Container(
      //         width: 100.0,
      //         height: 100.0,
      //       ),
      //     ),
      //     color: Colors.transparent,
      //   ),
      //   color: Colors.orange,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }
  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
