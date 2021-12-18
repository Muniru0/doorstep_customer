
import 'dart:ui';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:google_fonts/google_fonts.dart';



class ParcelsHomeRoute extends StatefulWidget {
  const ParcelsHomeRoute({ Key? key }) : super(key: key);

  @override
  _ParcelsHomeRouteState createState() => _ParcelsHomeRouteState();
}

class _ParcelsHomeRouteState extends State<ParcelsHomeRoute> {
  
  late double _w;
  late double _h;
    Color redColor = false ? logoMainColor : Color(0xFFe22e23);
  Color fadedColor =  Color(0xFFaeaeae);
  @override
  Widget build(BuildContext context) {
    _w  = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return BaseView<UserModel>(
      isBlankBaseRoute: true,
        child: Container(
          width: _w,
          height: _h,
          padding: EdgeInsets.only(top: 30.0,left:15.0,right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[

               Container(
                    width: _w,
                    margin: EdgeInsets.only(bottom: 40.0),
                    child: Row(
                      children: [

                         SizedBox(width: 5,child: Icon(Entypo.dots_two_vertical,color: redColor,size: 18.0)),
                          
                         Icon(Entypo.dot_single,color: redColor,size: 18.0),
                         Expanded(child: SizedBox()),
                       
                        ClipRRect(
                          borderRadius: BorderRadius.circular(55 /2),
                          child:  SizedBox(
                            width: 35,
                            height: 35.0,
                            child: Image.asset( 'assets/images/test_parcel_1.jpg',fit: BoxFit.cover,)
                          ),
                        ),

                       

                       
                        
                      ],
                    ),
                  ),



                  Text('Hi Yussif,',style: TextStyle(fontWeight: FontWeight.bold,fontSize:22.0)),
                   Text('have a good day!',style: TextStyle(fontWeight: FontWeight.bold,fontSize:22.0)),
                   Container(
                     width: _w * 0.6,
                     margin: EdgeInsets.only(top: 8.0,bottom: 55.0),
                     child: Text('You have three(3) deliveries planned for today.',style: TextStyle(color: fadedColor,fontSize: 12.5,fontWeight: FontWeight.bold))
                   ),

                   SizedBox(
                     width: _w,
                     child: Stack(
                       clipBehavior: Clip.none,
                       alignment: Alignment.center,
                       children: [
                         Material(
                           elevation: 35.0,
                           color: redColor,
                              borderRadius: BorderRadius.circular(15.0),
                           child: Container(
                             width: _w * 0.75,
                             height: _h * 0.21,
                            decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                           ),
                         ),
                         Positioned(
                           top: -10.0,
                           child: Material(
                             elevation: 35.0,
                           color: redColor,
                              borderRadius: BorderRadius.circular(15.0),
                             child: Container(
                               width: _w * 0.85,
                               height: _h * 0.21,
                               padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
                              decoration: BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.circular(15.0)
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: _w * 0.85,
                                    child: Row(
                                      children: [
                                        Text('Delivery Status',style: TextStyle(color: white.withOpacity(0.7), fontSize: 11.5,fontWeight: FontWeight.bold),),
                                        Expanded(child: SizedBox()),
                                         Text('#DSX3245',style: TextStyle(color: white.withOpacity(0.7), fontSize: 11.5,fontWeight: FontWeight.bold),),

                                      ],
                                    ),
                                  ),
                               
                                  SizedBox(height: 15.0,),
                                  SizedBox(
                                      width: _w * 0.85,
                                      child: Row(
                                        children: [
                                          Icon(MaterialCommunityIcons.truck_fast_outline,color: white.withOpacity(0.5),size: 25.0),
                                          SizedBox(width: 10.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Your package is being delivered',style: TextStyle(color: white.withOpacity(0.9),fontSize: 12.5),),
                                              SizedBox(height: 3.0),
                                              Text('Last Update: 23min ago ',style: TextStyle(color: white.withOpacity(0.7),fontSize: 11.0),)
                                            ],
                                          ),
                                        ],
                                      ),
                                  ),
                                
                                  Container(
                                      width: _w * 0.85,
                                      height: 5.0,
                                      margin: EdgeInsets.symmetric(vertical: 20.0),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF4c0513),
                                        borderRadius: BorderRadius.circular(3.5),

                                      ),
                                      child: Container(
                                         width: _w * 0.35,
                                      height: 5.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFf5c832),
                                        borderRadius: BorderRadius.circular(3.5),

                                      ),
                                      ),
                                  ),


                                SizedBox(
                                    width: _w * 0.85,
                                    child: Row(
                                      children: [
                                        Text('Track Your Package',style: TextStyle(color: white.withOpacity(0.75), fontSize: 12.5,fontWeight: FontWeight.bold),),
                                        Expanded(child: SizedBox()),
                                        Icon(MaterialCommunityIcons.chevron_triple_right,color: white.withOpacity(0.75), size: 18.0),
                                      ],
                                    ),
                                  ),

                                
                                ],
                              )
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),


                  SizedBox(height: 25.0,),

                    SizedBox(width: _w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 5.0,
                            height: 5.0,
                            margin: EdgeInsets.only(right:2.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: redColor
                            ),
                          ),
                          Container(
                            width: 5.0,
                            height: 5.0,
                             margin: EdgeInsets.only(right:2.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: fadedColor
                            ),
                          ),
                          Container(
                            width: 5.0,
                            height: 5.0,
                            margin: EdgeInsets.only(right:2.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: fadedColor
                            ),
                          ),
                          Container(
                            width: 5.0,
                            height: 5.0,
                            margin: EdgeInsets.only(right:2.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: fadedColor
                            ),
                          ),
                         
                          
                        ],
                      ),
                    ),
                                      
                Container(
                  width: _w,
                  margin: EdgeInsets.only(top: 25.0,bottom: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 6.5),decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.7, color: fadedColor))
                      ),child: Text('Your Activity',style: TextStyle(color: black.withOpacity(0.55),fontSize: 12.5,fontWeight: FontWeight.bold))),
                     
                      RichText(text: TextSpan(
                        text: 'Rating ',
                        style: TextStyle(color: black.withOpacity(0.55),fontSize: 12.5,fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: '\t4.8',
                            style: GoogleFonts.lato(
                             fontWeight: FontWeight.w900,
                             fontSize: 13.5,
                             color: redColor
                            )
                          )
                        ]
                      ),  )
                   
                    
                    ],
                  ),
                ),
                SizedBox(
                  width: _w,
                  height: _h * 0.33,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [

                        ratingActivityWidget(),
                        parcelDeliveryRequest(),
                        messageActivityWidget(),
                        parcelDeliveryRequest(),
                        ratingActivityWidget(),



                    ],
                  ),
                ),

            ]
          ),
        ),
    );
  }

  Widget ratingActivityWidget(){
    return Column(
      children: [
        Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular( 45 / 2 ),
                        child: Container(
                          width: 45.0,
                          height: 45.0,
                          child: Image.asset('assets/images/test_parcel_2.jpg',fit: BoxFit.cover)

                        ),
                        
                      ),
                      Positioned(right: 0.0,bottom: 0.0,child: Icon(FontAwesome.star,color: redColor,size: 15.0))
                    ],
                  ),
                    SizedBox(width: 15.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text('Yesterday',style: TextStyle(color:fadedColor,fontSize: 11.5,fontWeight: FontWeight.w900 )),
                        SizedBox(
                          width: _w * 0.55,
                          child: RichText(textAlign: TextAlign.left,text: TextSpan(
                text: 'You have received new rating from ',
                style: TextStyle(color: black.withOpacity(0.55),fontSize: 12.5,fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: '\tTom Smith',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w900,
                      fontSize: 12.5,
                      color: black.withOpacity(0.85)
                    )
                  )
                ]
              ),  ),
                        )
            
                    ]
                  ),

                Expanded(child: SizedBox()),
                    Icon(EvilIcons.chevron_right,color: redColor,size: 25.0),
                ],
              ),
     
      SizedBox(height: 13.0),
     
      ],
    );

  }


  Widget parcelDeliveryRequest(){
    return Column(
      children: [
        Row(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular( 45 / 2 ),
                          child: Container(
                            width: 45.0,
                            height: 45.0,
                            child: Image.asset('assets/images/test_parcel_3.jpg',fit: BoxFit.cover)

                          ),
                          
                        ),
                        Positioned(right: 0.0,bottom: 0.0,child: Icon(Ionicons.checkmark_circle,color: redColor,size: 15.0))
                      ],
                    ),
                      SizedBox(width: 15.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text('April 26',style: TextStyle(color:fadedColor,fontSize: 11.5,fontWeight: FontWeight.w900 )),
                          SizedBox(
                            width: _w * 0.55,
                            child: RichText(textAlign: TextAlign.left,text: TextSpan(
                  text: 'Mell Smith',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w900,
                    fontSize: 12.5,
                    color: black.withOpacity(0.85)
                      ),
                  children: [
                    TextSpan(
                      text: '\t accepted your shipment request',
                      style: TextStyle(color: black.withOpacity(0.55),fontSize: 12.5,fontWeight: FontWeight.bold),
                    
                    )
                  ]
                ),  ),
                          )
              
                      ]
                    ),

                  Expanded(child: SizedBox()),
                      Icon(EvilIcons.chevron_right,color: redColor,size: 25.0),
                  ],
                ),
     
        SizedBox(height: 13.0),

      ],
    );

  }



   Widget messageActivityWidget(){
    return Column(
      children: [
        Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular( 45 / 2 ),
                      child: Container(
                        width: 45.0,
                        height: 45.0,
                        child: Image.asset('assets/images/test_parcel_1.jpg',fit: BoxFit.cover)

                      ),
                      
                    ),
                    Positioned(right: 0.0,bottom: 0.0,child: Icon(FontAwesome5.comment,color: redColor,size: 15.0))
                  ],
                ),
                  SizedBox(width: 15.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text('April 3',style: TextStyle(color:fadedColor,fontSize: 11.5,fontWeight: FontWeight.w900 )),
                      SizedBox(
                        width: _w * 0.55,
                        child: RichText(textAlign: TextAlign.left,text: TextSpan(
              text: 'You have received new message from ',
              style: TextStyle(color: black.withOpacity(0.55),fontSize: 12.5,fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: '\tTom Smith',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w900,
                    fontSize: 12.5,
                    color: black.withOpacity(0.85)
                  )
                )
              ]
            ),  ),
                      )
          
                  ]
                ),

              Expanded(child: SizedBox()),
                  Icon(EvilIcons.chevron_right,color: redColor,size: 25.0),
              ],
            ),
    

       SizedBox(height: 13.0),
    
      ],
    );

  }


}