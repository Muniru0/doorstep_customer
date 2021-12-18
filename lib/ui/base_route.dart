
import 'package:doorstep_customer/model_registry.dart';
import 'package:doorstep_customer/models/base_model.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/helper_functions.dart/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:connectivity/connectivity.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget child;
  var myCustomAppbar;
  bool requestPermissions;
  bool showBlurredOverlay;
  bool showAuthorizationOverlay;
  String screenTitle;
  bool isBackIconVisible;
  bool showSettingsIcon;
  bool isParcelRoute;
  bool isBlankBaseRoute;
  var fabLocation;
  var bottomNavBar;
  var fab;
  bool bottomInset;


  

  BaseView(
      {required this.child,
      this.myCustomAppbar ,
      this.showAuthorizationOverlay = false,
      this.showBlurredOverlay = false,
      this.screenTitle = "",
      this.isBackIconVisible = true,
      this.fabLocation,
      this.bottomNavBar,
      this.isParcelRoute = false,
      this.showSettingsIcon = false,
      this.isBlankBaseRoute = false,
      this.bottomInset = true,
      this.fab,
      this.requestPermissions = true});

  @override
  _BaseViewState createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>>
    with WidgetsBindingObserver {
  var _w;
  var _h;
  var authenticationFlag = false;
 late LocalAuthentication authentication;
  var hasInternetConnection = true;
  BaseModel _baseModel = register<BaseModel>();
  var closeConnectionNotice;
  var internetServicesStream;





  @override
  void initState() {
    super.initState();
    if (widget.requestPermissions) {
      checkPermissions();
    }
   
    WidgetsBinding.instance!.addObserver(this);

  }

  @override
  void dispose() {
   super.dispose();
    internetServicesStream.cancel();
     WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeDependencies() {
  
  internetServicesStream = _baseModel.subscribeToConStatus().listen((event) {
    
      myPrint(event,heading: 'Connection Status');
     setState((){
        hasInternetConnection = event != ConnectivityResult.none;
   
     });

  });
  
    super.didChangeDependencies();
   }

late CustomAnimationControl simpleAnimControl ;


  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h  = MediaQuery.of(context).size.height;
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

   
    simpleAnimControl = widget.showBlurredOverlay ? CustomAnimationControl.play : CustomAnimationControl.playReverse;
   
    return    ScopedModel<T>(
      model: register<T>(),
      child:
      Scaffold(
         backgroundColor:  baseRouteBackgroundColor,
        resizeToAvoidBottomInset: widget.bottomInset,
              body: 
                 PlayAnimation<double>(
                  tween: (0.7).tweenTo(1.0),
                  curve: Curves.easeInOut,
                   builder: (context, child, value) {
                     return
                     
                        Opacity(
                         opacity: value,
                         child: Stack(
                           alignment: Alignment.bottomCenter,
                           children: [
                            //  Positioned(top: 0.0,child: Container(width: _w,height: 25.0,color: black.withOpacity(0.2),)),

                           widget.isBlankBaseRoute ?   Container(
                              //color: Color(0xFFf5fafe),
                                    width: _w,
                                    height: _h,
                                    child: 
                                    Column(children:[
                                        Material(
                                        elevation: 10.0,
                                        color: primaryColor ,
                                        child: Container(
                                          padding:EdgeInsets.only(top: 20.0, bottom: 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                                Opacity(
                                                  opacity: widget.isBackIconVisible ? 1.0 : 0.0,
                                                  child: InkWell(
                                                  onTap:(){
                                                    print('it is hitting here');
                                                    if(!widget.isBackIconVisible) return;
                                                    if(Navigator.of(context).canPop()){
                                                      Navigator.of(context).pop();
                                                    }
                                                    
                                                  },
                                                  child: Container(
                                                  margin: EdgeInsets.only(left: 15.0),
                                                  child: Icon(Feather.arrow_left_circle ,color:white,size: 19),
                                                  ),
                                              ),
                                                ),
                                             
                                              Container(
                                                child: Text(widget.screenTitle, style: TextStyle(fontWeight: FontWeight.bold,
                                                color:white,
                                                )),
                                              ),
                                              Opacity(
                                                opacity:  widget.showSettingsIcon ? 1.0 : 0.0,
                                                child: InkWell(
                                                  onTap:(){
                                                    if(!widget.showSettingsIcon) return;
                //  Navigator.of(context).pushNamed(_userModel.getUserType);
                                                  },
                                                  child: Container(
    margin: EdgeInsets.only(right: 20.0),
    child: Icon(Feather.settings, color:white,size: 15),
                                                  ),
                                                ),
                                              ),
                                            ]
                                          ),
                                        ),
                                        ),
         
           Stack(
          children: <Widget>[
           
              Container(
                width: _w,
                //height: _h * 0.87,
                child: widget.child,
                
              ),
                Positioned.fill(
                             
                               child: Visibility(visible:!hasInternetConnection ,child:AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          width: _w,
                                          color:  Colors.red,
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          alignment: Alignment.center,
                                          child:Row(
                                            children: [
                                              SizedBox(width: 35.0,child: Icon(Feather.cloud_off,color: white,size: 14.0)),
                                              Text("You are currently offline.", style:TextStyle(color: Colors.white, fontSize: 12)),
                                            ],
                                          ),
                                        ),)
                               
                                  
                                
              ),

                               Positioned.fill(
                               child: CustomAnimation<double>(
                                          tween: (0.0).tweenTo(5.0),
                                          control: simpleAnimControl,
                                          duration: 500.milliseconds,
                                          builder: (context, child, value) {
                                           
                                            return  Visibility(
                                        visible: !(value < 5.0) ,
                                       child: BackdropFilter(
                                          filter: ui.ImageFilter.blur(
                                            sigmaX: value,
                                            sigmaY: value,
                                            
                                          ),
                              child: Container(
                                 color: Colors.white.withOpacity(0.05),
                               ),
               )
               ,);
                                          }
                                        ),
             
           ),
          
                ]
                )
                     
                     
                                    ]
                                    )
                                    )
                          : 
                          
              Container(
                width: _w,
                child: widget.child,
                
              ),
                             Positioned.fill(
                               child: CustomAnimation<double>(
                                   tween: (0.0).tweenTo(5.0),
                                   control: simpleAnimControl,
                                   duration: 500.milliseconds,
                                   builder: (context, child, value) {

                                     return  Visibility(
                                       visible: !(value < 5.0) ,
                                       child: BackdropFilter(
                                         filter: ui.ImageFilter.blur(
                                           sigmaX: value,
                                           sigmaY: value,

                                         ),
                                         child: Container(
                                           color: Colors.white.withOpacity(0.05),
                                         ),
                                       ),);
                                   }
                               ),

                             ),

                             Positioned(
                          top: 4.0,
                           child: Visibility(visible:!hasInternetConnection ,child:AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: _w,
                                      color:  errorColor,
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      alignment: Alignment.center,
                                      child:Text("You are currently offline.", style:TextStyle(color: Colors.white, fontSize: 12)),
                                    ),)
                           
                              
                            
              ),

                
                           ],
                         ),
                     )
                      ;
                   }
                 )
               ,
                
                        floatingActionButton: widget.fab,
                        floatingActionButtonLocation: widget.fabLocation,
                        bottomNavigationBar: widget.bottomNavBar,
                        )
                      

                ) ;
               
    }





  // check and request various permissions.
  void checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.phone,
      Permission.contacts,
      Permission.storage,
      Permission.location
    ].request();
  }
  


 
    }
