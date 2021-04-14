import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:rxdart/rxdart.dart';

class BtnElsimi extends StatefulWidget {
  BoxDecoration decorActive;
  BoxDecoration decoInActive;
  double padding;
  String title;
  Color textColor;
  double textSize;
  BtnElsimi();

  @override
  _BtnElsimiState createState() => _BtnElsimiState();
}

class _BtnElsimiState extends State<BtnElsimi> {

  final _onTapDown = PublishSubject<BoxDecoration>();
  Stream<BoxDecoration> get onTapDown => _onTapDown.stream;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTapDown: (TapDownDetails details){
          _onTapDown.sink.add(ConstantStyle.boxShadowButon(
              color: Utils.colorFromHex(ColorCode.blueSecondary),
              radius: 10,
              spreadRadius: 2,
              blurRadius: 7,
              colorShadow: Utils.colorFromHex(ColorCode.lightGreyElsimil),
              offset: Offset(0, 0)
          ));
        },
        onTapCancel: (){

        },
        child: StreamBuilder(
          stream: onTapDown,
          builder: (context, snapshot) {
            BoxDecoration decoration = ConstantStyle.boxShadowButon(
                color: Utils.colorFromHex(ColorCode.blueSecondary),
                radius: 10,
                spreadRadius: 2,
                blurRadius: 7,
                colorShadow: Utils.colorFromHex(ColorCode.lightGreyElsimil),
                offset: Offset(0, 0)
            );
            if(snapshot.data != null){
              decoration = snapshot.data;
            }
            return Container(
                decoration: decoration,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: TextAvenir(
                  'Masuk',
                  size: 20,
                  color: Colors.white,
                ));
          }
        ),
      ),
    );
  }
}
