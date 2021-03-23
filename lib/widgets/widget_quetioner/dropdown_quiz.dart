import 'package:flutter/material.dart';
import 'package:kua/util/constant_style.dart';

import '../font/avenir_text.dart';

class DropDownQuiz extends StatefulWidget {
  String question;
  DropDownQuiz({this.question});
  @override
  _DropDownQuizState createState() => _DropDownQuizState();
}

class _DropDownQuizState extends State<DropDownQuiz> {
  String answerSelected = 'satu';
  List<String> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data.add('-- Pilih ---');
    data.add('satu');
    data.add('dua');
    data.add('tiga');
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
          Container(
            padding: EdgeInsets.only(left: 10),
            decoration: ConstantStyle.box_border_field,
            width: double.infinity,
            // child: TextAvenir(data[0]),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text("-- Pilih ---"),
                value: answerSelected ,
                items: data.map((value) {
                  return DropdownMenuItem(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(value)),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    answerSelected = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
