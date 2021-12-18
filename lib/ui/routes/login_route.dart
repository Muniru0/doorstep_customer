
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/model_registry.dart';
import 'package:doorstep_customer/models/auth_model.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/routes/signup_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:validators/validators.dart';






class LoginRoute extends StatefulWidget {

  final bool fromOnBoardingRoute;
  LoginRoute({this.fromOnBoardingRoute = false});

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  double? _w;
  double? _h;

  bool? emailFieldActive;

  TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    FocusNode emailFocusNode = FocusNode();
    FocusNode passwordFocusNode = FocusNode();

  CustomAnimationControl emailAnimationControl = CustomAnimationControl.play;
  CustomAnimationControl passwordAnimationControl = CustomAnimationControl.playReverseFromEnd;

  String? _emailErrorText;

  String? _passwordErrorText;
  AuthModel? _authModel;
  UserModel? _userModel;

  late bool showAppropriateRoleSelectionWidget;
  
  @override
  void initState() {
    
    super.initState();
    emailFieldActive = true;
    showAppropriateRoleSelectionWidget = false;
    _emailErrorText ='';
    _passwordErrorText = '';
    _authModel = register<AuthModel>();
    _userModel = register<UserModel>();
    handleInputFieldsFocus();
  }

  void handleInputFieldsFocus(){
      emailFocusNode.addListener(() { 
        setState(() {

        
      if(emailFocusNode.hasFocus){
       emailAnimationControl = CustomAnimationControl.play;
      } else{
        emailAnimationControl = CustomAnimationControl.playReverseFromEnd;
      }
     });

    });

     passwordFocusNode.addListener(() { 
       setState((){
        if(passwordFocusNode.hasFocus){
         passwordAnimationControl = CustomAnimationControl.play;
       }else{
        passwordAnimationControl = CustomAnimationControl.playReverseFromEnd;
      }
       });
    });
  
  }
  
  
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return  
      BaseView<AuthModel>(
        isBlankBaseRoute: true,
              child: Stack(
                children: [
                  Container(
        width: _w,
        height: _h,

        child: ListView(
                    shrinkWrap: true,
                    children: [
                  //   InkWell(onTap: (){
                  //           if(Navigator.canPop(context)){
                  // Navigator.pop(context);
                  //           }
                        
                         
                  //         },
                  //             child: Container(
                  //             width: _w,
                  //             alignment: Alignment.centerLeft,
                  //             margin: EdgeInsets.only(top: _h! * 0.05,left: 20.0),
                          
                  //           child: Icon(Ionicons.ios_arrow_back,
                  //            color: primaryColor,
                  //             size: 17.0 ),
                  //           ),
                  //         ),
                  

                   PlayAnimation<double>(
                        tween: Tween(begin: 0.0,end: 1.0),
                        duration:const Duration(seconds: 1),
                        curve: Curves.bounceInOut,
                        builder: (context, child,value) {
                          return Container(
                            width: _w,
                            margin:EdgeInsets.only(top: 20.0),
                            alignment: Alignment.center,
                           // margin:const EdgeInsets.only(left: 15.0),
                            child: RichText(text:  TextSpan(
                              children: [
                                  TextSpan(
                                  text: 'Doorstep ',
                                  style: TextStyle(color: black,fontSize: 25.0 * value,fontWeight: FontWeight.bold)
                                ),
                                TextSpan(
                                  text: 'Business',
                                  style: GoogleFonts.italianno(textStyle: TextStyle(color: brightMainColor,fontSize: 30.0 * value,fontWeight: FontWeight.bold)),
                                ),
                               
                              ]
                            )),
                          );
                        }
                      ),



                      Container(
                      margin: EdgeInsets.only(top: _h! * 0.03),
                      padding: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:Color(0xFFC0C0C0).withOpacity(0.5),
                      ),
                      child: Icon(AntDesign.user,
                       color: Colors.black.withOpacity(0.2),
                        size: 70.0 ),
                      ),

                      Container(
                        width: _w,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: _h! * 0.02),
                        child: Text("Welcome", style: GoogleFonts.italianno(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0)))
                      ),
                      Container(
                        width: _w,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10.0, bottom:65.0),
                        child: Text("Sign to Continue", style: TextStyle(color: Color(0xFFcdcece), fontSize: 14.0))
                      ),

          CustomAnimation<double>(
                            duration: Duration(milliseconds: 500),
                            tween: Tween(begin: 0.0,end: 1.0),
                            curve: Curves.easeInOut,
                            control: emailAnimationControl,
                            builder: (context, snapshot,animValue) {
                              return Container(
                   height: 60.0,
                   width: _w,

                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: BoxDecoration(
                              
                              borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Material(
                              elevation: animValue * 20  ,
                              shadowColor: Colors.white,
                         borderRadius: BorderRadius.circular(7.0),
                              child: Container(
                                padding: EdgeInsets.all(7.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20.0,bottom: 5.0),
                                      child: Text('EMAIL', style: TextStyle(color: warmPrimaryColor,fontWeight: FontWeight.bold, fontSize: 12.0)),
                                    ),

                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 7.0),
                                          child: Icon(Feather.mail, color: brightMainColor,size: 14.0),
                                        ),

                                          Container(
                                      width: _w! * 0.7,
                                       padding: EdgeInsets.only(right: 15.0), child: TextField(
                                        keyboardType: TextInputType.name ,
                                        controller: emailController,
                                       focusNode: emailFocusNode,
                                       textAlign: TextAlign.start,
                                       autofocus: true,
                                       
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 14.0,
                                          fontWeight : FontWeight.bold,
                                        ),
                                       cursorColor: warmPrimaryColor,
                                        decoration: InputDecoration.collapsed(
                                          hintText: 'email',
                                          hintStyle: TextStyle(
                                            color: Color(0xFFd7e0ef),
                                            fontSize: 13,
                                          ),
                                        ),
                                        onChanged: (String fullname){

                                        },
                                      ),
                                    ),
                  
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        )
                      );
                            }
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: Text(_emailErrorText!, style: TextStyle(color: errorColor, fontSize: 15.0))
                          ),
       
                     
                  CustomAnimation<double>(
                            duration: Duration(milliseconds: 500),
                            tween: Tween(begin: 0.0,end: 1.0),
                            curve: Curves.easeInOut,
                            control: passwordAnimationControl,
                            builder: (context, snapshot,animValue) {
                              return Container(
                   height: 60.0,
                   width: _w,
                      margin: EdgeInsets.only(top: 40.0),
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: BoxDecoration(
                              
                              borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Material(
                              elevation: animValue * 20  ,
                              shadowColor: Colors.white,
                         borderRadius: BorderRadius.circular(7.0),
                              child: Container(
                                padding: EdgeInsets.all(7.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20.0,bottom: 5.0),
                                      child: Text('PASSWORD', style: TextStyle(color: warmPrimaryColor,fontWeight: FontWeight.bold, fontSize: 12.0)),
                                    ),

                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 7.0),
                                          child: Icon(Feather.lock, color:brightMainColor,size: 14.0),
                                        ),

                                          Container(
                                      width: _w! * 0.7,
                                       padding: EdgeInsets.only(right: 15.0), child: TextField(
                                        keyboardType: TextInputType.name ,
                                        controller: passwordController,
                                       focusNode: passwordFocusNode,
                                       textAlign: TextAlign.start,
                                     
                                       obscureText: true,
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 14.0,
                                          fontWeight : FontWeight.bold,
                                        ),
                                       cursorColor: warmPrimaryColor,
                                        decoration: InputDecoration.collapsed(
                                          hintText: 'password',
                                          hintStyle: TextStyle(
                                            color: Color(0xFFd7e0ef),
                                            fontSize: 13,
                                          ),
                                        ),
                                        onChanged: (String fullname){

                                        },
                                      ),
                                    ),
                  

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        )
                      );
                            }
                          ),
                  Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: Text(_passwordErrorText!, style: TextStyle(color: errorColor, fontSize: 15.0))
                          ),

                  //  SizedBox(height: 20.0,),

                     InkWell(
                       onTap: (){
                         Navigator.pushNamed(context, Constants.FORGOT_PASSWORD_ROUTE);
                       },child: Container(margin: EdgeInsets.only(top:15.0,left: 190.0 ),alignment: Alignment.centerLeft , child: Text('Forgot Password?', style: TextStyle(color:brightMainColor, fontSize: 14.0)))),
                   
                   Container(
                     margin:EdgeInsets.only(bottom: 30,top: 15),
                     child: InkWell(
                       onTap: ()async{

          if(!validateInputFields()){return;}

          UtilityWidgets.requestProcessingDialog(context,title: 'Signing...');
        
        Map _authResult = await  _authModel!.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim(),);
                  
          
                  
          Navigator.pop(context);
            print(_authResult);
 

          // if there was a success response
          if(_authResult['result']){



            // check if the user obj is not null,
            // then refresh the user and company models
            if(_authResult['user_obj'] != null){

                if(_authResult.containsKey('update_user_role')){

                    setState(() {
                      showAppropriateRoleSelectionWidget = true;
                    });
                  return;

                }
        // refresh the user model before                
        _userModel!.refreshUserModel(user:_authResult['user_obj'] );
          
          // if the user has not yet verified his phone let him verify it. 
          if(!_authResult['phone_verification']){
       Map<String,dynamic> res = await  _authModel!.sendOTPCode(phoneNumber: _userModel!.getUser.phoneNumber) ;
                        if(!res['result']){
                        UtilityWidgets.requestErrorDialog(context,title: 'Sending Code',desc: res['desc'],cancelAction: (){
                          Navigator.pop(context);
                        } );

                      Navigator.pushNamed(context, Constants.OTP_VERIFICATION_ROUTE);
                      return;
                        }
                                 
                                }
                                  
                        
                   
                   // send them to the appropriate screen if they dont have a company yet.
                     else{

                          print('Entered the else statement');
                                  var route = Constants.UNKNOWN_ROUTE;
                                     // send the user to the appropriate screen 
                              // depending on their roles 
                              if(_userModel!.getUser.userRole == Constants.COURIER_SERVICE_DIRECTOR_ROLE ){
                               route = Constants.WELCOME_ROUTE;
                              }else {
                              route =  Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE;

                                     }
                                
                                Navigator.pushNamed(context,route);
                                return;
                              }
                        }
                        print('got here ---------------------');
                        return;
                        }
                       
                        UtilityWidgets.requestErrorDialog(context,title: 'Sign-In',desc: _authResult['desc'], cancelAction: (){
                          Navigator.pop(context);
                        },cancelText: 'Ok');

           },
                     
                     
                       child: 
                       Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          color: brightMainColor,
                          borderRadius: BorderRadius.circular(5.0),
                     
                        ),
                        margin: EdgeInsets.only(bottom: 00.0,top: 00.0,left: 20.0, right: 20.0),
                         child: Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0,color: white )),
                       ),
                     ),
                   ),

     Row(
         mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        child: Text("Don't have account?",  style: TextStyle(
                            color: Color(0xFF898989) ,
                            fontSize: 14.0,
                          ),
                      ),
                      ),
                      InkWell(onTap: (){
                      
                        if(Navigator.canPop(context)){
                          if(widget.fromOnBoardingRoute){
                             Navigator.pushNamed(context, Constants.SIGNUP_ROUTE);
                             return;
                          }
                               Navigator.pop(context);
                        }else{
                       Navigator.push(context, CupertinoPageRoute(builder:(context)=> SignUpRoute()));
                        }
                     
                      
                      },child: Container(child: Text(" Create a new account", style: TextStyle(color: primaryColor, fontSize: 14.0),))),
                    ],
                  ),






                  SizedBox(height: 90.0),
                   UtilityWidgets.copyrightWidget(_w),
                   SizedBox(height: 10.0),
                    ],
                  ),
            
                  
         
          
        ),
                 Positioned.fill(
                 child:Visibility(visible: showAppropriateRoleSelectionWidget,child: AnimatedOpacity(curve: Curves.easeInOut,opacity: showAppropriateRoleSelectionWidget ? 0.4 : 0.0  ,duration: Duration(seconds: 1),child: Container(color: black.withOpacity(0.4))))
                ),
                AnimatedPositioned(
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 1),
                  bottom:showAppropriateRoleSelectionWidget ? -15.0 : -_h!,
                  child: Material(
                  elevation: 25.0,
                  borderRadius: BorderRadius.circular(15.0),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        showAppropriateRoleSelectionWidget = false;
                      });
                    },
                    child: Container(
                      height: _h! * 0.35,
                      width: _w,
                      padding:EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: _w! * 0.1,
                            height: 7.0,
                            margin: EdgeInsets.only(bottom: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: silverColor,
                            ),
                          ),
                  
                          Container(
                            width: _w,
                           
                              margin: EdgeInsets.only(left: 20.0,bottom: 20.0),
                            child:Text('Please select your role',style:GoogleFonts.rajdhani(textStyle: TextStyle(color: warmPrimaryColor,fontSize: 17.5,fontWeight: FontWeight.bold))) ,
                          ),
                  
                          selectApproriateRoleWidget(Constants.COURIER_SERVICE_DIRECTOR_ROLE,isFirst: true,),
                          selectApproriateRoleWidget(Constants.COURIER_SERVICE_BRANCH_MANAGER_ROLE),
                          selectApproriateRoleWidget(Constants.COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_ROLE),
                        
                      
                        ],
                      ),
                    ),
                  ),
                ))
        
             
                ],
              ),
      )
      
    ;

  }

