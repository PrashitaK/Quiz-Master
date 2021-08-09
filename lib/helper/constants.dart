// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static String sharedPrefUserLoginKey = "ISLOGGEDIN";
  static String sharedPrefUNameKey = "USERNAMEKEY";
  static String sharedPrefUEmailKey = "USEREMAIL";

  static Future<bool> saveUserLoginSharedPref(
      {@required bool userLogin}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        Constants.sharedPrefUserLoginKey, userLogin);
  }

  static Future<bool> getUserLoginSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(Constants.sharedPrefUserLoginKey);
  }
}
