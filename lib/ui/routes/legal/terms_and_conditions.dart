
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsRoute extends StatefulWidget {
  @override
  _TermsAndConditionsRouteState createState() => _TermsAndConditionsRouteState();
}

class _TermsAndConditionsRouteState extends State<TermsAndConditionsRoute> {
  
  late double _w;
  late double _h;
  
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<UserModel>(
      screenTitle: 'Terms and Conditions',
      child: Container(
        width: _w,
        height: _h * 0.9 ,
        padding: EdgeInsets.only(top: 40.0,left: 20.0,right: 20.0),
        child:ListView(
          shrinkWrap: true,
          children: [
            Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  width: _w,

                  margin: EdgeInsets.only(bottom: 40.0),
                  child: Text('ACCEPTANCE OF TERMS AND CONDITIONS',textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0))
                ),
                Container(
                  
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Text('WARNING',style: TextStyle(color: warmPrimaryColor.withOpacity(0.9),fontSize: 18.0)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Text('Any user of 4payGH who in any shape of form may not comply completely with the Terms And Conditions of 4payGH is hereby ordered to close this app or website immediately. By procceeding confirms the accceptance of the reader or user to all the Terms And Conditions of 4payGH. 4payGH under no circumstatnce is to be held responsible for any damage,injury,loss of any kind incurred by the user as a result of using any service provided by 4payGH. Users use,rely and distribute information obtained from our platforms at their own risk and under no circumstance is 4payGh guaranteeing the accuracy of any information provided through our platforms.4payGh is not liable to any loss of any kind due to the usage of information provided through our platforms.', style: TextStyle(fontSize: 13.0)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Text("As Doorstep we go a long way to establish and maintain as system as safe,secure and convenient as possible with your privacy in mind. But not under any circumstance should you or anyone's private information be exposed as a result of your use our platform can we be held responsible for that. You use this platform and the services of Doorstep at your own risk.", style: TextStyle(fontSize: 13.0)),
                ),

                   Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Text('AMENDEMENT OF TERMS AND CONDITIONS',style: TextStyle(fontSize: 18.0)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Text('4payGH has the exclusive right and discretion to at any point in time amend or remove any part of these terms and conditions without prior notice to you.These modifications can come to effect as and when 4payGh decides. You agree to periodically review and update yourself on these ongoing changes.\n\t ',style: TextStyle(fontSize: 13.0)),
                ),

                  Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Text('TERMS AND CONDITIONS',style: TextStyle(fontSize: 18.0)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Text('Your use of 4payGH is subject but not limited to your acceptance of these conditions: 1. You are under no circumstance supposed to attempt to decompile, reveal or in any way obtain the source code behind our applications(website, app,etc). 2. You agree to receive verification codes,promotional messages(be them email, phone calls, text messages,etc),transaction notification messages and messages to other phone numbers you might have put on the our system without prior knowledge or their owners. 3. 4payGh is not to be held responsible in any way should those people to which messages are sent claim ignorance of accepting to these Terms And Conditions.', style: TextStyle(fontSize: 13.0)),
                  
                ),


                  //TODO: update
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Text('You agree that by your use of this platform you consent to the fact that authorized people without your approval may have access to your private information including but not limited to emails,phone numbers , addresses,etc made available to them by your use of this platform.', style: TextStyle(fontSize: 13.0)),)
              ]
            ),
          ],
        )
      ),
    );
  }
}