dynamic validateInputFields(){

        _emailErrorText = '';
        _passwordErrorText = '';
        if(!isEmail(emailController.text)){
          print('invalid email');
          _emailErrorText = 'Please provide a valid email.';
        }

        if(!isLength(passwordController.text, 8)){
          print('Invalid Password');
          _passwordErrorText = 'Please password must be atleast 8 characters long.';
        }

        if(_emailErrorText!.isNotEmpty || _passwordErrorText!.isNotEmpty){
          // emailFocusNode.requestFocus();
          // FocusScope.of(context).unfocus();
            setState((){});
          return false;
        }

      

        return true;
}


Widget inputField({icon, title = '',hint = '',positionedHeight = 0.45, textFieldController, isActive = false,focusNode}){
  return   
  Positioned(
           top: _h! * positionedHeight  ,
                    child: CustomAnimation<double>(
                      duration: Duration(milliseconds: 500),
                      tween: Tween(begin: 0.0,end: 1.0),
                      curve: Curves.easeInOut,
                      control: isActive ? CustomAnimationControl.PLAY : CustomAnimationControl.PLAY_REVERSE_FROM_END ,
                      builder: (context, snapshot,animValue) {
                        return Container(
             height: 60.0,
             width: _w,

                padding: EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Material(
                        elevation: animValue * 20  ,
                        shadowColor: Colors.white,
                   borderRadius: BorderRadius.circular(7.0),
                        child: Container(
                          padding: EdgeInsets.all(7.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.0,bottom: 5.0),
                                child: Text(title, style: TextStyle(color: Color(0xFFb1b6bb),fontWeight: FontWeight.bold, fontSize: 12.0)),
                              ),

                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 7.0),
                                    child: Icon(Feather.mail, color: Color(0xFF02ba76),size: 14.0),
                                  ),

                                    Container(
                                width: _w! * 0.7,
                                 padding: EdgeInsets.only(right: 15.0), child: TextField(
                                  keyboardType: TextInputType.name ,
                                  controller: textFieldController,
                                 focusNode: focusNode,
                                 textAlign: TextAlign.start,
                                 autofocus: hint == 'email',
                                 
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12.0,
                                    fontWeight : FontWeight.bold,
                                  ),
                                 cursorColor: warmPrimaryColor,
                                  decoration: InputDecoration.collapsed(
                                    hintText: hint,
                                    hintStyle: TextStyle(
                                      color: Color(0xFFd7e0ef),
                                      fontSize: 13,
                                    ),
                                  ),
                                  onChanged: (String fullname){

                                  },
                                ),
                              ),
            


                                  // Container(
                                  //   child: Text(hint, style: TextStyle(color: Color(0xFF02ba76) )),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  )
                );
                      }
                    ),
         );
            
       
}



