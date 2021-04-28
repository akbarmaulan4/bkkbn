import 'package:flutter/material.dart';

class TextAvenir extends Text{
  final double size;
  final Color color;
  // final bool isCentered;
  // final double spacing;
  final TextAlign textAlign;
  final FontWeight weight;
  TextAvenir(String data, {
    this.size,
    this.color,
    // this.spacing = 1.0,
    this.textAlign = TextAlign.left,
    this.weight = FontWeight.normal
  }) : super(data,
      textAlign: textAlign,
      maxLines: 2,//isCentered ? TextAlign.center : TextAlign.left,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1.0,
      style: TextStyle(
          fontFamily: 'Avenir',
          fontWeight: weight,
          fontSize: size,
          color: color,
          // letterSpacing: spacing
      ));
}