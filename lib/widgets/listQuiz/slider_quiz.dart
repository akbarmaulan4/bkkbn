import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';

class SliderQuiz extends StatefulWidget {
  double max_questions;
  double result;
  SliderQuiz({this.max_questions, this.result});
  @override
  _SliderQuizState createState() => _SliderQuizState();
}

class _SliderQuizState extends State<SliderQuiz> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var maxQuestion = widget.max_questions;
    var answered = widget.result;
    var totalLebal = size.width * 0.52;
    double lebar = 0;
    if(answered > 0){
      var lebarMax = totalLebal/maxQuestion;
      var lebarPart = lebarMax/maxQuestion;
      lebar = ((lebarPart * answered))*answered;
    }
    return Container(
      child: Stack(
        children: [
          Container(
            width: totalLebal,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Utils.colorFromHex(ColorCode.greyElsimil)
            ),
          ),
          Container(
            width: lebar,
            height: 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Utils.colorFromHex(ColorCode.blueSecondary)
            ),
          )
        ],
      ),
    );
  }
}
