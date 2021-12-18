
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:simple_animations/simple_animations.dart';


class SettingsRoute extends StatefulWidget{
  @override
  _SettingsRouteState createState() => _SettingsRouteState();
}



class _SettingsRouteState extends State<SettingsRoute>{


  bool _showBlurredOverlay = false;
  late OverlayEntry _overlayEntry;
  bool enableFingprintForParcels = false;
  bool enableFingerprintAuthorization = false;
  bool enableFastPayment              = false; 

  String _automaticAppLockTime = "2 min";
  CustomAnimationControl _animControl = CustomAnimationControl.play;
 

  @override
  Widget build(BuildContext context){

    return   BaseView<UserModel>(
               showBlurredOverlay: _showBlurredOverlay,
               screenTitle: "Settings",
               isBackIconVisible: true,
               showSettingsIcon: false,
               isBlankBaseRoute: true,
               child:
               Container(
                 height:720 * 0.95,
                 child: ListView(
                   shrinkWrap: true,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children:[
                         SizedBox(height: 30.0),
                         Container(
                           margin: EdgeInsets.only(bottom: 10.0),
                           padding: EdgeInsets.only(left: 15.0),
                           child: Text("Asked for a authorization when payment", style: TextStyle(color: warmPrimaryColor, fontSize: 14, fontWeight: FontWeight.bold)),
                         ),
                        Container(
                          margin:EdgeInsets.only(bottom: 15.0),
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text("Authorization of all transactions on 4pay Wallet is mandatory with either an Otp(which is not an sms) or fingerprint authentication(recommended).", style: TextStyle(color:Color(0xFFa3b4c8), fontSize: 12)),
                        ),
                        Container(
                          color: Color(0xFFFFFFFF),
                          padding: EdgeInsets.only(top: 15.0,bottom: 15.0,left: 15.0,right: 10.0 ),
                          margin: EdgeInsets.only(bottom: 35.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                
                                child: Text("Fingerprint Authorization", style: TextStyle(
                                  color: Color(0xFF91a3b7),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                )),
                                  ),

                                  InkWell(
                                    onTap: (){
                                      setState(() => enableFastPayment  = !enableFastPayment);
                                    },
                                    child: AnimatedContainer(
                                      duration:Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                      padding: EdgeInsets.all(1.5),
                                      width: 50.0,
                                      height: 25.0,
                                      alignment: enableFastPayment ? Alignment.centerRight: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        color: enableFastPayment ? Color(0xFF32cafa) : Color(0xFFf1f0f5) ,
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child:  Container(
                                         
                                        width: 24.0,
                                        height: 24.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          
                                        ),
                                      ),

                                      ),
                                  ),
                         
                         
                            ])),




                       Container(
                           margin: EdgeInsets.only(bottom: 15.0),
                           padding: EdgeInsets.only(left: 15.0),
                           child: Text("Account security", style: TextStyle(color: warmPrimaryColor, fontSize: 14, fontWeight: FontWeight.bold)),
                         ),

                         InkWell(
                           onTap: (){

                             Navigator.pushNamed(context, Constants.CONFIRM_PASSWORD_ROUTE);
                           },
                         child: Container(
                            color: Color(0xFFFFFFFF),
                            padding: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 15.0,right: 10.0 ),
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  
                                  child: Text("Change password", style: TextStyle(
                                        color: warmPrimaryColor.withOpacity(0.65),
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w900 ,
                                      ),
                                    ),),

                                    Container(
                                      child: Icon(Ionicons.ios_arrow_forward, size: 14.0,color: warmPrimaryColor.withOpacity(0.7))
                                    ),
                              ])),
                         ),
                              InkWell(
                                onTap: (){
                   
                    
                      },
                  child:
                  Container(
                color: Color(0xFFFFFFFF),
                padding: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 15.0,right: 10.0 ),
                margin: EdgeInsets.only(bottom: 10.0),
                child: Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
              Container(
                
                child: Text("App Automatically locks ", style: TextStyle(
                      color: warmPrimaryColor.withOpacity(0.65),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w900 ,
                    )),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
margin:EdgeInsets.only(right: 14),
                    child: Text(_automaticAppLockTime, style: TextStyle(color: warmPrimaryColor, fontWeight: FontWeight.bold,fontSize: 13.0,))
                  ),
                  Container(
                    
                    child: Transform.rotate(angle: 1.571,child: Icon(Ionicons.ios_arrow_forward, size: 14.0,color: warmPrimaryColor.withOpacity(0.7)))
                  ),

                
                  
          ])),
            
            ),


                                

                Container(
                color: Color(0xFFFFFFFF),
                padding: EdgeInsets.only(top: 15.0,bottom: 12.0,left: 15.0,right: 10.0 ),
                margin: EdgeInsets.only(bottom: 30.0),
                height: 105.0 ,
                child: Column(
                children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
    
    child: Text("Fingerprint Authentication", style: TextStyle(
      color: warmPrimaryColor.withOpacity(0.65),
      fontSize: 13.0,
      fontWeight: FontWeight.w900 ,
    )),
      ),
      
      InkWell(
        onTap: (){
          setState(() => enableFingerprintAuthorization = !enableFingerprintAuthorization);
        },
  child: AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    padding: EdgeInsets.all(1.5),
    width: 50.0,
    height: 25.0,
    alignment: enableFingerprintAuthorization ? Alignment.centerRight : Alignment.centerLeft,
    decoration: BoxDecoration(
        color: enableFingerprintAuthorization ? Color(0xFF32cafa) : Color(0xFFf1f0f5),
        borderRadius: BorderRadius.circular(15.0),
    ),
    child:  Container(
        
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          
        ),
    ),

    ),
      ),

    
      
]),

