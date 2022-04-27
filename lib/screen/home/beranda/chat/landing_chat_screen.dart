import 'package:flutter/material.dart';
import 'package:kua/bloc/chat/bloc_chat.dart';
import 'package:kua/model/chat/type_chat_model.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class LandingScreen extends StatefulWidget{
  bool main;
  LandingScreen(this.main);
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  BlocChat bloc = BlocChat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getChatType();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: TextAvenir('Chat Petugas', color: Utils.colorFromHex(ColorCode.bluePrimary)),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: widget.main ? null:InkWell(
              onTap: ()=>Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))
          ),
          bottom: PreferredSize(
              child: Container(
                color: Utils.colorFromHex(ColorCode.lightBlueDark),
                height: 0.5,
              ),
              preferredSize: Size.fromHeight(4.0)),
        ),
      body: StreamBuilder(
        stream: bloc.typeChat,
        builder: (context, snapshot) {
          List<TypeChatModel> data = [];
          if(snapshot.data != null){
            data = snapshot.data;
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                TextAvenir('Silahkan pilih petugas yang ingin anda hubungi', size: 15, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: data.asMap().map((index, value) => MapEntry(index, InkWell(
                      onTap: (){
                          if(value.status == '1'){
                            Navigator.pushNamed(context, '/chat_screen', arguments: {'data':value});
                          }else{
                            Utils.alertError(context, '${value.name} sedang tidak aktif', () { });
                          }
                        },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                      Container(
                      height: size.height * 0.12,
                      width: size.height * 0.12,
                      decoration: ConstantStyle.boxCircle(color: Colors.grey.shade200),
                      child: value.
                      name.contains('Bidan') ? Image.asset(ImageConstant.nurse2):Image.asset(index == 1 ? ImageConstant.nurse:ImageConstant.petugas_kb),
                                ),
                                Container(
                                  height: size.height * 0.12,
                                  width: size.height * 0.12,
                                  decoration: ConstantStyle.boxCircle(color: value.status == '0' ? Colors.grey.withOpacity(0.8) : Colors.transparent )
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            TextAvenir(value.name, size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                          ],
                        ),
                      ),
                    ))).values.toList(),
                  ),
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     InkWell(
                //       onTap: ()=>Navigator.pushNamed(context, '/chat_screen'),
                //       child: Container(
                //         child: Column(
                //           children: [
                //             Container(
                //               height: size.height * 0.1,
                //               width: size.height * 0.1,
                //               decoration: ConstantStyle.boxCircle(color: Colors.grey.shade200),
                //               child: Image.asset(ImageConstant.nurse),
                //             ),
                //             SizedBox(height: 10),
                //             TextAvenir('Petugas KB', size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                //           ],
                //         ),
                //       ),
                //     ),
                //     InkWell(
                //       onTap: ()=>Navigator.pushNamed(context, '/chat_screen'),
                //       child: Container(
                //         child: Column(
                //           children: [
                //             Container(
                //               height: size.height * 0.1,
                //               width: size.height * 0.1,
                //               decoration: ConstantStyle.boxCircle(color: Colors.grey.shade200),
                //               child: Image.asset(ImageConstant.nurse2, height: size.height * 0.15,
                //                 width: size.height * 0.15,),
                //             ),
                //             SizedBox(height: 10),
                //             TextAvenir('Bidan', size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: size.height * 0.08),
                // InkWell(
                //   onTap: ()=>Navigator.pushNamed(context, '/chat_screen'),
                //   child: Container(
                //     child: Column(
                //       children: [
                //         Container(
                //           height: size.height * 0.1,
                //           width: size.height * 0.1,
                //           decoration: ConstantStyle.boxCircle(color: Colors.grey.shade200),
                //           child: Image.asset(ImageConstant.nurse),
                //         ),
                //         SizedBox(height: 10),
                //         TextAvenir('Petugas PKK', size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        }
      ),
    );
  }
}
