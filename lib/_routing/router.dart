

import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/ui/routes/app_info_route.dart';
import 'package:doorstep_customer/ui/routes/forgot_password_route.dart';
import 'package:doorstep_customer/ui/routes/login_route.dart';
import 'package:doorstep_customer/ui/routes/otp_verification_route.dart';
import 'package:doorstep_customer/ui/routes/password_updated_success_route.dart';
import 'package:doorstep_customer/ui/routes/re_authentication_route.dart';
import 'package:doorstep_customer/ui/routes/registration_route.dart';
import 'package:doorstep_customer/ui/routes/select_location_on_map_route.dart';
import 'package:doorstep_customer/ui/routes/set_new_password_route.dart';
import 'package:doorstep_customer/ui/routes/settings_route.dart';
import 'package:doorstep_customer/ui/routes/signup_route.dart';
import 'package:doorstep_customer/ui/routes/successful_parcel_sending_route.dart';
import 'package:doorstep_customer/ui/routes/unknown_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {

  switch (settings.name) {
        case Constants.SIGNUP_ROUTE:
      return CupertinoPageRoute(builder: (context) => SignUpRoute());
       case Constants.SELECT_LOCATION_ON_MAP_ROUTE:
      return CupertinoPageRoute(builder: (_) => SelectLocationOnMapRoute());
    case Constants.LOGIN_ROUTE:
      return CupertinoPageRoute(builder: (context) => LoginRoute());
       case Constants.UNKNOWN_ROUTE:
      return CupertinoPageRoute(builder: (context) => UnknownRoute());
     case Constants.REGISTRATION_ROUTE:
      return CupertinoPageRoute(builder: (_) => RegisterRoute());
      case Constants.OTP_VERIFICATION_ROUTE:
      return CupertinoPageRoute(builder: (_) => OTPVerificationRoute());   
        case Constants.RE_AUTH_ROUTE:
      return CupertinoPageRoute(builder: (_) => ReAuthRoute()); 
     case Constants.APP_INFO_ROUTE:
      return CupertinoPageRoute(builder: (context) => AppInfoRoute());
    case Constants.SETTINGS_ROUTE:
      return CupertinoPageRoute(builder: (context) => SettingsRoute(), fullscreenDialog: true);
       case Constants.SUCCESSFUL_PARCEL_SENT_ROUTE:
      return CupertinoPageRoute(builder: (context) => SuccessfulParcelRoute());
       case Constants.FORGOT_PASSWORD_ROUTE :
      return CupertinoPageRoute(builder: (context) => ForgotPasswordRoute());
       case Constants.SET_NEW_PASSWORD_ROUTE :
      return CupertinoPageRoute(builder: (context) => SetNewPasswordRoute());
       case Constants.PASSWORD_UPDATED_SUCCESSFULLY_ROUTE :
      return CupertinoPageRoute(builder: (context) => PasswordUpdatedSuccessfullyRoute());
      case Constants.PARCEL_RECEIVING_OFFICERS_ROUTE :
      return CupertinoPageRoute(builder: (context) => ForgotPasswordRoute());
      case Constants.PARCEL_DELIVERY_OFFICERS_ROUTE :
      return CupertinoPageRoute(builder: (context) => ForgotPasswordRoute());
      


      
      
  }
  return CupertinoPageRoute(builder: (context)=>UnknownRoute());
  
}
