import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kua/bloc/akun/akun_bloc.dart';
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

  AkunBloc bloc = AkunBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    bloc.addCouple.listen((event) {
      if(event != null){
        if(event){
          Utils.showConfirmDialog(context, 'Informasi', 'Anda berhasil menambahkan pasangan', () {
            Navigator.of(context).pop();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextAvenir('Pasangan', size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: ()=>Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))
        ),
      ),
      body: MediaQuery(
        data: scaleFactor,
        child: Container(
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
                    controller: bloc.edtNoKtp,
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
                    controller: bloc.edtIdProfile,
                    textAlignVertical: TextAlignVertical.center,
                    // inputFormatters: [
                    //   LengthLimitingTextInputFormatter(16),
                    //   new BlacklistingTextInputFormatter(
                    //       new RegExp('[\\-|\\,|\\.]')),
                    // ],
                    decoration: ConstantStyle.decorTextField,
                  )
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: (){
          // Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false, arguments: {'loadFirstMenu':3});
          bloc.validationAddSpouse(context);
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
              child: TextAvenir('Lanjutkan', color: Colors.white, size: 18,),
            )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
