
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:flutter/material.dart';

class CustomerProfileRoute extends StatefulWidget {
  const CustomerProfileRoute({ Key? key }) : super(key: key);

  @override
  _CustomerProfileRouteState createState() => _CustomerProfileRouteState();
}

class _CustomerProfileRouteState extends State<CustomerProfileRoute> {

  late double _w;
  late double _h;
  @override
  Widget build(BuildContext context) {

    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return BaseView<UserModel>(
      child: Container(
        width: _w,
        height: _h,
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}