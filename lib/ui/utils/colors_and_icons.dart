import 'dart:ui';
import 'package:flutter/material.dart';


//const Color subHeadingsColor  = Color(0xFF8399b1);
//const Color subHeadingsColor = Color(0xFF376498);
const Color subHeadingsColor  = Color(0xFF7d95af);
//const Color subHeadingsColor   = Color(0xFF666a6f);
const Color baseRouteBackgroundColor = Color(0xFFf5fafe);
const Color warmGreenColor = Color(0xFF51c7ca);
const Color cornedButtonColor = Color(0xFF0f60c7);
const Color buttonBorderColor = Color(0xFF2dc733);
const Color greenMainColor    = Color(0xFF02ba76);
const Color subsidiaryColor = Color(0xFF02ba76);
const Color buttonBlue     = Color(0xFF0f60c7); 
const Color goldColor       =  Color(0xFFffdf00);
const Color primaryColor     = true ? goldColor : (true ? warmPrimaryColor :Color(0xFF2dc733)); 
const Color fadedHeadingsColor = Color(0xFFb1b6bb);
const Color warmPrimaryColor = Color(0xFF182e65);
const Color secondaryColor   =  Color(0xFFE8F5E9);
const Color silverColor      = Color(0xFFC0C0C0);
const Color warmSecondaryColor = Color(0xFFf5fafe);
const Color linkColor         = Color(0xFF32c9f9);
const Color screenBackgroundColor = Color(0xFFF6F9FD);
      Color splashColor      = warmPrimaryColor.withOpacity(0.09);
const Color fadeTextColor    =  Color(0xFF7991ab);
const Color darkMainColor    = Color(0xFF947633);
const Color black            = Color(0xFF000000);
const Color white            = Color(0xFFFFFFFF);
const Color  errorColor      = Color(0xFFc65149);
const Color darkColor          = Color(0xff01394a);
const Color lightMainColor   = Color(0xFFfef8e0);
const Color lightBlue        = Color(0xFFe6edfe);
const Color brightMainColor  = Color(0xFFcf9a25);

const Color logoBackgroundColor = Color(0xFFe6e6e6);
const Color logoColorWhite = Color(0xFFffffff);
const Color logoMainColor = Color(0xFFbf884e);

 Widget loadingIndicator({width = 30.0,height = 30.0,valueColor = primaryColor}){
   return Container(width:width ,height:height ,child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(valueColor)));
 }

 // font Sizes
 double headingsSize = 16.0;
 double subHeadingsSize = 13.0;
class CustomIcons{


static const IconData checkMark = IconData(62463,fontFamily:"Ionicons",fontPackage:"flutter_icons");
static const IconData home = IconData(58974,fontFamily:"AntDesign",fontPackage:"flutter_icons");
static const IconData edit = IconData(59026,fontFamily:"AntDesign",fontPackage:"flutter_icons");
static const IconData close = IconData(62470,fontFamily:"Ionicons",fontPackage:"flutter_icons");
static const IconData heart = IconData(61759,fontFamily:"Ionicons",fontPackage:"flutter_icons");
static const IconData info = IconData(59772,fontFamily:"Feather",fontPackage:"flutter_icons");

static const IconData back_arrow = IconData(59664,fontFamily:"Feather",fontPackage:"flutter_icons");

static const IconData forward_arrow = IconData(59666,fontFamily:"Feather",fontPackage:"flutter_icons");



}


