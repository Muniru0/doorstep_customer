
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

enum MomoPinManipulation { READ, WRITE }

class SecureStorage {
  // Create storage
  static final storage = new FlutterSecureStorage();
  static const String ACCOUNT_OTP = "account_otp";

  static storePassword(password) async{
    try {
     await storage.write(key: "password", value: password);
      return {"result": true, "desc": ""};
    } catch (e) {
      return {"result": true, "desc": ""};
    }
  }

  static Future<Map<String,dynamic>> confirmUserPassword(password) async {
    try {

      var res = await storage.read(key: "password");

     
      if (res != null) {
         print('-------------------------- here.');
         print(res);
        print('--------------------------');
        return {"result": (res == password), "desc": "Invalid Password."};
      }
      print('-----------------------');
      print(res);
      print('------------------------');
      return {"result": false, "desc": "Invalid Password."};
    } catch (e) {
      print(e);
      return {"result": false, "desc": "Error validating password."};
    }
  }

  static Future<Map> isRegistered() async {
    try {
      var res = await storage.read(key: "loginCredentials");
      print(res);

      // remove is not empty from here
      if (res != null && res.isNotEmpty) {
        List<String> splittedRes = res.split("+");
        print("out put from the login credentials $splittedRes");
        if (splittedRes.length > 0) {
          return {"result": true, "desc": splittedRes};
        }
      }

      return {"result": true, "desc": []};
    } catch (e) {
      return {"result": false, "desc": ""};
    }
  }

  static Future<Map<String,dynamic>> getUserPassword() async {
    try {
      var res = await storage.read(key: "password");
      if (res != null) {
        if (res.isEmpty) return {"result": false, "desc": "Password Empty"};
        return {"result": true, "desc": res};
      }

      return {"result": false, "desc": "Invalid Password."};
    } catch (e) {
      print(e);
      return {"result": false, "desc": "Error validating password."};
    }
  }



}
