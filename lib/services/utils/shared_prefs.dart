
import 'dart:async';


import 'package:doorstep_customer/services/auth_service.dart';
import 'package:doorstep_customer/services/data_models/user_data_model.dart';
import 'package:doorstep_customer/ui/utils/helper_functions.dart/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:validators/sanitizers.dart';


class SharedPref {

  static const String LOGIN_CREDENTIALS = "loginCrendentials";
  static const String SESSION_STATE = "auth_states.";
  static const String ACCOUNT_VERIFICATION = "account_verification";
  static const String SESSION_VALID = "session_valid";

  static Future<Map<String,dynamic>> storeUser(MyUser _user)async{
      try{

      
      SharedPreferences _spf = await getInstance();
      _user.toMap().forEach((key, value) { 

        if(value is int){
          _spf.setInt(key, value);
        }else if(value is bool){
          _spf.setBool(key, value);
        }else if(value is double){
          _spf.setDouble(key, value);
        }else{
          _spf.setString(key, value);
        }
        
      });
      }catch(e){

      }
     
return {'result': true};
  }


  static Future<Map<String,dynamic>> getUser({SharedPreferences? spfInstance})async{
      try{

        if(spfInstance == null){
           spfInstance = await getInstance();
        }
      
      Map<String,dynamic> _userMap = MyUser().toMap();
      
      _userMap.forEach((key, value) { 

       
       _userMap[key] =spfInstance!.get(key) ?? _userMap[key];
          
      });
     
      return {'result':true,'data':MyUser.fromMap(_userMap)};

      }catch(e){
           print('$e shared prefs .dart line 64');
        return {'result':false, 'desc': 'Unexpected error occured,please try again later.'};
      }
     

  }


  
  

  static Future<Map> handleUserAccVerification({bool? accVer}) async {
    try {
      SharedPreferences _spf = await getInstance();
      if (accVer == null) {
        return {"result": _spf.getBool(ACCOUNT_VERIFICATION), "desc": ""};
      }

      var res = _spf.setBool(ACCOUNT_VERIFICATION, accVer);

      return {"result": res, "desc": ""};
    } catch (e) {
      return {"result": false, "desc": "Error Storing data."};
    }
  }

  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  static Future<Map> storeLoginCredentials({
    String fullname = "",
    String phoneNumber = "",
  }) async {
    try {
      var res = (await getInstance())
          .setString(LOGIN_CREDENTIALS, "$fullname$phoneNumber");

      return {"result": res, "desc": ""};
    } catch (e) {
      return {"result": false, "desc": "Error Storing data."};
    }
  }

  static Future<Map> updateSettings(Map settings) async {
    try {
      SharedPreferences _i = await getInstance();

      if (settings.length > 0) {
        settings.forEach((key, value) {
          if (value is bool) {
            _i.setBool(key, value);
          }

          if (value is String) {
            _i.setString(key, value);
          }

          if (value is int) {
            _i.setInt(key, value);
          }
        });
      }

      return {"result": true, "desc": ""};
    } catch (e) {
      print(e);
      return {
        "result": false,
        "desc": "Unexpected error occured,while updating settings."
      };
    }
  }


  static Future<Map> addCompany(Map<String,dynamic> company) async {
    try {
      SharedPreferences _i = await getInstance();

      if (company.length > 0) {
        company.forEach((key, value) {
          if (value is bool) {
            _i.setBool(key, value);
          }

          if (value is String) {
            _i.setString(key, value);
          }

          if (value is int) {
            _i.setInt(key, value);
          }
        });
      }

      return {"result": true, "desc": ""};
    } catch (e) {
      print(e);
      return {
        "result": false,
        "desc": "Unexpected error occured,while updating settings."
      };
    }
  }



  static Future<Map> getLoginCredentials() async {
    try {
      String? res = (await getInstance()).getString(LOGIN_CREDENTIALS);
      if (res!.isEmpty) {
        return {"result": false, "desc": ""};
      }
      return {"result": true, "desc": res};
    } catch (e) {
      return {"result": false, "desc": ""};
    }
  }

  static Future<Map> signOut() async {
    try {
      var res = await (await getInstance()).setString(LOGIN_CREDENTIALS, "");

      return {"result": res, "desc": ""};
    } catch (e) {
      print(e);
      return {"result": false, "desc": "Error Signing Out."};
    }
  }

  static Future<Map<String,dynamic>> getValue(key) async {
    try {
      SharedPreferences _i = await getInstance();

      return {"result": true, "desc": _i.get(key)};
    } on PlatformException catch (e) {
      print(e.code);
      print(e.message);
      return {"result": false, "desc": "Error Reading value."};
    }
  }

  static Future initSettings() async {
    try {
      SharedPreferences _i = await getInstance();
      Set<String> keys = _i.getKeys();
      print("All the keys $keys");

      print("All sets ${keys.first}");
      Map res = {};
      keys.forEach((key) {
        res.putIfAbsent(key, () => _i.get(key));
      });

      return {"result": true, "desc": res};
    } catch (e) {
      print(e);
      return {"result": false, "desc": ""};
    }
  }

  static Future fetchSettings() async {
    try {
      SharedPreferences _i = await getInstance();
      Set<String> keys = _i.getKeys();
      print("All the keys $keys");

      print("All sets ${keys.first}");
      Map res = {};
      keys.forEach((key) {
        res.putIfAbsent(key, () => _i.get(key));
      });

      return {"result": true, "desc": res};
    } catch (e) {
      print(e);

      return {"result": false, "desc": ""};
    }
  }



  static Future<Map<String,dynamic>> getValues(Set keys) async {
    try {
      SharedPreferences _i = await getInstance();

      Map resultantMap = {};

      keys.forEach((key) {
        resultantMap.putIfAbsent(key, () {
       
          return  _i.get(key);
          
         
        });
      });

     
      return {"result": true, "desc": resultantMap};
    } catch (e) {
      print("$e shared prefs 356");
     
      return {"result": false, "desc": "Unexpected error, please try again."};
    }
  }

  static Future<Map<String,dynamic>> initializeUser() async{

    try{
        
        // get the shared prefs instance
        SharedPreferences spfInstance = await getInstance();

        // get the stored user in the SharedPrefs
         Map<String,dynamic> userMap =  await getUser(spfInstance: spfInstance);

        // declare and initialize the resultant map
        Map<String,dynamic> resultantMap = {'result': true,'user_data':MyUser(),'firebase_user': null};

        // get the current firebase user
        User? _user = await AuthService().getCurrentUser();

        var n = await AuthService().getUserAuthClaimns();
        myPrint(n,heading: 'auth claims');
        
        // get show onboarding value
        Map<String,dynamic> showOnboardingMap = await getValue('show_onboarding');
        resultantMap['show_onboarding'] = !showOnboardingMap['result'] || showOnboardingMap['desc'] == null ? true : false;
      
      // if the user's info can be found inside the local storage
      if(userMap['result']){
          
            // add the firebase user info
           resultantMap['firebase_user'] = _user; 

            // add the user info stored locally
           resultantMap['user_data'] = userMap['data'];

          

          
        
      }
     
      return resultantMap;
      
    }catch(e){

      return {'result': false, 'desc': 'Unexpected error, please try again.'};
    }
  }

 
}
