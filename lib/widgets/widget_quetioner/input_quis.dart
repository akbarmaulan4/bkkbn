import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:kua/util/Utils.dart';
import 'package:kua/util/constant_style.dart';
import 'dart:ui' as ui;

import '../font/avenir_text.dart';
import '../box_border.dart';

class InputQuiz extends StatefulWidget {
  String? question;
  int? id;
  String? tipe;
  String? satuan;
  Function? changeValue;

  String? tile;
  TextDirection? txtDirection;
  double width = 230;
  String? answerTxt;

  InputQuiz({
    this.id,
    this.tipe,
    this.satuan,
    this.question,
    this.changeValue
  });

  takeAnswer(){
    return answerTxt;
  }

  @override
  _InputQuizState createState() => _InputQuizState();
}

class _InputQuizState extends State<InputQuiz> {
  String answer = '';

  setAnswer(String val){
    widget.answerTxt = val;
    widget.changeValue!(val);
  }
  berbobot(){

  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: scaleFactor,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            // TextAvenir(
            //   widget.question,
            //   size: 14,
            //   color: Colors.grey,
            // ),
            Text(widget.question!, style: TextStyle(fontSize: 14, fontFamily: 'Avenir', color: Colors.grey)),
            SizedBox(height: 5),
            Container(
              width: 230,
              child: BoxBorderDefault(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Directionality(
                          textDirection:  widget.tipe == 'angka' ? ui.TextDirection.ltr : ui.TextDirection.rtl,
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: widget.tipe == 'angka' ? TextInputType.number : TextInputType.text,
                            inputFormatters: [
                              // LengthLimitingTextInputFormatter(16),
                              widget.tipe == 'angka' ? FilteringTextInputFormatter.deny(RegExp('[\\,]')):FilteringTextInputFormatter.deny(RegExp(''))
                              // new BlacklistingTextInputFormatter(
                              //     widget.tipe == 'angka' ? RegExp('[\\,]') : RegExp('')
                              // ),
                                  // new RegExp('[\\-|\\,|\\.]')),
                            ],
                            // textAlign:  widget.tipe == 'angka' ? TextAlign.right:TextAlign.left,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom:16),
                                hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                hintText: widget.question
                            ),
                            onChanged: (val){
                              setAnswer(val);
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextAvenir(widget.satuan != null ? widget.satuan!:'' , size: 16,)
                      )
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
