

import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';

class ParcelDeliveryTypeRoute extends StatefulWidget {
  const ParcelDeliveryTypeRoute({ Key? key }) : super(key: key);

  @override
  _ParcelDeliveryTypeRouteState createState() => _ParcelDeliveryTypeRouteState();
}

class _ParcelDeliveryTypeRouteState extends State<ParcelDeliveryTypeRoute> {
  
  late double _w;
  late double _h;

  Color redColor = true ? logoMainColor : Color(0xFFe22e23);
  Color fadedColor =  Color(0xFFaeaeae);

  @override
  Widget build(BuildContext context) {

    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

    statusBarColor:redColor// status bar color
  ));
    return BaseView<UserModel>(
      isBlankBaseRoute: true,
        child: 
           Container(
          width: _w,
          height: _h,
          padding: EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0),
          color:  logoBackgroundColor.withOpacity(0.7),
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                  Container(
                    width: _w,
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child:  SizedBox(
                            width: 55,
                            height: 55.0,
                            child: Image.asset( 'assets/images/test_parcel_1.jpg',fit: BoxFit.cover,)
                          ),
                        ),

                        SizedBox(width: 15.0,),

                        Text('Yussif Muniru',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold) )
                        
                      ],
                    ),
                  ),



                   SizedBox(width: _w * 0.87,height: 5.0,child: Divider(thickness: 0.65,color:logoMainColor.withOpacity(0.5),),),
                   SizedBox(height: 10.0,),

             SizedBox(
                    width: _w,
                    child: Row(
                      children: [
                       
                    
                       
                        PlayAnimation<double>(
                             tween: Tween(begin: 0.0, end: 1.0),
                              builder: (context, child,value) {
                                return Material(
                                  elevation:  1.0 * value,
                                  color: white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: 
                                  Container(
                                    width: _w * 0.6,
                                    height: _w * 0.23,
                                    padding: EdgeInsets.only(left: 20.0,top: 15.0,bottom: 20.0),
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      // border: Border(bottom: BorderSide(width: 0.75, color: Colors.grey)),
                                    ),
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Your phone number',style: TextStyle(color: Color(0xFFaeaeae),fontSize: 11.5,fontWeight: FontWeight.bold)),
                                        Expanded(child: SizedBox()),
                                        Text('+233 57 959 5950',style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold)),

                                      ],
                                    ),
                                      
                                  ),
                               
                                );
                              }
                            ),


                     

                        Expanded(child: SizedBox()),

                      PlayAnimation<double>(
                             tween: Tween(begin: 0.0, end: 1.0),
                              builder: (context, child,value) {
                                return Material(
                                  elevation:  1.0 * value,
                                  color: white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: 
                                  Container(
                                    width: _w * 0.25,
                                    height: _w * 0.23,
                                    padding: EdgeInsets.only(left: 20.0,top: 15.0,bottom: 20.0),
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      // border: Border(bottom: BorderSide(width: 0.75, color: Colors.grey)),
                                    ),
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Points',style: TextStyle(color: Color(0xFFaeaeae),fontSize: 11.5,fontWeight: FontWeight.bold)),
                                        Expanded(child: SizedBox()),
                                        Text('316',style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold)),

                                      ],
                                    ),
                                      
                                  ),
                               
                                );
                              }
                            )


                      ],
                    ),
                  ),


             SizedBox(height: 20.0,),
              SizedBox(
                width: _w,
                child: Row(
                  children: [
                    PlayAnimation<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, child,value) {
                      return Material(
                        elevation:  2 * value,
                        color: redColor,
                        borderRadius: BorderRadius.circular(15.0),
                        child: 
                        Container(
                          width: _w * 0.42,
                          height: _w * 0.42,
                          padding: EdgeInsets.only(left: 20.0,top: 25.0,bottom: 20.0),
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(width: 3.0, color: redColor)
                            // border: Border(bottom: BorderSide(width: 0.75, color: Colors.grey)),
                          ),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Balance',style: TextStyle(color: logoBackgroundColor ,fontSize: 11.5,fontWeight: FontWeight.bold)),
                              SizedBox(height: 12.0,),
                              Text('${Constants.CEDI_SYMBOL} 6.00',style: TextStyle(fontSize: 18.5,color: white,fontWeight: FontWeight.bold)),

                                Expanded(child: SizedBox()),
                Row(

                  children: [
                    SizedBox(width: 70.0,child: Text('Update at 15:37',style: TextStyle(color:logoBackgroundColor,fontSize: 11.5,fontWeight: FontWeight.bold ))),
                    Expanded(child: SizedBox()),
                    Container(
                      width: 40.0,
                      height: 40.0,
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Icon(Entypo.credit_card,color: redColor,size: 17.0,)),


                    

                  ],
                ),   


                            ],
                          ),
                            
                        ),
                      
                      );
                    }
                  ),

                    Expanded(child: SizedBox()),

             PlayAnimation<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, child,value) {
                      return Material(
                        elevation:  2.5 * value,
                        color: white,
                        borderRadius: BorderRadius.circular(15.0),
                        child: 
                        Container(
                          width: _w * 0.42,
                          height: _w * 0.42,
                          padding: EdgeInsets.only(left: 20.0,top: 25.0,bottom: 20.0),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(width: 1.0, color: white.withOpacity(0.7))
                          ),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(

                  children: [
                    SizedBox(width: 70.0,child: Text('Calls',style: TextStyle(color:fadedColor,fontSize: 11.5,fontWeight: FontWeight.bold ))),
                    Expanded(child: SizedBox()),
                     Icon(Feather.phone_call,color: redColor,size: 17.0,),
                    SizedBox(width: 10.0)

                    

                  ],
                ),   


               
                    Expanded(child: SizedBox()),

                  
                        RichText(text: TextSpan(
                          text: '168',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.5,color: black),
                          children: [
                            TextSpan(
                              text: ' Minutes',
                              style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color: fadedColor)
                            )
                          ]
                        ), ),
                        
                     

                  


                            ],
                          ),
                            
                        ),
                      
                      );
                    }
                  ),

                                         
                  ],
                ),
              ),
                        
              
              

                SizedBox(height: 20.0,),
                 SizedBox(
                width: _w,
                child: Row(
                  children: [
                   

                   PlayAnimation<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, child,value) {
                      return Material(
                        elevation:  2.5 * value,
                        color: white,
                        borderRadius: BorderRadius.circular(15.0),
                        child: 
                        Container(
                          width: _w * 0.42,
                          height: _w * 0.42,
                          padding: EdgeInsets.only(left: 20.0,top: 25.0,bottom: 20.0),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(width: 1.0, color: white.withOpacity(0.7))
                          ),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(

                  children: [
                    SizedBox(width: 70.0,child: Text('Internet',style: TextStyle(color:fadedColor,fontSize: 11.5,fontWeight: FontWeight.bold ))),
                    Expanded(child: SizedBox()),
                     Icon(Ionicons.wifi ,color: redColor,size: 17.0,),
                    SizedBox(width: 10.0)

                    

                  ],
                ),   


               
                    Expanded(child: SizedBox()),

                  
                        RichText(text: TextSpan(
                          text: '18',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.5,color: black),
                          children: [
                            TextSpan(
                              text: ' GB',
                              style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color: fadedColor)
                            )
                          ]
                        ), ),
                        
                     

                  


                            ],
                          ),
                            
                        ),
                      
                      );
                    }
                  ),



                    Expanded(child: SizedBox()),

             PlayAnimation<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, child,value) {
                      return Material(
                        elevation:  2.5 * value,
                        color: white,
                        borderRadius: BorderRadius.circular(15.0),
                        child: 
                        Container(
                          width: _w * 0.42,
                          height: _w * 0.42,
                          padding: EdgeInsets.only(left: 20.0,top: 25.0,bottom: 20.0),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(width: 1.0, color: white.withOpacity(0.7))
                          ),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(

                  children: [
                    SizedBox(width: 70.0,child: Text('Messages',style: TextStyle(color:fadedColor,fontSize: 11.5,fontWeight: FontWeight.bold ))),
                    Expanded(child: SizedBox()),
                     Icon(Entypo.message,color: redColor,size: 17.0,),
                    SizedBox(width: 10.0)

                    

                  ],
                ),   


               
                    Expanded(child: SizedBox()),

                  
                       Icon(Entypo.$500px,size: 30.0),
                        
                     

                  


                            ],
                          ),
                            
                        ),
                      
                      );
                    }
                  ),

                                         
                  ],
                ),
              ),
                        
              

              SizedBox(
                height: 10.0,
                
              ),

              Text('Personel Offers (2)',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5)),

              SizedBox(
                width: _w,
                height: _h * 0.26,
                child: ListView(
                  shrinkWrap: true,
                  children:[
                      Column(
                        children: [
                          Stack(
                              clipBehavior: Clip.none,
                            children: [
                              
                              PlayAnimation<double>(
                                     tween: Tween(begin: 0.0, end: 1.0),
                                      builder: (context, child,value) {
                                        return Material(
                                          elevation:  1.0 * value,
                                          color: white,
                                          borderRadius: BorderRadius.circular(15.0),
                                          child: 
                                          Container(
                                            width: _w * 0.95,
                                            height: _w * 0.26,
                                            padding: EdgeInsets.only(top: 15.0,bottom: 15.0,right: 10.0),
                                            alignment: Alignment.centerRight,
                                            decoration: BoxDecoration(
                                              color: white,
                                              borderRadius: BorderRadius.circular(15.0),
                                              // border: Border(bottom: BorderSide(width: 0.75, color: Colors.grey)),
                                            ),
                                            child:
                                               
                                                Container(
                                                  width: _w * 0.4,
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Discount up to',style: TextStyle(color: Color(0xFFaeaeae),fontSize: 11.5,fontWeight: FontWeight.bold)),
                                                      Expanded(child: SizedBox()),
                                                       Text('20%',style: TextStyle(color: black,fontSize: 16.5,fontWeight: FontWeight.bold)),
                                                       Expanded(child: SizedBox()),
                                                      Text('4 days remaining',style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.bold,color: errorColor)),

                                                    ],
                                                  ),
                                                ),
                                             
                                              
                                          ),
                                       
                                        );
                                      }
                                    ),
                     
                            Positioned(left: 0.8, bottom: -10.0,child: SizedBox(width: _w * 0.42,height: _w * 0.38,child: Image.asset('assets/images/parcel_size_3.png',fit: BoxFit.cover,))),
                            



                            ],
                          ),
                          SizedBox(height: 25.0),
                        ],
                      ),

                     Column(
                        children: [
                          Stack(
                              clipBehavior: Clip.none,
                            children: [
                              
                              PlayAnimation<double>(
                                     tween: Tween(begin: 0.0, end: 1.0),
                                      builder: (context, child,value) {
                                        return Material(
                                          elevation:  1.0 * value,
                                          color: white,
                                          borderRadius: BorderRadius.circular(15.0),
                                          child: 
                                          Container(
                                            width: _w * 0.95,
                                            height: _w * 0.26,
                                            padding: EdgeInsets.only(top: 15.0,bottom: 15.0,right: 10.0),
                                            alignment: Alignment.centerRight,
                                            decoration: BoxDecoration(
                                              color: white,
                                              borderRadius: BorderRadius.circular(15.0),
                                              // border: Border(bottom: BorderSide(width: 0.75, color: Colors.grey)),
                                            ),
                                            child:
                                               
                                                Container(
                                                  width: _w * 0.4,
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Discount up to',style: TextStyle(color: Color(0xFFaeaeae),fontSize: 11.5,fontWeight: FontWeight.bold)),
                                                      Expanded(child: SizedBox()),
                                                       Text('15 - 20%',style: TextStyle(color: black,fontSize: 16.5,fontWeight: FontWeight.bold)),
                                                       Expanded(child: SizedBox()),
                                                      Text('14 days remaining',style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.bold,color: logoMainColor)),

                                                    ],
                                                  ),
                                                ),
                                             
                                              
                                          ),
                                       
                                        );
                                      }
                                    ),
                     
                            Positioned(left: 0.8, bottom: -10.0,child: SizedBox(width: _w * 0.42,height: _w * 0.38,child: Image.asset('assets/images/parcel_size_2.png',fit: BoxFit.cover,))),
                            



                            ],
                          ),
                          SizedBox(height: 15.0),
                        ],
                      ),

                     



                  ]
                ),
              ),
              ],

            ),
          ),
        
    );
  }
}