Widget selectApproriateRoleWidget(role,{isFirst = false}){
  return  InkWell(
     onTap: ()async{

       

          if(!validateInputFields()){return;}

          setState(() {
            showAppropriateRoleSelectionWidget = false;
          });
          UtilityWidgets.requestProcessingDialog(context,title: 'Signing...');
        
        Map _authResult = await  _authModel!.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim(),);
                  
          
                  
          Navigator.pop(context);
            print(_authResult);
 

          // if there was a success response
          if(_authResult['result']){

            // check if the user obj is not null,
            // then refresh the user and company models
            if(_authResult['user_obj'] != null){


        // refresh the user model before                
        _userModel!.refreshUserModel(user:_authResult['user_obj'] );
          
          // if the user has not yet verified his phone let him verify it. 
          if(!_authResult['phone_verification']){
       Map<String,dynamic> res = await  _authModel!.sendOTPCode(phoneNumber: _userModel!.getUser.phoneNumber) ;
                        if(!res['result']){
                        UtilityWidgets.requestErrorDialog(context,title: 'Sending Code',desc: res['desc'],cancelAction: (){
                          Navigator.pop(context);
                        } );

                      Navigator.pushNamed(context, Constants.OTP_VERIFICATION_ROUTE);
                      return;
                        }
                                 
                                }
                                  
                            // update the company model
                           if(_authResult['company_obj'] != null){
                            
                                   

                                var route = Constants.UNKNOWN_ROUTE;
                                
                              // send the user to their home screens
                              // provided they belong to a company
                              


                   }
                   // send them to the appropriate screen if they dont have a company yet.
                     else{

                          print('Entered the else statement');
                                  var route = Constants.UNKNOWN_ROUTE;
                                     // send the user to the appropriate screen 
                              // depending on their roles 
                              if(_userModel!.getUser.userRole == Constants.COURIER_SERVICE_DIRECTOR_ROLE ){
                               route = Constants.WELCOME_ROUTE;
                              }else {
                              route =  Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE;

                                     }
                                
                                Navigator.pushNamed(context,route);
                                return;
                              }
                        }
                        print('got here ---------------------');
                        return;
                        }
                       
                        UtilityWidgets.requestErrorDialog(context,title: 'Sign-In',desc: _authResult['desc'], cancelAction: (){
                          Navigator.pop(context);
                        },cancelText: 'Ok');

           },
                     
    child: Container(
                            padding:isFirst ? EdgeInsets.symmetric(vertical: 20.0) : EdgeInsets.only(bottom: 20.0),
                            
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:40.0,
                                  child: Icon(Feather.user,color: brightMainColor,size: 17.0),
                                ),
                                Container(width: _w! * 0.7,padding: EdgeInsets.only(bottom: 20),decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 0.3,color:warmPrimaryColor.withOpacity(0.3))),
                            ),child: Text(role,style: TextStyle(color: warmPrimaryColor,fontSize: 13.5,fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
  );
                    
}



}











