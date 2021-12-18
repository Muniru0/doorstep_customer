
import 'package:doorstep_customer/models/parcels_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class ParcelDetailsRoute extends StatefulWidget {
  const ParcelDetailsRoute({ Key? key }) : super(key: key);

  @override
  _ParcelDetailsRouteState createState() => _ParcelDetailsRouteState();
}

class _ParcelDetailsRouteState extends State<ParcelDetailsRoute> {
 
 
  late double _w;
  late double _h;

    Color redColor = false ? logoMainColor : Color(0xFFe22e23);
  Color fadedColor =  Color(0xFFc2c7cc);

  late bool _useMomoPayment;

  late int _selectedPaymentMethod;

  @override
  void initState() {
    _useMomoPayment = false;
    _selectedPaymentMethod = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return BaseView<ParcelsModel>(
        child:Container(
          width: _w,
          height: _h,
          padding: EdgeInsets.only(top: 50.0),
          color: logoBackgroundColor,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
              width: _w,
              height: _h,
              padding: EdgeInsets.only(left: 20.0,right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Container(
                    width: _w,
                    margin: EdgeInsets.only(bottom: 20.0,),
                    
                    child: Row(
                      children: [

                          SizedBox(width: 5,child: Icon(AntDesign.arrowleft,color: redColor,size: 18.0)),
                        

                          Expanded(child: SizedBox()),
                        
                          Text('Package Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.5)),

                          Expanded(child: SizedBox()),
                        
                        SizedBox(child: Icon(Feather.x ,color: redColor,size: 18.0)),






                        
                        
                      ],
                    ),
                  ),


                  SizedBox(width: _w * 0.6,child: Text("Now, let's set the package route.",style: TextStyle(fontWeight: FontWeight.bold,fontSize:22.0))),



                SizedBox(height: 25.0),


                    SizedBox(
                    width: _w,
                    height: _h * 0.31,
                    child: Column(
                     
                       children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Column(
                            
                            children: [
                                SizedBox(height: 7.0,),
                                Icon(
                                  Ionicons.location,color: redColor,size: 15.0
                                ),
                                  timelineDots(),
                              
                            ],
                          ),

                          Container(
                           // width: _w * 0.7,
                            padding: EdgeInsets.only(bottom: 20.0),
                            margin: EdgeInsets.only(left: 20.0),
                            
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Yesterday - 09:43pm',style: TextStyle(color: fadedColor.withOpacity(0.7),fontSize: 10.5,fontWeight: FontWeight.bold)),
                                SizedBox(height: 3.0),
                                Text('Your Shipment was accepted',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5))
                              ],
                            ),
                          ),
                      
                          Expanded(child: SizedBox()),

                          Container(margin: EdgeInsets.only(top: 5.0),child: Icon( EvilIcons.chevron_right ,color: redColor, size: 25.0)),
                      //  Expanded(child: SizedBox()),
                      
                      
                        ],),
                    
                    
                     Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Column(
                            children: [
                                SizedBox(height: 7.0,),
                                Icon(
                                  Ionicons.location,color: redColor,size: 15.0
                                ),
                                
                               

                            ],
                          ),

                         
                           Container(
                            //width: _w * 0.7,
                            padding: EdgeInsets.only(bottom: 20.0),
                            margin: EdgeInsets.only(left: 20.0),
                          
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Today - 06:23pm',style: TextStyle(color: fadedColor.withOpacity(0.7),fontSize: 10.5,fontWeight: FontWeight.bold)),
                                SizedBox(height: 3.0),
                                Text('Your parcel was picked up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5)),

                                
                              ],
                            ),
                          ),


                       Expanded(child: SizedBox()),

                          Container(margin: EdgeInsets.only(top: 5.0),child: Icon( EvilIcons.chevron_right ,color: redColor, size: 25.0)),
                      
                        ],),

                    
                    
                    
                     Container(
                            width: _w * 0.8,
                          
                            margin: EdgeInsets.only(left: 45.0),
                          
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Who will receive this parcel',style: TextStyle(color: fadedColor.withOpacity(0.7),fontSize: 10.5,fontWeight: FontWeight.bold)),
                                    SizedBox(height: 3.0),
                                    Text('Alan Stanger \t\t\t +233 57 959 5950',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5))
                                  ],
                                ),
                         

                              Expanded(child: SizedBox()),

                          Container(margin: EdgeInsets.only(top: 5.0),child: Icon( EvilIcons.chevron_right ,color: redColor, size: 25.0)),
                              ],
                            ),
                          ),


                      ],
                    ),
                  ),

                          


                  ],
                ),
              ),

               Positioned(
                       top:_h * 0.26,
                       left: _w * 0.15,
                       child: Container(
                        width: _w * 0.7,
                        // margin: EdgeInsets.only(top: 0.0,bottom: 0.0,left:25.0),
                        child: Row(
                          children: [
                            Container( width: _w * 0.6,child: Divider(thickness: 0.5,color: fadedColor)),
                            SizedBox(width: 3.5,),
                            Transform.rotate(angle: 3.14 * 0.5,child: Icon(AntDesign.swap,color: fadedColor,size: 15.0)),
                          ],
                        ),
                                         ),
                     ),


            

            Positioned(
              bottom: -10.0,
              child:
               Material(
                 elevation: 35.0,
                 borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0)),
                 child: Container(
                   width: _w ,
                   height: _h * 0.5,
                   padding: EdgeInsets.only(left: 20.0,right: 10.0,top:100.0),
                   decoration: BoxDecoration(
                     color: redColor,
                     borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0)),
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      
                      Container(margin:EdgeInsets.only(top: 20.0,left: 20.0,bottom: 20.0), width: _w * 0.8,child: Divider(thickness: 0.0,color: white.withOpacity(0.5),)),

                       Container(
                     width: _w,
                     margin: EdgeInsets.only(bottom: 15.0,left:5.0),
                     padding: EdgeInsets.only(bottom: 10.0),
                     decoration: BoxDecoration(
                       border: Border(bottom: BorderSide(width: 0.7,color: white.withOpacity(0.3)))
                     ),
                     child: Row(
                       children:[
                          Text('Package Size and Type',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5,color: white)),
                          Expanded(child: SizedBox()),
                          Icon(EvilIcons.chevron_right,size: 30.0, color: white)
                      
                       ]
                     ),
                   ),



                     Container(
                     width: _w,
                     margin: EdgeInsets.only(bottom: 15.0,left:5.0),
                       padding: EdgeInsets.only(bottom: 10.0),
                     decoration: BoxDecoration(
                       border: Border(bottom: BorderSide(width: 0.7,color: white.withOpacity(0.3)))
                     ),
                     child: Row(
                       children:[
                          Text('Courier service',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5,color: white)),
                          Expanded(child: SizedBox()),


                         Text('any',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5,color: white)),
                         
                         Icon(EvilIcons.chevron_right,size: 30.0, color: white)
                      
                       ]
                     ),
                   ),

                  Expanded(child: SizedBox()),

                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: _w * 0.9,
                      alignment: Alignment.center,
                     
                      padding: EdgeInsets.symmetric(vertical: 13.0,),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                     child: Text('Confirm And Order',style: TextStyle(color: redColor,fontSize: 13.5,fontWeight: FontWeight.bold)),
                      ),
                  ),
                  SizedBox(height: 20.0,)
                   // Expanded(child: SizedBox()),
                    // InkWell(
                    //         onTap: (){
                    //           setState(() {
                    //             _useMomoPayment = !_useMomoPayment;
                    //           });
                    //         },
                    //         child: AnimatedContainer(
                    //           width: 55,
                    //           height: 30.0,
                    //           duration: Duration(milliseconds: 700),
                    //           curve: Curves.easeInOut,
                    //           alignment: _useMomoPayment ? Alignment.centerRight : Alignment.centerLeft,
                    //           padding: EdgeInsets.all(1.5),
                    //           decoration: BoxDecoration(
                    //             color:_useMomoPayment ? white : white.withOpacity(0.2),
                    //             borderRadius: BorderRadius.circular(15.0),
                               
                    //           ),
                    //           child: Container(
                    //             width: 30.0,
                    //             height: 30.0,
                    //             decoration: BoxDecoration(
                    //               color:redColor ,
                    //               shape: BoxShape.circle
                    //             ),
                    //           ) ,
                    //         ),
                    //       ),
                     
                     



                     ],
                   )
                 ),
                 ))
            
          ,  Positioned(
            bottom: _h * 0.335,
            right: 20.0
            ,child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                            width: 135,
                            height: 115,
                            margin: EdgeInsets.only(left: 55.0),
                            child: Image.asset('assets/images/parcel_size_1.png',fit: BoxFit.cover),
                          ),
                          Text('I am sending: ',
                                style: TextStyle(color: white.withOpacity(0.3),fontSize: 10.5)
                              ),
                          RichText(text: TextSpan(
                            text: 'Clothing: ',
                            style: TextStyle(color: white,fontSize: 12.5,fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: 'that fits in a mobile phone box',
                                style: TextStyle(color: white.withOpacity(0.3),fontSize: 11.5)
                              ),
                              
                            ]
                          ),),
                          SizedBox(height: 5.0,),
                           RichText(text: TextSpan(
                            text: 'Parcel Size: ',
                            style: TextStyle(color: white,fontSize: 12.5,fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: ' 1',
                                style: TextStyle(color: white.withOpacity(0.3),fontSize: 11.5)
                              ),
                              
                            ]
                          ),),
                         
              ],
            ),)
            


            ],
          ),
        ) ,
    );
  }


   Widget timelineDots(){
    return Column(
      children: List.generate(10, (index) =>  Container(
          width: 3.5,
          height: 3.5,
          margin: EdgeInsets.only(bottom: 3.0),
          decoration: BoxDecoration(
            color: redColor.withOpacity(0.1),
            shape: BoxShape.circle),
        ),),
    );
  }


}


