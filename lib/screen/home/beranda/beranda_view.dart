import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/home/home_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/avenir_book.dart';
import 'package:kua/widgets/avenir_text.dart';
import 'package:kua/widgets/home/item_info_profile.dart';
import 'package:kua/widgets/home/item_quiz.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BerandaVIew extends StatefulWidget {
  @override
  _BerandaVIewState createState() => _BerandaVIewState();
}

class _BerandaVIewState extends State<BerandaVIew> {

  HomeBloc bloc = new HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.checkVerify();

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.40,
                width: double.infinity,
                color: Utils.colorFromHex(ColorCode.bluePrimary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    SizedBox(height: size.height * 0.03),
                    titleNotif(),
                    SizedBox(height: 15),
                    infoData()
                  ],
                ),
              ),
              SizedBox(height: 30),
              StreamBuilder(
                stream: bloc.verifyOK,
                builder: (context, snapshot) {
                  bool verify = false;
                  if(snapshot.data != null){
                    verify = snapshot.data;
                  }
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: verify ? infoBarcode() : infoValidation(),
                  );
                }
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.map, color: Utils.colorFromHex(ColorCode.blueSecondary)),
                        SizedBox(width: 10),
                        TextAvenir('Edukasi', size: 14, color: Utils.colorFromHex(ColorCode.blueSecondary)),
                      ],
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          itemList(),
                          itemList(),
                          itemList(),
                          itemList(),
                          itemList(),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  titleNotif(){
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  TextAvenir('ELSIMIL', size: 24, color: Colors.white),
                  TextAvenir('Skrining Kesiapan Menikah dan Hamil', size: 14, color: Colors.white)
                ],
              )
          ),
          Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: ()=> Navigator.pushNamed(context, '/chat_screen'),
                    child: Icon(Icons.chat_bubble, color: Colors.white, size: 16)
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    onTap: ()=> Navigator.pushNamed(context, '/list_notif'),
                    child: Icon(Icons.notifications, color: Colors.white, size: 18)
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
            ],
          )
        ],
      ),
    );
  }

  infoData(){
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ItemQuiz()
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: ItemInfoProfile()
          )
        ],
      ),
    );
  }

  infoValidation(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Utils.colorFromHex(ColorCode.yellow_light)
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: StreamBuilder(
        stream: bloc.messageVerify,
        builder: (context, snapshot) {
          String str = '';
          if(snapshot.data != null){
            str = snapshot.data;
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.info_outline_rounded, color: Utils.colorFromHex(ColorCode.yellow_dark)),
              SizedBox(width: 15),
              Expanded(child: TextAvenirBook(str, size: 13, color: Utils.colorFromHex(ColorCode.yellow_dark)))
            ],
          );
        }
      ),
    );
  }

  infoBarcode(){
    return InkWell(
      onTap: ()=>dialogBarcode(),
      child: Container(
        decoration: ConstantStyle.box_fill_blu,
        // padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
              margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
              child: Center(
                child: TextAvenir('PROFILE ID : DPK-123456'),
              ),
            )),
            SizedBox(width: 20),
            Container(
              margin: EdgeInsets.only(right: 25),
              child: Center(child: Icon(Icons.qr_code_outlined, size: 30, color: Colors.grey,))
            )
          ],
        ),
      ),
    );
  }

  dialogBarcode(){
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
        context: context,
        builder: (contex){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            content:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200.0,
                    height: 200.0,
                    child: QrImage(
                      data: "1234567890",
                      version: QrVersions.auto,
                      size: 200,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }



  itemList(){
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              offset: Offset(1,1),
            )
          ]
      ),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: size.width * 0.35,
      child: Column(
        children: [
          Container(
            height: size.height * 0.16 ,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)
                ),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2U_L6KJsOv1ZX5v-JScbk8ZO_ZEe5CwOvmA&usqp=CAU')//ExactAssetImage(ImageConstant.logo)
                )
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextAvenir('Kesahatan Pra Nikah', size: 11, color: Colors.grey),
                SizedBox(height: 3),
                TextAvenir('Ingin menikah? Yuk check', size: 13, color: Utils.colorFromHex(ColorCode.bluePrimary)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
