
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:simple_animations/simple_animations.dart';

class ChooseDeliveryTypeRoute extends StatefulWidget {
  const ChooseDeliveryTypeRoute({ Key? key }) : super(key: key);

  @override
  _ChooseDeliveryTypeRouteState createState() => _ChooseDeliveryTypeRouteState();
}

class _ChooseDeliveryTypeRouteState extends State<ChooseDeliveryTypeRoute> {
  late double _h;
  late double _w;

    Color redColor = true ? logoMainColor : Color(0xFFe22e23);
  Color fadedColor =  Color(0xFFaeaeae);

  @override
  void initState() {
      
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<UserModel>(
        child:    Container(
          width: _w,
          height: _h,
          padding: EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0),
          color:  logoBackgroundColor.withOpacity(0.7),
            child: 
                Column(
                   
                  children: [

                      Container(
                        width: _w,
                        margin: EdgeInsets.only(bottom: 20.0),
                        alignment: Alignment.center,
                        child: 
                            Text('Choose Delivery Type',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold) )
                         
                      ),



                       SizedBox(width: _w * 0.87,height: 5.0,child: Divider(thickness: 0.65,color:logoMainColor.withOpacity(0.5),),),
                       SizedBox(height: 10.0,),

                
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
                              padding: EdgeInsets.only(left: 10.0,top: 10.0,bottom:10.0),
                              decoration: BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(width: 3.0, color: redColor)
                                // border: Border(bottom: BorderSide(width: 0.75, color: Colors.grey)),
                              ),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Inter-City',style: TextStyle(color: logoBackgroundColor ,fontSize: 11.5,fontWeight: FontWeight.bold)),
                                   Expanded(child: SizedBox()),
                                   Text('Inter-City',style: TextStyle(color: white ,fontSize: 18.5,fontWeight: FontWeight.bold)),
                                   Expanded(child: SizedBox()),
                                 
                    Row(

                      children: [
                        SizedBox(width: _w * 0.33,child: Text('e.g from Accra - Wa ( up-to 24hrs delivery time)',style: TextStyle(color:logoBackgroundColor,fontSize: 11.5,fontWeight: FontWeight.bold ))),
                       

                        

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
                  padding: EdgeInsets.only(left:10.0,top: 10.0,bottom: 10.0),
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
            SizedBox(width: 70.0,child: Text('In-City',style: TextStyle(color:fadedColor,fontSize: 11.5,fontWeight: FontWeight.bold ))),
            Expanded(child: SizedBox()),
              Icon(MaterialIcons.delivery_dining ,color: redColor,size: 17.0,),
            SizedBox(width: 10.0)

            

          ],
        ),   
          Expanded(child: SizedBox()),
         Text('In-City',style: TextStyle(color: logoMainColor ,fontSize: 18.5,fontWeight: FontWeight.bold)),

           Expanded(child: SizedBox()),
        
            Expanded(child: SizedBox()),

          
             Text('e.g from Spintex - Amasaman',
                      style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.bold,color: fadedColor)
                    )
                
              

          


                    ],
                  ),
                    
                ),
              
              );
            }
          ),

                                  
          ],
        ),
      ),
                
      
      

       

    
      
        ],

      ),
            
             ),
        
    );
  }
}