

import 'package:validators/validators.dart';


bool filterDigitsOnly(input) {
  return RegExp("[0-9]").allMatches(input).length == input.length;
}

bool filterEmail(String email) {
  return isEmail(email);
}

bool isPhoneNumber(phoneNumber){
 return (isNumeric(phoneNumber) && isLength(phoneNumber, 10,10) && phoneNumber.startsWith("0"));
}
bool filterFullname(fullname) {
  // print("len: ${fullname.length}");
  // print(RegExp("[A-Za-z\ ]").allMatches(fullname).length);
  // int numberOfMatched =  RegExp("A-Z\ ").allMatches(fullname).length;
  // print("numberof mathced: ${fullname.length}");
  return ((RegExp("[A-Za-z\ ]").allMatches(fullname).length ==
          fullname.length) &&
      fullname.length >= 3);
}

 dynamic validateSeparatedWords(String word){
       
       if(word.isNotEmpty){
        // if the town or city name contains a space
        if(word.contains(" ")){
           // split the name with respect to the space if any
              var splittedWord = word.split(' ');
              for(var element in splittedWord){
                if(!isAlpha(element)){
                 return false;
                   
                }else{
                  return true;
                }
              }
             
        }else{
          return (isAlpha(word) && word.length > 3);
        }
    
      
    }else{
    
     return null;
    }


  }



// import 'package:Business4pay/constants/constants.dart';
// import 'package:Business4pay/models/base_model.dart';
// import 'package:Business4pay/models/user_model.dart';
// import 'package:Business4pay/service_locator.dart';
// import 'package:Business4pay/ui/utils/colors_and_icons.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:developer';
// import 'dart:ui' as ui;
// import 'package:connectivity/connectivity.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:simple_animations/simple_animations.dart';
// import 'package:supercharged/supercharged.dart';

// class BaseView<T extends BaseModel> extends StatefulWidget {
//   final Widget child;
//   final Widget myCustomAppbar;
//   bool requestPermissions;
//   bool showBlurredOverlay;
//   bool showAuthorizationOverlay;
//   String screenTitle;
//   bool isBackIconVisible;
//   bool showSettingsIcon;
//   bool isParcelRoute;
//   bool isBlankBaseRoute;
//   var fabLocation;
//   var bottomNavBar;
//   var fab;
  
//   bool isFirstPageActive;
//   bool isSecondPageActive;
//   bool isThirdPageActive;
//   bool isFourthPageActive;
//   bool isFifthPageActive;


//   bool bottomInset;

//   bool showCustomNavBar;
  

//   BaseView(
//       {this.child,
//       this.myCustomAppbar,
//       this.showAuthorizationOverlay,
//       this.showBlurredOverlay = false,
//       this.screenTitle = "",
//       this.isBackIconVisible = true,
//       this.fabLocation,
//       this.bottomNavBar,
//       this.showCustomNavBar = false,
//       this.isFirstPageActive = true,
//       this.isSecondPageActive = false,
//       this.isThirdPageActive = false,
//       this.isFourthPageActive = false,
//       this.isFifthPageActive = false,
//       this.isParcelRoute = false,
//       this.showSettingsIcon = false,
//       this.isBlankBaseRoute = false,
//       this.bottomInset = false,
//       this.fab,
//       this.requestPermissions = true});

//   @override
//   _BaseViewState createState() => _BaseViewState<T>();
// }

// class _BaseViewState<T extends BaseModel> extends State<BaseView<T>>
//     with WidgetsBindingObserver {
//   var screenWidth;
//   var screenHeight;
//   var authenticationFlag = false;
//   LocalAuthentication authentication;
//   var hasInternetConnection = true;
//   BaseModel _baseModel = locator<BaseModel>();
//   var closeConnectionNotice;
//   var internetServicesStream;
//   UserModel _userModel;

  


//   @override
//   void initState() {
//     super.initState();
//     _userModel = locator<UserModel>();
    
//    _baseModel.getCurrentConStatus().then((value){ 
//      setState((){
       
//   hasInternetConnection = value;
//       });
//    });
//     if (widget.requestPermissions) {
//       checkPermissions();
//     }
//     WidgetsBinding.instance.addObserver(this);
//   }


//   Future<bool> _checkBiometrics() async {
//     var _canCheckBiometrics;
//     try {
//       // returns true or false depending on whether the users phone
//       // can check for biometrics.
//       _canCheckBiometrics = await authentication.canCheckBiometrics;
//       if (_canCheckBiometrics) {
//         return true;
//       }
//     } catch (e) {
//    log(e);
//     }

//     if (!mounted) return false;
//   }

