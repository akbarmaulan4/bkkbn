import 'dart:convert';

import 'package:kua/model/user/user.dart';
import 'package:kua/util/text_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData{

  static Future<bool> removeAllPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static void saveRemember(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TextConstant.remeber, val);
  }

  static Future<String> getRemember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(TextConstant.remeber);
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return '';
  }

  static Future<bool> removeRemember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(TextConstant.remeber);
  }

  static void saveUser(UserModel val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TextConstant.user, json.encode(val.toJson()));
  }

  static Future<UserModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(TextConstant.user);
    if (data != null && data.isNotEmpty) {
      return UserModel.fromJson(json.decode(data));
    }
    return null;
  }

  static Future<bool> removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(TextConstant.user);
  }
}