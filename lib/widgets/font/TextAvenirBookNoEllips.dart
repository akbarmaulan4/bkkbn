import 'package:flutter/material.dart';

class TextAvenirBookNoEllips extends Text{
  final double size;
  final Color color;
  final TextAlign textAlign;
  final FontWeight weight;
  final double height;
  final int lines;
  TextAvenirBookNoEllips(String data, {
    this.size,
    this.color,
    this.textAlign = TextAlign.left,
    this.weight = FontWeight.normal,
    this.height = 1.2,
    this.lines = 2
  }) : super(data,
      textAlign: textAlign,
      maxLines: lines,//isCentered ? TextAlign.center : TextAlign.left,
      textScaleFactor: 1.0,
      style: TextStyle(
          fontFamily: 'Avenir-Book',
          fontWeight: weight,
          fontSize: size,
          color: color,
          height: height
        // letterSpacing: spacing
      ));
}