// class LoginRoute extends StatefulWidget{

// @override
//   _LoginRouteState createState() => _LoginRouteState();
// }

// class _LoginRouteState extends State<LoginRoute>{

//   TextEditingController _emailController = TextEditingController();
//   RegExp  alphaNumericFilter = RegExp("r[A-Z/0-9/a-z/@{1}/.]\w+");
//   OverlayEntry _overlayEntry;
//   CustomAnimationControl _animControl = CustomAnimationControl.PLAY;
//   bool _showBlurredOverlay = false;
//   @override
//   Widget build(BuildContext context) {
//     return BaseView<RegistrationModel>(
//      showBlurredOverlay: _showBlurredOverlay,
//      screenTitle : "Register",
//       child:Container(
//        // margin: EdgeInsets.only(top: 30.0),
//         padding: EdgeInsets.only(right: 20.0,left: 20.0,top: 30.0),
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(bottom: 15.0),
//               child: Text("ENTER YOUR PHONE NUMBER", style: TextStyle(fontSize: 22.0, color: warmPrimaryColor,fontWeight: FontWeight.w900,)),
//             ),
//             Container(
//               margin:EdgeInsets.only(bottom: 50.0),
//               width: 180.0,
//               child: Text("Use the phone to register or login to 4pay",textAlign: TextAlign.center, style: TextStyle(color: warmPrimaryColor.withOpacity(0.2),fontSize:12.0,fontWeight: FontWeight.w900, )),
//             ),

