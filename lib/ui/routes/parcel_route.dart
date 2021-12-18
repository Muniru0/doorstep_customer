
import 'dart:math';
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/models/parcels_model.dart';
import 'package:doorstep_customer/services/data_models/parcel_data_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';


class ParcelsRoute extends StatefulWidget {
  @override
  _ParcelsRouteState createState() => _ParcelsRouteState();
}

class _ParcelsRouteState extends State<ParcelsRoute> {
 
  bool _showBlurredOverlay = false;
  bool isLoading = false;

 late OverlayEntry _overlayEntry;


  @override
  initState()
  {
    super.initState();
    showResults();
  }

  showResults()async{
    await Future.delayed(Duration(seconds: 2));
     setState((){
       isLoading  = false;
     });
  }
  @override
  Widget build(BuildContext context) {
    return 
      BaseView<ParcelsModel>(
        screenTitle: "Parcels",
        isBackIconVisible: true,
        showBlurredOverlay: _showBlurredOverlay,
        isParcelRoute: true,
        child: Container(
          padding: EdgeInsets.only(top: 20.0),
         // height: 550.0,
          child:
          DefaultTabController(
           length: 2,
            child:  Column(
               children :<Widget>[
                 PreferredSize(
                   preferredSize: Size.fromHeight(50.0),
                   child: Container(
                    
                     child: TabBar(
                           labelColor: warmPrimaryColor,
                          
                           indicatorWeight: .01,
                           unselectedLabelColor: warmPrimaryColor.withOpacity(0.4),
                           indicatorColor: Color(0xFFFFFFFF),
                            tabs: [
                         Tab(child: Text("Pending",style: TextStyle(fontWeight: FontWeight.w900)
                         )),
                         Tab(child: Text("Picked-Up", style: TextStyle(fontWeight: FontWeight.w900))),
                 
                       ]),

                   ),
                 ),
(isLoading ? Container(width: 30.0, height: 30.0,margin:EdgeInsets.only(top: 30.0),child: loadingIndicator(width: 30.0,height: 30.0,valueColor: buttonBorderColor)) :  Container(
            // padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Container(
                   padding: EdgeInsets.symmetric(horizontal: 9.0),
                  margin: EdgeInsets.only(bottom: 2.0),
                  width: 360.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                        opacity: 0.0,
                                              child: Container(
                          width: 60,
                         // height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            //color: Color(0xFFf1f2f8),
                          //  color: white,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Text("📍",style:TextStyle(fontSize: 18)),
                        ),
                      ),
                 
                  Opacity(
                    opacity: 0.0,
                                      child: Container(
                      child: Text("Track My Parcels",style: TextStyle(fontWeight: FontWeight.bold,fontSize: headingsSize, color: warmPrimaryColor)),
                    ),
                  ),

        InkWell(
          onTap: (){
            print("tap detected");
         _overlayEntry = UtilityWidgets.filterOverlay(context, _overlayEntry,choiceObj: [
OverlayChoice(choice: "Date ascending",isSelected: true,choiceAction: (){
                     
                      _overlayEntry.remove();
                      
                      }),
                      OverlayChoice(choice: "Date descending",choiceAction: (){
                     
                      _overlayEntry.remove();
                      
                      }),

                       OverlayChoice(choice: "On Route",choiceAction: (){
                     
                      _overlayEntry.remove();
                      
                      }),

         ]);

         Overlay.of(context)!.insert(_overlayEntry);
          },
                  child: Container(
                          width: 60,
                       //   height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                           // color: Color(0xFFf1f2f8),
                          // color: white,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Icon(Feather.filter,size: 15, color: Color(0xFF3b3775)),
                        ),
        ),
                 

         
                    ]
                  ),
                ),

                    Container(
                      width: 360.0,
                      height: 720 * 0.8,
                      child: TabBarView(
                   children: <Widget>[
                   getParcelsWidget(),
                   getParcelsWidget(),
                   ],
                 ),
                    ),
              
             ],
            ),
          )
        ),
               
               
               ]
             ),

         ),
      
        ),
      );
    
  }



 Widget getParcelsWidget(){
   return 
  //  (isLoading ? Container(width: 30.0, height: 30.0,margin:EdgeInsets.only(top: 30.0),child: loadingIndicator(width: 30.0,height: 30.0,valueColor: buttonBorderColor)) :  Container(
  //           // padding: EdgeInsets.symmetric(horizontal: 20.0),
  //           child: Column(
  //             children: [
  //               Container(
  //                  padding: EdgeInsets.symmetric(horizontal: 20.0),
  //                 margin: EdgeInsets.only(bottom: 2.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Container(
  //                       width: 60,
  //                       height: 60,
  //                       alignment: Alignment.center,
  //                       decoration: BoxDecoration(
  //                         //color: Color(0xFFf1f2f8),
  //                       //  color: white,
  //                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //                       ),
  //                       child: Text("📍",style:TextStyle(fontSize: 18)),
  //                     ),
                 
  //                 Container(
  //                   child: Text("Track My Parcels",style: TextStyle(fontWeight: FontWeight.bold,fontSize: headingsSize, color: warmPrimaryColor)),
  //                 ),

  //       Container(
  //                       width: 60,
  //                       height: 60,
  //                       alignment: Alignment.center,
  //                       decoration: BoxDecoration(
  //                        // color: Color(0xFFf1f2f8),
  //                       // color: white,
  //                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //                       ),
  //                       child: Icon(MaterialCommunityIcons.sort, color: Color(0xFF3b3775)),
  //                     ),
                 

         
  //                   ]
  //                 ),
  //               ),
        
           Container(
             width: 360.0,
             height: 600.0,
             child: ListView.builder(
               itemCount: 10,
               shrinkWrap: true,
                itemBuilder: (context, index){
             return  parcelWidget(Parcel());
               }
             
             ),
           )
         ;
 }

  parcelWidget(Parcel parcel){
var senders = ["Kwame Ibrahim", "Osman kareem", "Abdulai Mubarik", "Hafiz Elias","Muniru Yussif","Alhassan Yazeed", "Asmat Wulon"];

var circleColors = [Color(0xFFf5723f),Color(0xFF210070),Color(0xFFFFE042),Color(0xFFE71989),Color(0xFFFFA781),Color(0xFF5E001F),Color(0xFF00E1D9)];
 var circleColor = circleColors[Random().nextInt(6)];
 var iconPath    = Constants.PARCEL_ICONS[Random().nextInt(6)];
return  
 InkWell(
   onTap: (){
     Navigator.pushNamed(context, Constants.PARCEL_DETAILS_ROUTE);
   },
    child: Container(
                 
                 child: Column(
                 
                   children: [
                     
                     Container(
                       width: 360,
                       height: 100,
                       margin:EdgeInsets.only(bottom:7.0),
                       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
                       decoration: BoxDecoration(
                           //color: Color(0xFFf7f7fa),
                           color: white,
                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
                       ),
                     
                       child: Container(
                         height: 55,
                         width: 360.0,
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               width: 55.0,
                               height: 100.0,
                               alignment: Alignment.center,
                               margin: EdgeInsets.only(right: 10.0),
                               decoration: BoxDecoration(
                                  color: circleColor,
                                 shape: BoxShape.circle,
                               ),
                              
                               child: Container(height: 30.0,width: 30.0,child: Image.asset(iconPath))),
                             
                             Container(
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                     child: Text(senders[Random().nextInt(6)], style: TextStyle(color: warmPrimaryColor,fontSize: 15, fontWeight: FontWeight.bold))
                                   ),
                                   Row(
                                     children: [
                                       Container(
                                         padding: EdgeInsets.symmetric(vertical: 2,horizontal: 3 ),
                                        //  decoration: BoxDecoration(
                                        //    color: Color(0xFFf7f7fa),
                                        //    borderRadius: BorderRadius.all(Radius.circular(10)),
                                        //  ),
                                         child: Text("status:", style: TextStyle(fontSize: 12))
                                       ),
                                       
                                       Container(
                                         margin: EdgeInsets.only(right: 30.0),
                                         child: Text("OnRoute",style: TextStyle(fontSize: 13.0, color: Color(0xFF8987ab) ))
                                       ),
                                    
                                       
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       Container(
                                         padding: EdgeInsets.symmetric(vertical: 2,horizontal: 3 ),
                                         decoration: BoxDecoration(
                                           color: Color(0xFFf7f7fa),
                                           borderRadius: BorderRadius.all(Radius.circular(10)),
                                         ),
                                         child: Text("from:", style: TextStyle(fontSize: 12))
                                       ),
                                       
                                       Container(
                                         margin: EdgeInsets.only(right: 30.0),
                                         child: Text("Kumasi - Accra",style: TextStyle(fontSize: 13.0, color: Color(0xFF8987ab) ))
                                       ),
                                    
                                       
                                     ],
                                   ),
                                   
                                    ]
                                  ),
                                 

                                 ]
                               ),
                             ),
                             Expanded(child: SizedBox()),
                             Container(
                                margin: EdgeInsets.only(right: 20),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Container(
                                     margin: EdgeInsets.only(bottom: 0.0),
                                     child: Text("₵ 45", style: TextStyle(color:Color(0xFF8987ab) , fontSize: 13.0)),
                                   ),

                                   Container(
                                     padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5.0),
                                    //  decoration: BoxDecoration(
                                    //    color: Color(0xFFf7f7fa),
                                    //    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                    //  ),
                                     child: Text("Paid", style: TextStyle(color:primaryColor))
                                   ),
                                 ]
                               ),
                             ),
                           ]
                         ),
                       ),
                     ),
                   ]
                 ),
               ),
 );
           
}
}

