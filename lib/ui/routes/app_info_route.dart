

import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class AppInfoRoute extends StatefulWidget {
  @override
  _AppInfoRouteState createState() => _AppInfoRouteState();
}

class _AppInfoRouteState extends State<AppInfoRoute> {
  @override
  Widget build(BuildContext context) {
    return BaseView<UserModel>(
           screenTitle: "Application Information",
           isBackIconVisible: true,
           child: Column(
             children: [
               SizedBox(height: 20.0),
               Container(
                
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     fit: BoxFit.cover,
                     image: AssetImage(Constants.LOGO),
                   )
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(top: 15.0),
                 child: Text(Constants.APP_VERSION, style: TextStyle(color: warmPrimaryColor, fontSize: subHeadingsSize, fontWeight: FontWeight.bold),),
               ),
              InkWell(
                onTap: (){
                  print("Launch browser Url");
                },
                  child: Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 15.0,right: 10.0 ),
            margin: EdgeInsets.only(bottom: 20.0),
            child: Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Container(
                    
                    child: Text("Website", style: TextStyle(
                          color: warmPrimaryColor.withOpacity(0.65),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w900 ,
                        )),
                      ),
                      Expanded(child: SizedBox()),
  Container(
    margin:EdgeInsets.only(right: 15),
  child: Text("https://www.4pay.me", style: TextStyle(decoration: TextDecoration.underline,color: warmPrimaryColor, fontWeight: FontWeight.bold,fontSize: 13.0,))
),

    
                                                    
                                                      
            ])),
  ),
    Container(child: Text("Terms of use", style: TextStyle(color: buttonBorderColor, fontSize: subHeadingsSize,fontWeight: FontWeight.bold))),                                         
  ]
           ),
        );
      }
    }
   //<a href="https://iconscout.com/icons/ecology" target="_blank">Ecology Icon</a> by <a href="https://iconscout.com/contributors/jemismali">Jemis Mali</a> on <a href="https://iconscout.com">Iconscout</a>
   //<a href="https://iconscout.com/icons/group" target="_blank">Group Icon</a> by <a href="https://iconscout.com/contributors/google-inc" target="_blank">Google Inc.</a>
  //  Photo by <a href="https://unsplash.com/@jessbaileydesigns?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Jess Bailey</a> on <a href="https://unsplash.com/s/photos/parcels?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
  // Photo by <a href="https://unsplash.com/@anniespratt?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Annie Spratt</a> on <a href="https://unsplash.com/s/photos/parcels?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
  // Photo by <a href="https://unsplash.com/@daniellemah?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Danielle Mah</a> on <a href="https://unsplash.com/s/photos/parcels?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
  
  
  