//             fadedCustomTextField(_emailController,onChanged:(String email){
//       if(alphaNumericFilter.allMatches(email).length == email.length){

//       }
//             }, hint: "Enter your phone number here", symbol: ""),

//             Container(
//               child: UtilityWidgets.customConfirmationButton(context,(){
//        _overlayEntry = UtilityWidgets.verifyPhonePrompt(context,_overlayEntry,_animControl,cancelOnTap: (){
//          setState((){
//            _showBlurredOverlay = false;
//          });
//         _overlayEntry.remove();
//        }, confirmOnTap: (){
//          setState((){
//            _showBlurredOverlay = false;
//          });
//          _overlayEntry.remove();
//        });

//               },confirmationText: "NEXT",isDisabled: false, isLong: true),
//             ),
//           ],
//         ),
//       ) ,
//     );
//   }

// static fadedCustomTextField(controller, {FocusNode focusNode,void Function (String text) onChanged,isErrorBorder = false,symbol="₵",width = 250.0, marginTop:0.0, marginBottom: 15.0 , hint='', vertPad: 10.0, horizPad: 10.0}){

// return        Container(
//                         padding: EdgeInsets.symmetric(vertical: vertPad,horizontal: horizPad),
//                         margin: EdgeInsets.only(bottom: marginBottom,top: marginTop ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                          border: Border.all(width: 0.5, color:isErrorBorder ? errorColor: Color(0xFF182e65).withOpacity(0.2)),
//                         ),
//                       child: Row(

