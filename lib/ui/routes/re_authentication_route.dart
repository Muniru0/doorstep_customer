
import 'dart:ffi';
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/model_registry.dart';
import 'package:doorstep_customer/models/auth_model.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/services/data_models/user_data_model.dart';
import 'package:doorstep_customer/services/utils/local_auth.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_animations/simple_animations.dart';

class ReAuthRoute extends StatefulWidget {
  @override
  _ReAuthRouteState createState() => _ReAuthRouteState();
}

class _ReAuthRouteState extends State<ReAuthRoute> {
  TextEditingController _passwordController = TextEditingController();
  CustomAnimationControl _animationControl = CustomAnimationControl.play;
  late double _w;
  late double _h;
  var showPassword = false;
  var showBlurredOverlay = false;
  bool activateSignInButtons = false;
  String storedPassword = "";
  late  OverlayEntry _overlayEntry;
  late MyUser _user;
  late AuthModel _authModel;
  bool _isPasswordValid = false;
  bool _showBlurredOverlay = false;
  late bool overlayLock;
  CustomAnimationControl _animControl = CustomAnimationControl.play;
  
  late bool isLoading;

  registerChoice() {
    setState(() {
      showBlurredOverlay = false;
    });
    _overlayEntry.remove();
  }

  @override
  initState() {
    super.initState();

    _user = register<UserModel>().getUser;
    _authModel = register<AuthModel>();
    
    
    isLoading = true;
    overlayLock = false;
    
  }


