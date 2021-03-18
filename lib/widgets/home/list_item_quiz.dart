import 'package:flutter/material.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/avenir_text.dart';

class ListItemQuiz extends StatefulWidget {

  String title;
  ListItemQuiz({this.title});

  @override
  _State createState() => _State();
}

class _State extends State<ListItemQuiz> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: ConstantStyle.box_border_grey,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 9),
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: size.width * 0.43,
      child: Row(
        children: [
          TextAvenir('D', size: 30, color: Colors.red),
          SizedBox(width: 10),
          TextAvenir(widget.title, size: 10,),
        ],
      ));
  }
}