//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(right: 10.0),
//                           child: Text(symbol, style: TextStyle(color: warmPrimaryColor, fontWeight: FontWeight.bold                                     )),
//                           ),

//                        Container(
//                             width: width,
//                             padding: EdgeInsets.only(right: 15.0), child: TextField(
//                               keyboardType: TextInputType.phone,
//                               controller: controller,
//                              focusNode: focusNode,
//                              textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: warmPrimaryColor,
//                                 fontWeight : FontWeight.bold,
//                               ),
//                               autofocus: true,
//                               //cursorColor: Color(0xFF636B85),
//                               cursorColor: warmPrimaryColor,
//                               decoration: InputDecoration.collapsed(
//                                 hintText: hint,
//                                 hintStyle: TextStyle(
//                                   color: Color(0xFFd7e0ef),
//                                   fontSize: 13,
//                                 ),
//                               ),
//                               onChanged: onChanged,
//                             ),
//                           )

//                         ]
//                       ),

//                         );

//   }

// }


// class LoginRoute extends StatefulWidget {
//   @override
//   _LoginRouteState createState() => _LoginRouteState();
// }

// class _LoginRouteState extends State<LoginRoute> {
//   TextEditingController _textFieldController = TextEditingController();

//   var validationError = "";
//   bool _showBlurredOverlay = false;
//   UserModel _userModel!;
//   bool isPasswordValid = false;
//   TextEditingController _passwordController = TextEditingController();
//   bool _credentialValid = false;

//   @override
//   initState() {
//     super.initState();
//     _userModel! = locator<UserModel>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BaseView<UserModel>(
//       showBlurredOverlay: _showBlurredOverlay,
//       screenTitle: "Login",
//       showSettingsIcon: false,
//       isBackIconVisible: false,
//       child: Container(
//         // margin: EdgeInsets.only(top: 30.0),
//         padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 30.0),
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(bottom: 15.0),
//               child: Text("ENTER YOUR LOGIN CREDENTIALS",
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: warmPrimaryColor,
//                     fontWeight: FontWeight.w900,
//                   )),
//             ),
//             Container(
//               margin: EdgeInsets.only(bottom: 30.0),
//               width: 240.0,
//               child: Text("Use your email to login to 4pay",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: subHeadingsColor,
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.w900,
//                   )),
//             ),
//             UtilityWidgets.broadCustomTextField(_textFieldController,
//                 textAlign: TextAlign.center, onChanged: (String value) {
//               value = value.trim();
//               if (value.isEmpty) {
//                 if (!_credentialValid) return;
//                 setState(() => _credentialValid = false);
//                 return;
//               }

//               // if (filterDigitsOnly(value) && value.length == 10) {
//               //   if (_credentialValid) return;
//               //   print("phone Number is valid");
//               //   setState(() => _credentialValid = true);
//               // } else
//                if (isEmail(value)) {
//                 if (_credentialValid) return;
//                 print("email is valid");
//                 setState(() => _credentialValid = true);
//               } else {
//                 if (!_credentialValid) return;

