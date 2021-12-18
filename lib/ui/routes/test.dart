

import 'dart:ui';

import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:google_maps_webservice/geocoding.dart";
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapsTestDotDart extends StatefulWidget {
  @override
  _MapsTestDotDartState createState() => _MapsTestDotDartState();
}

class _MapsTestDotDartState extends State<MapsTestDotDart> {
 late double _w;
 late double _h;


final geocoding = new GoogleMapsGeocoding(apiKey: "<API_KEY>");
// final geocoding = new GoogleMapsGeocoding(apiKey: "<API_KEY>", httpClient: new BrowserClient());
// final geocoding = new GoogleMapsGeocoding(baseUrl: "http://myProxy.com");

 var opacity = 0.35;
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    
    return 
       Container(
        width: _w,
        height: _h * 0.91,
        color:black ,
      
       padding: EdgeInsets.only(top: 150,),
        child: 
         
              true ? 
                
                      Stack(
                        children: [
                          Column(
                            children: [
                 Material(
        elevation: 15.0,
        borderRadius: BorderRadius.circular(45.0),
               child:
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: _w * 0.8,
                  child: Row(
                  children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(75 / 2),
              child: Container(
              padding: EdgeInsets.all(3.5),
                  width:45 ,
                  height: 45,
                  child: Image.asset('assets/images/parcel_icon.png',fit: BoxFit.cover),
                  color:Color(0xFFe9e9ec) ),
            ),
              
            SizedBox(width: 13.5),    
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                               
                    Text('Cloth, size 4',style: TextStyle(fontSize:13.5,color: black.withOpacity(0.95),fontWeight: FontWeight.bold)),
                    //),
SizedBox(height: 5.5,),
        Row(children: [
          Container(margin: EdgeInsets.only(right: 2.5),child: Icon(AntDesign.staro,color: logoMainColor,size: 14.0)),
          Text('4.7 , ',style: TextStyle(color: logoMainColor,fontSize: 12.5,fontWeight: FontWeight.bold)),
          Text('Yussif Muniru',style: TextStyle(color:  Color(0xFFa4a4a4),fontSize: 13.5,fontWeight: FontWeight.bold ))
        ],),



                    SizedBox(height: 5.5,),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 3.5),
                          child: Icon(Ionicons.ios_timer,color:logoMainColor, size: 12.0),
                        ),
                        Text('15mins, ',style: TextStyle(color:  Color(0xFFa4a4a4),fontSize: 12.0)),
                        Text('since: 11:40pm',style: TextStyle(color: Color(0xFFa4a4a4),fontSize: 12.0,)),
                      ],
                    )
                              ],
                            ),
                                    
                                    
                                    ],
                                  ),
                                ),
                              
                            
                                            ),
                      
                    ],
                  ),
                
                
                  Positioned(
            top: 65.0,
            left: 45.0,
          child: Transform.rotate(
            angle:3.14  * 0.23,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                  color: false ?  black :    Color(0xFFf7f7f9).withOpacity(0.93),
              ),
              
              height: 20,
              width: 20,
              
            ),
          ),
        ),



                
                ],
              )
            
                
                  // InkWell(
                  //   onTap: (){
                  //     UtilityWidgets.broadRequestProcessingDialog(context,title: 'this is the title string we would like to show');
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.only(top: 200.0),
                  //     child: Text('Test Dialog')
                  //   ),
                  // ),
    
          
  
             :   
              Container(
                  width: _w,
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  color: Color(0xFFf7f7f9).withOpacity(0.93),
                  child:
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
           
                      Material(
                        elevation: 15.0,
                        borderRadius: BorderRadius.circular(14.0),
                         color: Color(0xFFf7f7f9).withOpacity(0.93),
                        child: Container(
                          width: 180,
                          height: 67,
                          decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(14.0),
                            color: Color(0xFFf7f7f9).withOpacity(0.93),
                          ),
                          
                          padding: EdgeInsets.all(14.0),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //   margin: EdgeInsets.only(bottom: 9.0),
                              //   //  //   color: Color(0xFFf7f7f9).withOpacity(0.93),
                              //   child:
                                 Text('Neon Cafe',style: TextStyle(fontSize:13.5,color: black.withOpacity(0.75),fontWeight: FontWeight.bold)),
                                 //),
                                 SizedBox(height: 9.0),
                              Text('23/A Park Avenue Road',style: TextStyle(color: Color(0xFFa4a4a4),fontSize: 12.0,fontWeight: FontWeight.bold))
                            ],
                          ) ,
                        ),
                      ),
                    
                      // InkWell(
                      //   onTap: (){
                      //     UtilityWidgets.broadRequestProcessingDialog(context,title: 'this is the title string we would like to show');
                      //   },
                      //   child: Container(
                      //     margin: EdgeInsets.only(top: 200.0),
                      //     child: Text('Test Dialog')
                      //   ),
                      // ),
           
                    
                    ],
                  ),
                ),
           
               
              // ],
              //        ),
          
          
          // ) ,
        
      )
    ;
  }

  void searchByAddr()async{
    GeocodingResponse response = await geocoding.searchByAddress("1600 Amphitheatre Parkway, Mountain View, CA");


  }
}


class TestFonts extends StatefulWidget {
  @override
  _TestFontsState createState() => _TestFontsState();
}

class _TestFontsState extends State<TestFonts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: Row(
              children: [
                Text("Our fonts ",style:TextStyle(fontSize:20)),
                Text('Our fonts',style: textStyle(fontSize: 20.0)),
              ],
            ),
      ),
    );
  }


  TextStyle textStyle ({fontSize = 15.0,fontWeight: FontWeight.normal,fontStyle = FontStyle.normal, color: Colors.black}){

      return GoogleFonts.lato(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontStyle: fontStyle,
       
      );
  }
}



