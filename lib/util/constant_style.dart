import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';

import 'color_code.dart';

class ConstantStyle {

  // static const styleLabel = TextStyle(
  //     fontSize: 14,
  //     color: Utils.colorFromHex(ColorCode.bluePrimary)
  // );

  static const avenirStandart = TextStyle(
    fontFamily: 'Avenir',
    fontSize: 14,
    color: Colors.grey,
  );

  static const decorTextField = InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(bottom:16)
  );

  static decorTextField2(String hint){
    return InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(bottom:16)
    );
  }

  static box_card() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            offset: Offset(1,1),
          )
        ]
    );
  }

  static var box_white = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static var box_light_blue_dark = BoxDecoration(
      color: Utils.colorFromHex(ColorCode.lightBlueDark),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Colors.grey[300])
  );

  static var box_fill_blu = BoxDecoration(
    color: Utils.colorFromHex(ColorCode.bluePrimary),
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );

  static var button_fill_blu = BoxDecoration(
    color: Utils.colorFromHex(ColorCode.bluePrimary),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static var box_fill_blue_nd = BoxDecoration(
      color: Utils.colorFromHex(ColorCode.blueSecondary),
      borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static var box_fill_green = BoxDecoration(
    color: Utils.colorFromHex(ColorCode.greenPrimary),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static var box_fill_grey = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static var box_fill_red = BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.all(Radius.circular(3)),
  );

  // static var box_fill_green = BoxDecoration(
  //   color: Colors.green,
  //   borderRadius: BorderRadius.all(Radius.circular(10)),
  // );

  static var box_border_grey = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Colors.grey[300])
  );

  static var box_border_field = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      border: Border.all(color: Colors.grey[300])
  );
}