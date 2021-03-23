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
    var totalLebal = size.width * 0.52;
    var lebarMax = totalLebal/widget.max_questions;
    var lebarPart = lebarMax/widget.max_questions;
    double lebar = ((lebarPart * widget.result))*widget.result;
    return Container(
      child: Stack(
        children: [
          Container(
            width: totalLebal,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.blue[100],//Utils.colorFromHex(ColorCode.blueSecondary)
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
