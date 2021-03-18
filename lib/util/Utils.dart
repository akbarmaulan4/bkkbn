import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kua/util/color_code.dart';

class Utils{

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static void log(Object obj) {
    print(obj);
  }

  static void alertError(BuildContext context, String message, void callback()) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: null,
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK",
                    style: TextStyle(
                        color: colorFromHex(ColorCode.colorPrimary))),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (callback != null) {
                    callback();
                  }
                },
              )
            ],
          );
        });
  }

  static void infoDialog(BuildContext context, String title, String message, void callback()) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK",
                    style: TextStyle(
                        color: colorFromHex(ColorCode.colorPrimary))),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (callback != null) {
                    callback();
                  }
                },
              )
            ],
          );
        });
  }

  static void showConfirmDialog(BuildContext context, String title, String message, void callback()) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Tidak",
                    style: TextStyle(
                        color: colorFromHex(ColorCode.colorPrimary))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Ya",
                    style: TextStyle(
                        color: colorFromHex(ColorCode.colorPrimary))),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (callback != null) {
                    callback();
                  }
                },
              )
            ],
          );
        });
  }

  static progressDialog(BuildContext context){
    // FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            content: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 35,
                        height: 35,
                      ),
                      SizedBox(width: 20),
                      Text('Progress...', style: TextStyle(fontSize: 20),)
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  static progressDialog2(BuildContext context, String informasi){
    // FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            content: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 35,
                        height: 35,
                      ),
                      SizedBox(width: 20),
                      Text(informasi, style: TextStyle(fontSize: 20),)
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}