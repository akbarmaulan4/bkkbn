import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/avenir_book.dart';
import 'package:kua/widgets/avenir_text.dart';

class AkunView extends StatefulWidget {
  @override
  _AkunScreenState createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextAvenir('AKUN', size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.04),
              Center(
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: Image.asset(ImageConstant.logo),
                      ),
                      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2U_L6KJsOv1ZX5v-JScbk8ZO_ZEe5CwOvmA&usqp=CAU',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextAvenir('Amanda Manopo', size: 24, color: Utils.colorFromHex(ColorCode.bluePrimary)),
              SizedBox(height: 7),
              TextAvenirBook('25 Tahun, Depok - Jawa Barat', size: 14, color: Colors.grey),
              SizedBox(height: 3),
              RichText(
                text: TextSpan(
                  text: 'PROFILE ID : ',
                  style: TextStyle(height: 1.5, fontSize: 12, fontFamily: 'Avenir', color: Colors.grey.shade300),
                  children: <TextSpan>[
                    TextSpan(text: 'DPK-129373', style: TextStyle(height: 1.5, fontSize: 12, fontFamily: 'Avenir', color: Colors.grey)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: ConstantStyle.box_border_grey,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextAvenir('Biodata', size: 14, color: Utils.colorFromHex(ColorCode.blueSecondary))
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Utils.colorFromHex(ColorCode.blueSecondary))
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: ConstantStyle.box_border_grey,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: TextAvenir('Biodata Pasangan', size: 14, color: Utils.colorFromHex(ColorCode.blueSecondary))
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Utils.colorFromHex(ColorCode.blueSecondary))
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: ConstantStyle.box_border_grey,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: TextAvenir('Riwayat Kuesioner', size: 14, color: Utils.colorFromHex(ColorCode.blueSecondary))
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Utils.colorFromHex(ColorCode.blueSecondary))
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: ConstantStyle.box_border_grey,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: TextAvenir('Bantuan', size: 14, color: Utils.colorFromHex(ColorCode.blueSecondary))
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Utils.colorFromHex(ColorCode.blueSecondary))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