//                 print("credential not valid");
//                 setState(() => _credentialValid = false);
//               }
//             }, hint: "Enter your Email", symbol: ""),
//             Container(
//                 child: UtilityWidgets.fadedCustomTextField(_passwordController,
//                     obscureText: true, onChanged: (String password) {
//               setState(() {
//                 if (filterDigitsOnly(password) && password.length == 6) {
//                   if (isPasswordValid) return;
//                   print("password");
//                   isPasswordValid = true;
//                 } else {
//                   if (!isPasswordValid) return;
//                   print("password is invalid.");
//                   isPasswordValid = false;
//                 }
//               });
//             },
//                     hint: "Enter password",
//                     symbol: "",
//                     vertPad: 13.0,
//                     horizPad: 13.0)),
//             Container(
//               margin: EdgeInsets.only(top: 10.0),
//               child: UtilityWidgets.customConfirmationButton(context, () async {
//                 // if (filterDigitsOnly(_textFieldController.text.trim())) {
//                 //   if (_textFieldController.text.trim().length != 10) {
//                 //     if (validationError == "Invalid phone Number length.")
//                 //       return;
//                 //     setState(
//                 //         () => validationError = "Invalid phone Number length.");
//                 //   } else {
//                 //     if (validationError.isEmpty) return;
//                 //     setState(() => validationError = "");
//                 //   }
//                 // } else
//                  if (filterEmail(_textFieldController.text.trim())) {
//                   if (_textFieldController.text.trim().length != 10) {
//                     if (validationError == "Invalid email  length.") return;
//                     setState(() => validationError = "Invalid email length.");
//                   } else {
//                     if (validationError.isEmpty) return;
//                     setState(() => validationError = "");
//                   }
//                 }

//                 if (!_credentialValid) return;
//                 UtilityWidgets.requestProcessingDialog(context,
//                   );
//                 var res;
//                 if (isEmail(_textFieldController.text.trim())) {
//                   res = await _userModel!.signInWithEmailAndPassword(
//                       email: _textFieldController.text.trim(),
//                       password: _passwordController.text.trim());
//                 }else{
//                   return;
//                 }
                
                 
//                 if (Navigator.canPop(context)) {
//                   Navigator.pop(context);
//                 }
//                 if (!res["result"]) {
//                   UtilityWidgets.requestErrorDialog(context,
//                       title: "SignIn", desc: res["desc"], cancelAction: () {
//                     Navigator.pop(context);
//                   });
//                   return;
//                 }

//                 Navigator.pushNamedAndRemoveUntil(
//                     context, Constants.HOME_ROUTE, (route) => false);
//               },
//                   confirmationText: "LOGIN",
//                   isLong: true,
//                   isDisabled: !(_credentialValid && isPasswordValid)),
//             ),
//             Container(
//                 margin: EdgeInsets.only(top: 30.0),
//                 child: InkWell(
//                     onTap: () {
//                       if (Navigator.canPop(context)) {
//                         Navigator.pop(context);
//                       } else {
//                         Navigator.pushNamed(
//                             context, Constants.REGISTRATION_ROUTE);
//                       }
//                     },
//                     child: Navigator.canPop(context)
//                         ? Text(" Back",
//                             style: TextStyle(
//                                 color: primaryColor,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w900,
//                                 decoration: TextDecoration.underline))
//                         : Text("Register",
//                             style: TextStyle(
//                                 color: primaryColor,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w900,
//                                 decoration: TextDecoration.underline)))),
//           ],
//         ),
//       ),
//     );
//   }

//   static fadedCustomTextField(controller,
//       {FocusNode focusNode,
//       void Function(String text) onChanged,
//       isErrorBorder = false,
//       symbol = "₵",
//       width = 250.0,
//       marginTop: 0.0,
//       marginBottom: 15.0,
//       hint = '',
//       vertPad: 10.0,
//       horizPad: 10.0}) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: vertPad, horizontal: horizPad),
//       margin: EdgeInsets.only(bottom: marginBottom, top: marginTop),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         border: Border.all(
//             width: 0.5,
//             color: isErrorBorder
//                 ? errorColor
//                 : Color(0xFF182e65).withOpacity(0.2)),
//       ),
//       child: Row(children: [
//         Container(
//           width: width,
//           // padding: EdgeInsets.only(right: 15.0)

//           // ,
//           child: TextField(
//             keyboardType: TextInputType.phone,
//             controller: controller,
//             focusNode: focusNode,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: warmPrimaryColor,
//               fontWeight: FontWeight.bold,
//             ),
//             autofocus: true,
//             //cursorColor: Color(0xFF636B85),
//             cursorColor: warmPrimaryColor,
//             decoration: InputDecoration.collapsed(
//               hintText: hint,
//               hintStyle: TextStyle(
//                 color: Color(0xFFd7e0ef),
//                 fontSize: 13,
//               ),
//             ),
//             onChanged: onChanged,
//           ),
//         )
//       ]),
//     );
//   }
// }


