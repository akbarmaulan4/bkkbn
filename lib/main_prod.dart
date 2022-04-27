import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kua/main.dart';

void main() {
  EnvironmentConfig.environment = Environment.prod;
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}