//   @override
//   void dispose() {
//    super.dispose();
//     internetServicesStream.cancel();
//      WidgetsBinding.instance.removeObserver(this);
//   }

//   @override
//   void didChangeDependencies() {
  
//   internetServicesStream = _baseModel.subscribeToConStatus().listen((event) {
//      setState((){
//        if(event == ConnectivityResult.none){
         
//        hasInternetConnection = false; 
//        }else{
        
//          hasInternetConnection = true;
//        }

//      });
//    });
//     super.didChangeDependencies();
     

//   }

//   @override
//   didChangeAppLifecycleState(AppLifecycleState state) {
//     // if there is a change in the app lifeCycle,
//     // request the user to re-authenticate themselves

//     if (state == AppLifecycleState.resumed ||
//         state == AppLifecycleState.inactive ||
//         state == AppLifecycleState.paused ||
//         state == AppLifecycleState.detached) {
//       // if the is a change in the app life cycle state show the authorization overlay
   
//       setState(() {
//         // showAuthorizationOverlay = true;
//       });
//     }
//   }

//   Future<void> authenticate() async {
//     var authenticated;
//     try {
//       authenticated = await authentication.authenticateWithBiometrics(
//         localizedReason: "Please use your fingerprint to unlock your account.",
//         useErrorDialogs: true,
//         stickyAuth: true,
//       );
//     } on PlatformException catch (e) {
      
//     }

//     if (!authenticated) return;
//     // Navigator.pushNamed(context,Constants.HOME_SCREEN_ROUTE);
//   }
// CustomAnimationControl simpleAnimControl ;

//  double _w;
//   @override
//   Widget build(BuildContext context) {
//     _w = MediaQuery.of(context).size.width;
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight  = MediaQuery.of(context).size.height;
//     simpleAnimControl = widget.showBlurredOverlay ? CustomAnimationControl.PLAY : CustomAnimationControl.PLAY_REVERSE;
   
//     return    ScopedModel<T>(
//       model: locator<T>(),
//       child:
//       Scaffold(
//          backgroundColor:  Color(0xFFf5fafe),
//         resizeToAvoidBottomInset: widget.bottomInset,
//               body: 
//                  PlayAnimation<double>(
//                   tween: (0.7).tweenTo(1.0),
//                   curve: Curves.easeInOut,
//                    builder: (context, child, value) {
//                      return Opacity(
//                        opacity: value,
//                        child: Stack(
//                          alignment: Alignment.bottomCenter,
//                          children: [
//                          !widget.isBlankBaseRoute ?   Container(
//                             //color: Color(0xFFf5fafe),
//                                   width: screenWidth,
//                                   height: screenHeight,
//                                   child: 
//                                   Column(children:[
//                                       Material(
//                                       elevation: 10.0,
//                                       color: warmPrimaryColor ,
//                                       child: Container(
//                                         padding:EdgeInsets.only(top: 40.0, bottom: 10.0),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                               Opacity(
//                                                 opacity: widget.isBackIconVisible ? 1.0 : 0.0,
//                                                 child: InkWell(
//                                                 onTap:(){
//                                                   if(!widget.isBackIconVisible) return;
//                                                   if(Navigator.of(context).canPop()){
//                                                     Navigator.of(context).pop();
//                                                   }
                                                  
//                                                 },
//                                                 child: Container(
//                                                 margin: EdgeInsets.only(left: 15.0),
//                                                 child: Icon(Feather.arrow_left_circle ,color:white,size: 19),
//                                                 ),
//                                             ),
//                                               ),
                                           
//                                             Container(
//                                               child: Text(widget.screenTitle, style: TextStyle(fontWeight: FontWeight.bold,
//                                               color:white,
//                                               )),
//                                             ),
//                                             Opacity(
//                                               opacity:  widget.showSettingsIcon ? 1.0 : 0.0,
//                                               child: InkWell(
//                                                 onTap:(){
//                                                   if(!widget.showSettingsIcon) return;
//                 //  Navigator.of(context).pushNamed(_userModel.getUserType);
//                                                 },
//                                                 child: Container(
//     margin: EdgeInsets.only(right: 20.0),
//     child: Icon(Feather.settings, color:white,size: 15),
//                                                 ),
//                                               ),
//                                             ),
//                                           ]
//                                         ),
//                                       ),
//                                       ),
         
//            Stack(
//           children: <Widget>[
           
//               Container(
//                 width: screenWidth,
//                 //height: screenHeight * 0.87,
//                 child: widget.child,
                