class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({required DateTime currentTime,required LocaleType locale}) : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return '';
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return '';
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return '';
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(currentTime.year, currentTime.month, currentTime.day,
            this.currentLeftIndex(), this.currentMiddleIndex(), this.currentRightIndex())
        : DateTime(currentTime.year, currentTime.month, currentTime.day, this.currentLeftIndex(),
            this.currentMiddleIndex(), this.currentRightIndex());
  }
}


//  Container(
//                      width: _w,
//                      margin: EdgeInsets.only(left:5.0),
//                      child: Row(
//                        children:[
//                           Text('Payment Method',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5,color: white)),
                         
//                        ]
//                      ),
//                    ),

//                    InkWell(
//                    onTap: (){
//                      setState(() {
//                         _selectedPaymentMethod = 1;
//                      });
//                    },
//                    child: Container(
//                      width: _w,
//                      padding: EdgeInsets.only(bottom: 10.0),
//                      margin: EdgeInsets.only(top: 15.0,left: 20.0),
//                       decoration: BoxDecoration(border: Border(bottom: BorderSide(color: white.withOpacity(0.4),width: 0.7))),
//                      child: Row(
//                        children: [
//                          Text('Mobile Money',style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.bold, color: _selectedPaymentMethod == 1 ? white: white.withOpacity(0.4))),
//                           Expanded(child: SizedBox()),
//                          Container(padding: EdgeInsets.all(3.5),decoration: BoxDecoration(
//                            shape: BoxShape.circle,
//                            color: white,
//                            border: Border.all(width: 1.5,color: black.withOpacity(0.1)),
//                          ),child: AnimatedOpacity(duration:Duration(milliseconds: 400),opacity: _selectedPaymentMethod == 1 ? 1.0: 0.0,child: Container(width: 10.0,height: 10.0,decoration: BoxDecoration(shape: BoxShape.circle,color: redColor),))),
//                        ],
//                      )
//                    ),
//                  ),


//                     InkWell(
//                       onTap: (){
//                      setState(() {
//                         _selectedPaymentMethod = 2;
//                      });
                     
//                      },
//                       child: Container(
//                       width: _w,
//                       padding: EdgeInsets.only(bottom: 10.0),
//                       margin: EdgeInsets.only(top: 15.0,left: 20.0),
//                       decoration: BoxDecoration(border: Border(bottom: BorderSide(color: white.withOpacity(0.4),width: 0.7))),
//                       child: Row(
//                        children: [
//                          Text('Cash',style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.bold,color:_selectedPaymentMethod == 2 ? white:  white.withOpacity(0.4))),
//                           Expanded(child: SizedBox()),
//                          Container(padding: EdgeInsets.all(3.5),decoration: BoxDecoration(
//                            shape: BoxShape.circle,
//                            color: white,
//                            border: Border.all(width: 1.5,color: black.withOpacity(0.1)),
//                          ),child: AnimatedOpacity(duration:Duration(milliseconds: 400),opacity: _selectedPaymentMethod == 2 ? 1.0: 0.0,child: Container(width: 10.0,height: 10.0,decoration: BoxDecoration(shape: BoxShape.circle,color: redColor),))),
//                        ],
//                                        )
//                                      ),
//                     ),

