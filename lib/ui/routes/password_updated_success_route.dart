
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class PasswordUpdatedSuccessfullyRoute extends StatefulWidget {
  

  @override
  _PasswordUpdatedSuccessfullyRouteState createState() => _PasswordUpdatedSuccessfullyRouteState();
}

class _PasswordUpdatedSuccessfullyRouteState extends State<PasswordUpdatedSuccessfullyRoute> {
 
 late double _h;
 
  @override
  Widget build(BuildContext context) {
    _h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          height: _h,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  margin: EdgeInsets.only(top: 20,bottom: 100),
                  child: Text('Congratulations', style: TextStyle(color: brightMainColor, fontSize: 20.0,fontWeight: FontWeight.bold,)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Icon(Ionicons.md_checkmark_circle_outline, color: brightMainColor,size: 150.0)
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 15.0,top: 20.0),
                  child: Text('Password has being successfully updated.',style: TextStyle(color: warmPrimaryColor, fontSize: 14.0,fontWeight: FontWeight.bold)),
                ),

                Expanded(child: SizedBox()),
                
                   InkWell(
                     onTap: (){
                       Navigator.pushNamedAndRemoveUntil(context, Constants.LOGIN_ROUTE, (route) => false);
                     },
                     child: Container(
                       
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          decoration: BoxDecoration(
                            color: brightMainColor,
                            borderRadius: BorderRadius.circular(5.0),
                       
                          ),
                          margin: EdgeInsets.only(bottom: 50.0,left: 20.0, right: 20.0),
                           child: Text('GO TO LOGIN', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0,color: white )),
                         ),
                   ),
                     
              ],
            ),
          ),
        ),
    );
  }
}