Container(
  margin:EdgeInsets.only(top: 12.0),
  child: Text("Note all fingerprints registered in the can be used for the authentication", style: TextStyle(color:Color(0xFFa3b4c8), fontSize: 12))
),
],
)),


Container(
color: Color(0xFFFFFFFF),
padding: EdgeInsets.only(top: 15.0,bottom: 12.0,left: 15.0,right: 10.0 ),
margin: EdgeInsets.only(bottom: 30.0),
height: 105.0 ,
child: Column(
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
  Container(
    
    child: Text("Fingerprint for parcels.", style: TextStyle(
      color: warmPrimaryColor.withOpacity(0.65),
      fontSize: 13.0,
      fontWeight: FontWeight.w900 ,
    )),
      ),
      
      InkWell(
        onTap: (){
          this.setState((){
              enableFingprintForParcels  = !enableFingprintForParcels;
          });
        },
    child: AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve:Curves.easeInOut,
    padding: EdgeInsets.all(1.5),
    width: 50.0,
    height: 25.0,
    alignment:enableFingprintForParcels ? Alignment.centerRight : Alignment.centerLeft,
    decoration: BoxDecoration(
        color: enableFingprintForParcels ? Color(0xFF32cafa) : Color(0xFFf1f0f5),
        borderRadius: BorderRadius.circular(15.0),
    ),
    child:  Container(
        
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          
        ),
    ),

    ),
      ),

    
      
]),

Container(
  height:40.0 ,
  margin:EdgeInsets.only(top: 12.0),
  child: Text("Note: Deactivating will make you enter a password before accessing your parcels qrCode.(which is not recommended)",overflow: TextOverflow.fade, style: TextStyle(color:Color(0xFFa3b4c8), fontSize: 12, ))
),
],
)),

Container(
margin: EdgeInsets.only(bottom: 15.0),
padding: EdgeInsets.only(left: 15.0),
child: Text("Other", style: TextStyle(color: warmPrimaryColor, fontSize: 14, fontWeight: FontWeight.bold)),
),

        InkWell(
        onTap: (){
        Navigator.pushNamed(context, Constants.APP_INFO_ROUTE);
        },
                                                      child: Container(
        color: Color(0xFFFFFFFF),
        padding: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 15.0,right: 10.0 ),
        margin: EdgeInsets.only(bottom: 15.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          
          child: Text("Application information", style: TextStyle(
            color: warmPrimaryColor.withOpacity(0.9),
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          )),
            ),

    Container(
      child: Icon(Ionicons.ios_arrow_forward, size: 14.0,color: warmPrimaryColor.withOpacity(0.7))
    ),
])),
),

  
        InkWell(
        onTap: (){
    //     Navigator.pushNamed(context, Constants.COURIER_AGENTS_ROUTE);
        },
            child: Container(
        color: Color(0xFFFFFFFF),
        padding: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 15.0,right: 10.0 ),
        margin: EdgeInsets.only(bottom: 15.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          
          child: Text("My Agents", style: TextStyle(
            color: warmPrimaryColor.withOpacity(0.9),
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          )),
            ),

    Container(
      child: Icon(Ionicons.ios_arrow_forward, size: 14.0,color: warmPrimaryColor.withOpacity(0.7))
    ),
])),
),

Container(padding: EdgeInsets.symmetric(horizontal: 15.0),margin: EdgeInsets.only(bottom: 15.0,left: 10.0, top: 20.0), child: 
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Container(

child: UtilityWidgets.customCancelButton(
context,
(){

},
cancelText: "Back"
),
),
Container(
padding: EdgeInsets.only(right: 10.0),
child:   UtilityWidgets.customConfirmationButton(context, (){}, confirmationText: "SIGN OUT"), )
]
),),

]
),
],
),
),


) ;
}
}
                           
                        


