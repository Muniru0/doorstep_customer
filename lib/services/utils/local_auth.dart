//import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_errors;
import 'package:local_auth/local_auth.dart';

LocalAuthentication localAuth = LocalAuthentication();

Future<Map> canCheckBiometrics() async {
  try {
    var res = await localAuth.canCheckBiometrics;
    if (res) {
      return {"result": true, "desc": "success"};
    }
    return {
      "result": false,
      "desc": "Sorry,your device does not support biometric authentication."
    };
  } catch (e) {
    print(e);
    return {
      "result": false,
      "desc": "Error check device ability to handle biometrics."
    };
  }
}

Future<dynamic> getAvailableBiometrics() async {
  try {
    return await localAuth.getAvailableBiometrics();
  } catch (e) {
    return {"result": false, "desc": "Error retrieving biometrics."};
  }
}

cancelLocalAuth() {
  localAuth.stopAuthentication();
}

Future<Map<String, dynamic>> requestLocalAuth( {msg: "Please authorize operation."}) async {
          
          
          Map canCheckAuth = await canCheckBiometrics();

          if (!canCheckAuth["result"]) {
            return {
              "result": false,
              "desc": "Biometrics not supported on device,Please use In-App OTP-Code."
            };
          }

  try {

        if (canCheckAuth["result"]) {
          bool didAuthenticate = await localAuth.authenticate(
              localizedReason: msg, stickyAuth: true);

          if (didAuthenticate) {
            return {"result": true, "desc": "Authentication success."};
          }

          return {"result": false, "desc": ""};
        }

        return {
          "result": false,
          "desc": "Sorry Your device does not suppor biometrics"
        };


  } on PlatformException catch (e) {
          print("$e here");

          if (e.code == "auth_in_progress") {
            cancelLocalAuth();
      return {'result': false, 'desc': ''};
          }

          if (auth_errors.lockedOut == e.code) {
            return {
              "result": false,
              "desc": "Too many failed attempts...try again after some time."
            };
          }
          if (auth_errors.notAvailable == e.code) {
            return {
              "result": false,
              "desc":
                  "Please biometric authentication is unavailable.please use other forms of authentications."
            };
          }

          if (auth_errors.passcodeNotSet == e.code) {
            return {
              "result": false,
              "desc": "Passcode not set. Please set up the passcode and continue."
            };
          }

          if (auth_errors.notEnrolled == e.code) {
            return {
              "result": false,
              "desc": "Please setup your biometric authentication to continue."
            };
          }

          if (auth_errors.permanentlyLockedOut == e.code) {
            return {
              "result": false,
              "desc": "Please You have being locked out of biometric authentication."
            };
          }

          return {'result': false,'desc':'Unexpected error, please try again afer sometime.'};
    }
}