//               ),
//                 Positioned(
//                             top: 4.0,
//                              child: Visibility(visible:!hasInternetConnection ,child:AnimatedContainer(
//                                         duration: Duration(milliseconds: 300),
//                                         width: screenWidth,
//                                         color:  Colors.red,
//                                         padding: EdgeInsets.symmetric(vertical: 10),
//                                         alignment: Alignment.center,
//                                         child:Text("You are currently offline.", style:TextStyle(color: Colors.white, fontSize: 12)),
//                                       ),)
                             
                                
                              
//               ),

//                              Positioned.fill(
//                              child: CustomAnimation<double>(
//                                         tween: (0.0).tweenTo(5.0),
//                                         control: simpleAnimControl,
//                                         duration: 500.milliseconds,
//                                         builder: (context, child, value) {
                                         
//                                           return  Visibility(
//                                       visible: !(value < 5.0) ,
//                                      child: BackdropFilter(
//                                         filter: ui.ImageFilter.blur(
//                                           sigmaX: value,
//                                           sigmaY: value,
                                          
//                                         ),
//                             child: Container(
//                                color: Colors.white.withOpacity(0.05),
//                              ),
//                ),);
//                                         }
//                                       ),
             
//            ),
          
//                 ]
//                 )
                     
                     
//                                   ]
//                                   )
//                                   )
//                         : 
                        
//               Container(
//                 width: screenWidth,
//                 child: widget.child,
                
//               ),
//               Positioned(
//                         top: 4.0,
//                          child: Visibility(visible:!hasInternetConnection ,child:AnimatedContainer(
//                                     duration: Duration(milliseconds: 300),
//                                     width: screenWidth,
//                                     color:  errorColor,
//                                     padding: EdgeInsets.symmetric(vertical: 10),
//                                     alignment: Alignment.center,
//                                     child:Text("You are currently offline.", style:TextStyle(color: Colors.white, fontSize: 12)),
//                                   ),)
                         
                            
                          
//               ),

//       Positioned(
//                            bottom: 0.0,
                           
//                            child: 
//                            Visibility(
//                              visible:  widget.showCustomNavBar ,
//                                                         child: Material(
//                                elevation: 10.0,
//                                 borderRadius: BorderRadius.circular(12),
//                                                   child: Container(
//                                  decoration: BoxDecoration(
//                                       color: white,
//                                       borderRadius: BorderRadius.circular(12.0),
//                                  ),
//                                   width: _w ,
//                                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                    children:     [
                          
//                                   bottomNavigationBarItem(Feather.home,onTap: (){}, isActive: 
//                                   widget.isFirstPageActive, hasBadge: true ,),
//                  bottomNavigationBarItem(Ionicons.ios_stats,onTap: (){}, isActive:  widget.isSecondPageActive , hasBadge: false  ),
//                                       bottomNavigationBarItem(Feather.users,onTap: (){}, isActive:  widget.isThirdPageActive , hasBadge: false ),  bottomNavigationBarItem(Feather.user_plus,onTap: (){}, isActive: widget.isFourthPageActive, hasBadge: false  ),  bottomNavigationBarItem(Feather.settings,onTap: (){}, isActive: widget.isFifthPageActive , hasBadge: false ),
                                  
                                           
                            
                                   
//                                      ]
                            
                                
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
                        
//                          ],
//                        ),
//                      );
//                    }
//                  )
//                ,
                
//                         floatingActionButton: widget.fab,
//                         floatingActionButtonLocation: widget.fabLocation,
//                         bottomNavigationBar: widget.bottomNavBar,
//                         )
                      

//                 ) ;
               
//     }





//   // check and request various permissions.
//   void checkPermissions() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.phone,
//       Permission.contacts,
//       Permission.storage,
//       Permission.location
//     ].request();
//   }
  


//  Widget bottomNavigationBarItem(IconData icon,{ VoidCallback onTap, isActive = false, hasBadge = false}){
//    return 
// Stack(
//                               alignment: Alignment.topRight,
//                               children: [
//                                Container(
//                                  padding: EdgeInsets.all(7.0),
//                                  decoration: BoxDecoration(
//                                    shape: BoxShape.circle,
//                                    color: isActive ? Color(0xFFeceef0) : Colors.transparent,
//                                  ),
//                                  child: Icon(icon,size: 16 ),
//                            ),
//                            Positioned(
//                              child: AnimatedOpacity(
//                                opacity: hasBadge ? 1.0: 0.0,
//                                duration: Duration(milliseconds: 400),
//                                curve: Curves.easeInOut,
//                                                             child: Container(
//                                  width:7.0 ,
//                                  height: 7.0,
//                                  decoration: BoxDecoration(
//                                  color: errorColor,
//                                  shape: BoxShape.circle,
//                                    ),
                                
//                                ),
//                              ),
//                            ),
//                               ],
//                             );
                        
      
//  }


 
//     }
