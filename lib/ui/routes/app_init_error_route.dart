
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class AppInitErrorRoute extends StatefulWidget {
  
  final String error;
  AppInitErrorRoute({this.error = ''});

  @override
  _AppInitErrorRouteState createState() => _AppInitErrorRouteState();

}

class _AppInitErrorRouteState extends State<AppInitErrorRoute> {
   
  late double _w;
  late double _h;
  
  @override
  Widget build(BuildContext context) {

    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return BaseView<UserModel>(
      screenTitle:"App Init Error" ,
      child: Container(width: _w,height: _h * 0.9,
      child:
       Column(
         children: [
          Container(
            margin: EdgeInsets.only(top: _h * 0.3, bottom: _h * 0.09),
            child: Icon(Feather.x,size: 35, color: Colors.grey ),
          ),
   
   Container(
     child: widget.error.isNotEmpty ? Text("Error Initializing App,please restart the app.If problem persists contact the Admin", style: TextStyle(color: warmPrimaryColor.withOpacity(0.3), fontSize: 15,)) : Text(widget.error, style: TextStyle(color: warmPrimaryColor.withOpacity(0.3), fontSize: 15,) )
   ),

          ],
          )
          ),
    );
  }
}