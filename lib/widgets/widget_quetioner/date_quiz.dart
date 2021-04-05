import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';

import '../font/avenir_text.dart';
import '../box_border.dart';

class DateQuiz extends StatefulWidget {
  int id;
  // String headerId;
  // String jenis;
  // String tipe;
  String question;
  String answerTxt;
  Function changeValue;

  DateQuiz({
    this.id,
    this.question,
    // this.headerId,
    // this.jenis,
    // this.tipe,
    this.changeValue
  });

  takeAnswer(){
    return answerTxt;
  }

  @override
  _InputQuizState createState() => _InputQuizState();
}

class _InputQuizState extends State<DateQuiz> {
  String answer = '';
  TextEditingController edt = new TextEditingController();

  setAnswer(String val){
    widget.answerTxt = val;
    widget.changeValue(val);
  }
  berbobot(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          TextAvenir(
            widget.question,
            size: 14,
            color: Colors.grey,
          ),
          SizedBox(height: 5),
          InkWell(
            onTap: (){
              openDatePicker(context);
            },
            child: Container(
              child: BoxBorderDefault(
                  child: TextField(
                    controller: edt,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom:16),
                      hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                      hintText: widget.question
                    ),
                    enabled: false,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  openDatePicker(BuildContext context) async {
    DateTime dateTime;
    dateTime = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate:  dateTime,
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2100)
    );
    if (picked != null){
      final dateFormat = DateFormat("yyyy-MM-dd");
      edt.text = dateFormat.format(picked);
      setAnswer(dateFormat.format(picked));
    }
  }
}
