import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kua/main.dart';

void main() {
  EnvironmentConfig.environment = Environment.dev;
//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//      statusBarColor: ECHelper.colorFromHex(ColorCode.colorPrimary)));

  //new Design
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  // Crashlytics.instance.enableInDevMode = true;
  // FlutterError.onError = Crashlytics.instance.recordFlutterError;
  //
  // setupLocator();setupLocator

  runApp(MyApp());
}