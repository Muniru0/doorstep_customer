
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/model_registry.dart';
import 'package:doorstep_customer/models/auth_model.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/routes/otp_verification_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/validators.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class ForgotPasswordRoute extends StatefulWidget {

 
  @override
  _ForgotPasswordRouteState createState() => _ForgotPasswordRouteState();
}

class _ForgotPasswordRouteState extends State<ForgotPasswordRoute> {
 late double _w;
 late double _h;
 late AuthModel _authModel;

  TextEditingController _emailController = TextEditingController();

late  bool activateSignInButtons ;
late  UserModel _userModel;

  @override
  initState(){
    super.initState();
    _authModel = register<AuthModel>();
    _userModel = register<UserModel>();
    activateSignInButtons = false;
  }

  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<AuthModel>(
     screenTitle: 'Forgot Password',
     showSettingsIcon: false,
     child: Container(
        width: _w,
           height: _h * 0.9,
           padding: EdgeInsets.symmetric(horizontal: 20.0),
       child: 
             Column(
                
                 children: [
                   Container(
                   margin: EdgeInsets.only(bottom: 5.0,top: _h * 0.1),
                   child:Text("Reset Password", style: TextStyle(color: warmPrimaryColor,fontSize: 22.0, fontWeight: FontWeight.w900)
                 ),
                 ),
   Container(
         width: _w * 0.95,
         margin:EdgeInsets.only(bottom:20.0),
         child: Text("Enter credentials to reset your password.",textAlign: TextAlign.center, style:TextStyle(color: subHeadingsColor, fontSize: 11.0, )),

   ),
  

    Container(
         margin: EdgeInsets.only(bottom: 20.0),
         child:
          
          UtilityWidgets.broadCustomTextField(_emailController,symbol: '',hint: "Enter Your Email / phone", onChanged: (String passwordCredential)async{
                       
              if(isEmail(passwordCredential) || isPhoneNumber(passwordCredential)){
              
                if(activateSignInButtons) return;
               setState((){
                 activateSignInButtons = true;
                      });

               
         }
         else{
         if(!activateSignInButtons)return ;
    setState((){
               activateSignInButtons = false;
            });
                        
          }
          },),
   ),
  
     
         Container(
         margin: EdgeInsets.only(bottom: 10.0, top: 20.0),
         child: 
         UtilityWidgets.customConfirmationButton(
               context,()async{
                   if(isEmail(_emailController.text) || isPhoneNumber(_emailController.text)){

                      var resetInstructionsText = '';
       UtilityWidgets.requestProcessingDialog(context,title:isEmail(_emailController.text) ? 'Sending reset link...' : 'Sending verification code...');
              if(isEmail(_emailController.text)){
             
             await _authModel.sendPasswordResetLink(_emailController.text);
              resetInstructionsText = 'We have sent password reset instructions to the mail on file.';
               
                }else{
                await   _authModel.sendOTPCode(phoneNumber: _emailController.text);
                   resetInstructionsText = 'Please verify the code sent to your phone to continue';
               
                }
                  Navigator.pop(context);
                  UtilityWidgets.requestSuccessDialog(context,title: isEmail(_emailController.text) ? 'Reset Link ' : 'Verification Code ', desc: resetInstructionsText,cancelText: 'Ok',cancelAction: (){
                    Navigator.pop(context);
                    if(isPhoneNumber(_emailController.text)){
                     Navigator.push(context,CupertinoPageRoute(builder: (context)=> OTPVerificationRoute(hasCustomerAfterVerificationAction: true,customerAfterVerificationAction: ()async{
                        Navigator.pushNamedAndRemoveUntil(context, Constants.SET_NEW_PASSWORD_ROUTE, (route) => false);
                     
                       return;
                     })));
                    }
                  });
            
         }

               

               },confirmationText: 'Reset Password',isLong: true,isDisabled: !activateSignInButtons
         )
   
   ),
                 ]
               ),
           
        
     ),      
    );
  }
}