 @override
  void dispose() {
   _passwordController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return BaseView<UserModel>(
      isBlankBaseRoute: true,
      showBlurredOverlay: _showBlurredOverlay,
      child:Container(
              padding: EdgeInsets.only(top: 120.0, left: 20.0, right: 20.0),
              child: Column(
                children: [


                  Container(
                  margin: EdgeInsets.only(top: _h * 0.02),
                  child: Icon(AntDesign.user,
                   color: Colors.black.withOpacity(0.2),
                    size: 70.0 ),
                  ),

                  Container(
                    width: _w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: _h * 0.02),
                    child: Text("Welcome Back", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))
                  ),
                  


                  
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                      var firstName = "";
                      if (_user.fullname != null) {
                        if (_user.fullname!.contains(" ")) {
                          var splitName =
                              _user.fullname!.split(" ");
                          firstName = splitName[0];
                        }
                      }

                      return
                       Container(
                    width: _w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10.0, bottom:15.0),
                    child: Text(firstName, style:TextStyle(
                                color: false ? subHeadingsColor : warmPrimaryColor,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold)
                    )
                  );
                
                    }),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 25.0),
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                            print('-------PHONE NUMBER---------');
                            print(_user.phoneNumber);
                            print('-------END-------------------');
                        return Text(
                            "${_user.phoneNumber.substring(0, 3)}-${_user.phoneNumber.substring(3, 6)}-${_user.phoneNumber.substring(6, 10)}",
                            style: TextStyle(color: Color(0xFFcdcece), fontSize: 14.0) );
                      })),
               
               
                  Container(
                    child: UtilityWidgets.broadCustomTextField(
                      _passwordController,
                      obscureText: true,
                      onChanged: (String password) {
                        if (
                            password.length >= 8) {
                          if (_isPasswordValid == true) return;
                          setState(() => _isPasswordValid = true);
                        } else {
                          if (!_isPasswordValid) return;
                          setState(() => _isPasswordValid = false);
                        }
                      },
                      hint: "Enter Your Password",
                      symbol: "",
                    ),
                  ),
                 
                  Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Constants.FORGOT_PASSWORD_ROUTE);
                          },
                          child: Text("forgot Password",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline)))),
                  Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                        return UtilityWidgets.customConfirmationButton(context,
                            () async {
                          if (!_isPasswordValid) return;
                          UtilityWidgets.requestProcessingDialog(context,
                              title: "Signing In");
                             
                       
                          var res = await _authModel.reauthenticateUserWithPassword(_user.email,_passwordController.text,_user.userRole);
                         
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }

                         if(res['result']){
          var route = Constants.UNKNOWN_ROUTE;
          
          if(res['data'] == null){
            
                    // send the user to their home screens
                    // they are no records found for their respective companies.
                    if(_user.userRole == Constants.COURIER_SERVICE_DIRECTOR_ROLE ){
                    route = Constants.WELCOME_ROUTE;
                    }else if(_user.userRole == Constants.COURIER_SERVICE_BRANCH_MANAGER_ROLE){
                      route = Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE;
                    }else if(_user.userRole == Constants.COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_ROLE){
                    route = Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE;
                   }
          }else{

                    // send the user to their home screens
                    // provided they belong to a company
                    if(_user.userRole == Constants.COURIER_SERVICE_DIRECTOR_ROLE ){
                    route = Constants.COURIER_DIRECTOR_HOME_ROUTE;
                    }else if(_user.userRole == Constants.COURIER_SERVICE_BRANCH_MANAGER_ROLE){
                      route = Constants.COURIER_MANAGER_HOME_ROUTE;
                    }else if(_user.userRole == Constants.COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_ROLE){
                    route = Constants.COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_HOME_ROUTE;
                   }
          }
         
           Navigator.pushNamed(context, route);
                        return;

      }
    
      UtilityWidgets.requestErrorDialog(context,title: 'Sign-In ',desc: res['desc'],cancelAction: (){
        Navigator.pop(context);
      });

           
                        },
                            confirmationText: "SIGN IN",
                            isLong: true,
                            isDisabled: !_isPasswordValid);
                      })),
                  Container(
                      margin: EdgeInsets.only(bottom: 25.0),
                      child: customConfirmationButton()),
                  Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      child: InkWell(
                          onTap: () {
                            if(overlayLock){
                              return;
                            }
                            setState(() => _showBlurredOverlay = true);
                            _overlayEntry = UtilityWidgets.confirmationOverlay(
                                context, _animControl,
                                desc:
                                    "Are you sure you want to SignOut Completely ?\n\t\t This will make your next login lasts longer  than usual.",
                                confirmAction: () async {
                              setState((){
                                 _showBlurredOverlay = false;
                                 overlayLock = false;
                                 });
                              _overlayEntry.remove();
                              UtilityWidgets.requestProcessingDialog(context,
                                  title: "Signing Out...");
                              await Future.delayed(Duration(seconds: 1));
                            var res =   await _authModel.signOutCompletely();
                             if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            if(!res['result']){
                              print(res);
                              UtilityWidgets.requestErrorDialog(context,title:'Sign-out',desc:res['desc'],cancelAction: (){
                                Navigator.pop(context);
                              });
                              return;
                            }
                             
                             Future.delayed(Duration(seconds: 2));
                                Navigator.pushNamedAndRemoveUntil(context,
                                    Constants.LOGIN_ROUTE, (route) => false);
                            
                            }, cancelAction: () {
                              removeOverlay();
                            },
                                confirmationText: "SIGN OUT",
                                cancelText: "CANCEL");

                            Overlay.of(context)!.insert(_overlayEntry);
                            setState(() {
                              overlayLock = true;
                            });
                          },
                          child: Text("Sign Out",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline)))),
                ],
              ),
            ),
    );
  }

  fadedCustomTextField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      //   margin: EdgeInsets.only(bottom: 15.0 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border:
            Border.all(width: 0.5, color: Color(0xFF182e65).withOpacity(0.2)),
      ),
      child: Row(children: [
        Container(
          width: 250,
          padding: EdgeInsets.only(right: 15.0),
          margin: EdgeInsets.only(left: 25.0),
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: _passwordController,
            obscureText: !showPassword,

            textAlign: TextAlign.center,
            style: TextStyle(
              color: warmPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 19.0,
            ),
            autofocus: true,
            //cursorColor: Color(0xFF636B85),
            cursorColor: warmPrimaryColor,
            decoration: InputDecoration.collapsed(
              hintText: "Enter your password",
              hintStyle: TextStyle(
                color: Color(0xFFd7e0ef),
                fontSize: 13,
              ),
            ),
            onChanged: (String password) {
              if (password.length >= 8) {
                if (activateSignInButtons) return;
                setState(() {
                  activateSignInButtons = true;
                });
              } else {
                if (!activateSignInButtons) return;

                setState(() {
                  activateSignInButtons = false;
                });
              }
            },
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          child: Container(
            child: Icon(Feather.eye,
                color: !showPassword
                    ? Color(0xFF182e65).withOpacity(0.2)
                    : primaryColor,
                size: 17),
          ),
        ),
      ]),
    );
  }

  customConfirmationButton() {
    return InkWell(
      onTap: () async {
        var res = await requestLocalAuth(msg: "Scan to unlock your account.");
       
        if (!res["result"] ) {
          if(res['desc'].isEmpty){
            return;
          }
          UtilityWidgets.requestErrorDialog(context,
              title: "Biometrics", desc: res["desc"], cancelAction: () {
            Navigator.pop(context);
          });
          return;
        }
        
        UtilityWidgets.requestProcessingDialog(context, title: "Signing in...");
         res  = await _authModel.reauthenticateWithBiometrics(userRole: _user.userRole);
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
     

      
      if(res['result']){
          var route = Constants.UNKNOWN_ROUTE;
          
          if(res['data'] == null){
            
                    // send the user to their home screens
                    // they are no records found for their respective companies.
                    if(_user.userRole == Constants.COURIER_SERVICE_DIRECTOR_ROLE ){
                    route = Constants.WELCOME_ROUTE;
                    }else if(_user.userRole == Constants.COURIER_SERVICE_BRANCH_MANAGER_ROLE){
                      route = Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE;
                    }else if(_user.userRole == Constants.COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_ROLE){
                    route = Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE;
                   }
          }else{

                    // send the user to their home screens
                    // provided they belong to a company
                    if(_user.userRole == Constants.COURIER_SERVICE_DIRECTOR_ROLE ){
                    route = Constants.COURIER_DIRECTOR_HOME_ROUTE;
                    }else if(_user.userRole == Constants.COURIER_SERVICE_BRANCH_MANAGER_ROLE){
                      route = Constants.COURIER_MANAGER_HOME_ROUTE;
                    }else if(_user.userRole == Constants.COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_ROLE){
                    route = Constants.COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_HOME_ROUTE;
                   }
          }
         
           Navigator.pushNamed(context, route);
           return;

      }
    
      UtilityWidgets.requestErrorDialog(context,title: 'Sign-In ',desc: res['desc'],cancelAction: (){
        Navigator.pop(context);
      });
          
      },
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        elevation: 30.0,
        shadowColor: Color(0xFFFFFFFF),
        child: Container(
          width: _w * 0.92,
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: brightMainColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(right: 15.0),
                  child: Text("Fingerprint",
                      style: TextStyle(
                          color: warmPrimaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0))),
              Container(
                child: Icon(Ionicons.ios_finger_print,
                    color: warmPrimaryColor.withOpacity(0.9)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void removeOverlay() {
   
    setState(() {
       _showBlurredOverlay = false;
       overlayLock = false;
    
    });
    _overlayEntry.remove();
  }
}
