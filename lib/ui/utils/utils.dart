import 'dart:ui';
import 'package:flutter/material.dart';


const Color primaryColor     = Color(0xFF2dc733);
const Color warmPrimaryColor = Color(0xFF182e65);
const Color secondaryColor   =  Color(0xFFE8F5E9);
const Color fadeTextColor    =  Color(0xFF7991ab);
const Color darkMainColor    = Color(0xFF947633);
const Color black            = Color(0xFF000000);
const Color white            = Color(0xFFFFFFFF);
const Color  errorColor      = Color(0xFFc65149);
const Color lightMainColor   = Color(0xFFfef8e0);
const Color lightBlue        = Color(0xFFe6edfe);
const Color brightMainColor  = Color(0xFFcf9a25);
const Color buttonBorderColor = Color(0xFF81b59b);
const Color warmSecondaryColor = Color(0xFFf5fafe);
const Color subHeadingsColor  = Color(0xFF7d95af);
 loadingIndicator({width = 30.0,height = 30.0,valueColor = brightMainColor}){
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

static const IconData back_arrow = IconData(59664,fontFamily:"Feather",fontPackage:"flutter_icons");

static const IconData forward_arrow = IconData(59666,fontFamily:"Feather",fontPackage:"flutter_icons");



}
