import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class TambahPasangan extends StatefulWidget {
  @override
  _TambahPasanganState createState() => _TambahPasanganState();
}

class _TambahPasanganState extends State<TambahPasangan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextAvenir('Pasangan', size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.add, color: Utils.colorFromHex(ColorCode.bluePrimary))
          )
        ],
      ),
      body: Container(
        color: Utils.colorFromHex(ColorCode.softGreyElsimil),
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextAvenir(
              'No KTP pasangan',
              size: 14,
              color: Utils.colorFromHex(ColorCode.bluePrimary),
            ),
            SizedBox(height: 5),
            BoxBorderDefault(
                child: TextField(
                  // controller: widget.bloc.edtKtp,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(16),
                    new BlacklistingTextInputFormatter(
                        new RegExp('[\\-|\\,|\\.]')),
                  ],
                  decoration: ConstantStyle.decorTextField,
                )
            ),
            SizedBox(height: 15),
            TextAvenir(
              'No ID profil pasangan',
              size: 14,
              color: Utils.colorFromHex(ColorCode.bluePrimary),
            ),
            SizedBox(height: 5),
            BoxBorderDefault(
                child: TextField(
                  // controller: widget.bloc.edtKtp,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(16),
                    new BlacklistingTextInputFormatter(
                        new RegExp('[\\-|\\,|\\.]')),
                  ],
                  decoration: ConstantStyle.decorTextField,
                )
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: (){
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false, arguments: {'loadFirstMenu':3});
        },
        child: Container(
            alignment: Alignment.bottomCenter,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Utils.colorFromHex(ColorCode.blueSecondary)
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: TextAvenir('Lanjutkan', color: Colors.white, size: 18,),
            )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
