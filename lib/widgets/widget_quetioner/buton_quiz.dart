import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';

class ButtonQuiz extends StatefulWidget {
  String title;
  ButtonQuiz({
    this.title
  });
  @override
  _ButtonQuizState createState() => _ButtonQuizState();
}

class _ButtonQuizState extends State<ButtonQuiz> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ConstantStyle.box_fill_blue_nd,
      child: Center(child: TextAvenir(widget.title, color: Utils.colorFromHex(ColorCode.bluePrimary))),
    );
  }
}
