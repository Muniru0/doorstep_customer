

import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';

class IsLoadingRoute extends StatefulWidget {
  @override
  _IsLoadingRouteState createState() => _IsLoadingRouteState();
}

class _IsLoadingRouteState extends State<IsLoadingRoute> {

 late double _w;
 late double _h;
  @override
  Widget build(BuildContext context) {
    
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return
      Scaffold(
        body: MirrorAnimation<double>(
        tween: Tween(begin: 0.8,end: 1.0),
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
          builder: (context, child,value) {
            return  
              Container(
                width: _w ,
                height: _h ,
                decoration: BoxDecoration(
                  color:logoMainColor.withOpacity(value) ,
                  // gradient: LinearGradient(
                  //   colors: [primaryColor.withOpacity(0.85),primaryColor,brightMainColor],
                  //   stops: [0.10,0.15 ,0.75 ],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                ),
               
                child: Center(
                  child: Column(
                    
                    //  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child:SizedBox(),flex: 1,),
                Text(  'Doorstep', style: GoogleFonts.raleway(textStyle:TextStyle(color: white,fontSize: 45.0 ,fontWeight: FontWeight.bold) ) 
                                  ),
                Text(
                'Everything Transport',
                style:GoogleFonts.italianno(textStyle:TextStyle(color: white,fontSize: 25.0 ,fontWeight: FontWeight.bold) ) 
              ),  
            
                      Expanded(child:SizedBox(),flex: 1,),
              UtilityWidgets.copyrightWidget(_w),   
                      // Container(
                      //   margin: EdgeInsets.only(top:_h * 0.45),
                      //   child: Text('Loading...', style: TextStyle(color: white, fontSize: 12.0, fontWeight: FontWeight.bold))
                      // ),
                      // loadingIndicator(valueColor: white),
                    
                    
                    ],
                  )
                ),
              )
            ;
          }
        ),
      )
    ;
  }
}