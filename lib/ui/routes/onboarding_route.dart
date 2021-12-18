
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/ui/routes/login_route.dart';
import 'package:doorstep_customer/ui/routes/signup_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'dart:io';

import 'package:simple_animations/simple_animations.dart';

class OnboardingRoute extends StatefulWidget {
  @override
  _OnboardingRouteState createState() => _OnboardingRouteState();
}

class _OnboardingRouteState extends State<OnboardingRoute> {
  int slideIndex = 0;
 late PageController controller;
  Route _createRoute(firstRoute, secondRoute) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 350),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          secondRoute,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          Stack(
        children: <Widget>[
          SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(0.0, 0.0),
              end: const Offset(-1.0, 0.0),
            ).animate(animation),
            child: firstRoute,
          ),
          SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: secondRoute,
          )
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? brightMainColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    controller = new PageController();
  }

 late double _w;
 late double _h;

  @override
  Widget build(BuildContext context) {
    _h = MediaQuery.of(context).size.height;
    _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFf5fafe),
      body: Container(
        height: _h,
        color: Color(0xFFf5fafe),
        child: Stack(
          children: [
            Container(
              //height: _h,
              color: Color(0xFFf5fafe),
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    slideIndex = index;
                  });
                },
                children: <Widget>[
                  onBoardingWidget(
                      iconPath: Constants.PARCEL_ICON ,
                      title: "Manage your courier business.",
                      desc: "Like never before with outmost convenience."),
                  onBoardingWidget(
                      iconPath: Constants.PHONE_WITH_WALLET_ICON,
                      title: "Get real-time update of all parcel transfers",
                      desc:
                          "Get real time update of all parcel transfers in all branches of your business across the nation from the comfort of your mobile phone."),
                  onBoardingWidget(
                      iconPath: Constants.MAGNIFYING_GLASS_ICON ,
                      title: "Search through the archives of all branches",
                      desc:
                          "Search through all parcel transfers in all branches of your business anytime and anywhere."),
                  onBoardingWidget(
                      iconPath: Constants.SECURED_TRANSACTIONS_ICON,
                      title: "Enjoy convenience with security",
                      desc:
                          "With industry standard secured servers and technology our platform is convenient,safe and secured."),
                  onBoardingWidget(
                      iconPath: Constants.WALLET_AND_CARD_ILLUSTRATION,
                      title: "Increase the prospects of your business",
                      desc:
                          "With our easy to use platform, you are assured of a consistent growth through out your company."),
                  onBoardingWidget(
                      iconPath: Constants.PHONE_WITH_WALLET_ICON,
                      title: "All from your mobile phone",
                      desc:
                          "Enjoy the remarkable growth of your income right from your phone. Manage your business like never before"),
                ],
              ),
            ),
            Positioned(
              bottom: 30.0,
              child: slideIndex == 5
                  ? Container()
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 35.0),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  width: _w,
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 140.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      buildIndicator(active: slideIndex == 0),
                                      buildIndicator(active: slideIndex == 1),
                                      buildIndicator(active: slideIndex == 2),
                                      buildIndicator(active: slideIndex == 3),
                                      buildIndicator(active: slideIndex == 4),
                                      buildIndicator(active: slideIndex == 5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                          Container(
                            width: _w,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 10.0),
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: UtilityWidgets.customCancelButton(
                                          context, () {
                                  Navigator.push(context, CupertinoPageRoute(builder: (context)=> SignUpRoute(fromOnBoardingRoute: true,)));
                                  }, cancelText: "REGISTER")),
                                  Container(
                                      child: UtilityWidgets
                                          .customConfirmationButton(context,
                                              () {
                                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> LoginRoute(fromOnBoardingRoute: true,)));
                                  }, confirmationText: "LOGIN")),
                                ]),
                          ),
                    
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomSheet: slideIndex != 5
          ? null
          : 
         
          InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(_createRoute(widget, SignUpRoute()));
              },
              child: Container(
                height: Platform.isIOS ? 70 : 60,
                color: primaryColor,
                alignment: Alignment.center,
                child: Text(
                  "GET STARTED NOW",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
   
    );
  }

  buildIndicator({bool active = false}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 5.0,
          height: 5.0,
          decoration: BoxDecoration(
            color: warmPrimaryColor,
            shape: BoxShape.circle,
          ),
        ),
        Visibility(
          visible: active,
          child: PlayAnimation<double>(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              tween: (0.0).tweenTo(40.0),
              builder: (context, child, value) {
                return Opacity(
                  opacity: value / 40.0,
                  child: Card(
                    child: Container(
                      width: 14.0,
                      height: 14.0,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                    ),
                    elevation: value,
                    shadowColor: white,
                    shape: CircleBorder(),
                  ),
                );
              }),
        ),
      ],
    );
  }

  onBoardingWidget({iconPath = "", title = "", desc = ""}) {
    return 
    Container(
      alignment: Alignment.center,
      child: Column(children: [
        Expanded(child: SizedBox()),
        Container(
          width: 360.0,
          alignment: Alignment.center,
          height: 150.0,
          child: Image.asset(iconPath, fit: BoxFit.cover),
        ),
        Container(
          width: _w,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          margin: EdgeInsets.only(bottom: 40.0, top: 40.0),
          child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: true ? primaryColor :warmPrimaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
            width: 360,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.only(bottom: _h * 0.4),
            child: Text(desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: warmPrimaryColor.withOpacity(0.9), fontSize: 13.0))),
      ]),
    );
  
  }


}
