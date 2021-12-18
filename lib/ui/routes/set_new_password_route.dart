
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/model_registry.dart';
import 'package:doorstep_customer/models/auth_model.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:validators/validators.dart';

class SetNewPasswordRoute extends StatefulWidget {

 
  @override
  _SetNewPasswordRouteState createState() => _SetNewPasswordRouteState();
}

class _SetNewPasswordRouteState extends State<SetNewPasswordRoute> {
  late double _w;
  late double _h;
  late AuthModel _authModel;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  late bool activateSignInButtons ;
  late UserModel _userModel;

  late bool _passwordVisibility;

  late bool _confirmPasswordVisibility;

  @override
  initState(){
    super.initState();
    _authModel = register<AuthModel>();
    _userModel = register<UserModel>();
    activateSignInButtons = false;
    _passwordVisibility = false;
    _confirmPasswordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<AuthModel>(
     screenTitle: 'Reset Password',
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
                   child:Text("Set New Password", style: TextStyle(color: warmPrimaryColor,fontSize: 22.0, fontWeight: FontWeight.w900)
                 ),
                 ),
   Container(
         width: _w * 0.95,
         margin:EdgeInsets.only(bottom:20.0),
         child: Text("Enter your new password below",textAlign: TextAlign.center, style:TextStyle(color: subHeadingsColor, fontSize: 11.0, )),

   ),
  

    Container(
         margin: EdgeInsets.only(bottom: 20.0),
         child:
          
          UtilityWidgets.broadCustomTextField(_passwordController,focusNode: FocusNode(),symbol: '',hint: "New password", obscureText: !_passwordVisibility,enableTrailingIcon: true,iconAction: (){
            setState(() {
                _passwordVisibility = !_passwordVisibility;
            });
          },trailingIcon: !_passwordVisibility ? Feather.eye_off : Feather.eye,onChanged: (String passwordCredential)async{
           

              if(_passwordController.text.trim() == _confirmPasswordController.text.trim()){
              
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
         margin: EdgeInsets.only(bottom: 20.0),
         child:
          
          UtilityWidgets.broadCustomTextField(_confirmPasswordController,symbol: '',hint: "Confirm password",obscureText: !_confirmPasswordVisibility,enableTrailingIcon: true,iconAction: (){
            setState(() {
              _confirmPasswordVisibility = !_confirmPasswordVisibility;
            });
          },trailingIcon: !_confirmPasswordVisibility ? Feather.eye_off : Feather.eye, onChanged: (String confirmPassword)async{
                       
              if(_passwordController.text.trim() == _confirmPasswordController.text.trim()){
              
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
                 UtilityWidgets.requestProcessingDialog(context,title: 'Processing...');
              var res = await _authModel.updateUserPassword(email: _userModel.getUser.email,newPassword: _passwordController.text.trim());
              Navigator.pop(context);
              if(!res!['result']){
                UtilityWidgets.requestErrorDialog(context,title: 'Password Update',desc: res['desc']);
              }
                       if(res['result']){
                          Navigator.pushNamedAndRemoveUntil(context, Constants.PASSWORD_UPDATED_SUCCESSFULLY_ROUTE, (route) => false);
                          return;
                       }

                      
                       return;

               },confirmationText: 'Set Password',isLong: true,isDisabled: !activateSignInButtons
         )
   
   ),
                 ]
               ),
           
        
     ),      
    );
  }
}
