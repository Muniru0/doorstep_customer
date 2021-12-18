

import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/models/parcels_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/material.dart';


class SuccessfulParcelRoute extends StatefulWidget {
  @override
  _SuccessfulParcelRouteState createState() => _SuccessfulParcelRouteState();
}

class _SuccessfulParcelRouteState extends State<SuccessfulParcelRoute> {
  late double _w;
  late double _h;
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<ParcelsModel>(
      screenTitle: "Parcel Sent Successfully",
      isBackIconVisible: false,
      showSettingsIcon: false,
      child: Container(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Container(
              margin:EdgeInsets.only(bottom: 25.0),
             width: 50,
             height: 50.0,

              child: Image.asset(Constants.YELLOW_PARCEL_ICON)
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15.0),
              child: Text("Parcel Successfully Sent", style: TextStyle(color: warmPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold)
            ),),
            Container(width: 280.0,margin: EdgeInsets.only(bottom: 20),child:
             RichText(
               textAlign: TextAlign.center,
               text: TextSpan(
                 text:"The parcel has being recorded as being sent.You can manage parcels that you have sent by going to the Home screen",
                 style: TextStyle(color: warmPrimaryColor, fontSize: 12.0),

               ),
             ),
            ),

  
     UtilityWidgets.detailsParametersWidget({"Senders Name:":"Yussif Muniru","Senders Number:": "0241792877", "Receivers Name: ":"Muniru Yussif", "Parcel Fare": "₵ 45"},width: _w),

        Container(
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child:  UtilityWidgets.detailsParametersWidget({"Parcel Officer": "Irbrahim Regan"},width: _w),
        ),

   Container(margin: EdgeInsets.only(top: 30.0),child: UtilityWidgets.customConfirmationButton(
     context, (){
       Navigator.pushNamedAndRemoveUntil(context, Constants.SENDING_OFFICER_HOME_ROUTE, ModalRoute.withName(Constants.SENDING_OFFICER_HOME_ROUTE));
     },confirmationText: "HOME SCREEN",isLong: true
   )),
          ],
        )
      ),
    );
  }


parcelParameter(title, desc){
  return     
  Row(
                    children: [
                      Expanded(
                         child: Container(
                          margin: EdgeInsets.only(bottom: 15.0),
                          
                         child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(title, style:TextStyle(color: Color(0xFF8e9eb5),fontSize: subHeadingsSize, fontWeight: FontWeight.bold )),
                              ),
                              Container(
                                
                                child: Text(desc, style:TextStyle(color:warmPrimaryColor ,fontSize: subHeadingsSize, fontWeight: FontWeight.w900 )),
                              ),

                            ],
                          ),
                        ),
                      ),
                 
                    ],
                  );
               
}


}