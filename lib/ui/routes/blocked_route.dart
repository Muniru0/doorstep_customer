
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';

class BlockedRoute extends StatefulWidget {
  @override
  _BlockedRouteState createState() => _BlockedRouteState();
}

class _BlockedRouteState extends State<BlockedRoute> {
late  double _w;
late  double _h;

  @override
  Widget build(BuildContext context) {

    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<UserModel>(
      isBlankBaseRoute: true,
      child: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text('Request Blocked', style: TextStyle(color: warmPrimaryColor,fontWeight: FontWeight.bold))
              ),

              Row(
                children: [
                  Container(
                    child: Text('Contact', style: TextStyle(color: silverColor, fontSize: 13.0))
                  ),
                  Container(child: Text(' Administrator ',style: TextStyle(color: silverColor,fontSize: 13, decoration: TextDecoration.underline

                  )),),
                  Container(
                    child: Text('for further assistance.', style: TextStyle(color: silverColor, fontSize: 13.0))
                  ),
                ],
              ),
              
          ],
      ),
        ),

    ));
  }
}