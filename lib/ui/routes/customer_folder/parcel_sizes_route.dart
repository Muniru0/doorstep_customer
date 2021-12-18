
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/models/parcels_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:simple_animations/simple_animations.dart';

class ParcelSizesRoute extends StatefulWidget {
  const ParcelSizesRoute({ Key? key }) : super(key: key);

  @override
  _ParcelSizesRouteState createState() => _ParcelSizesRouteState();
}

class _ParcelSizesRouteState extends State<ParcelSizesRoute> {
 
 late double _w;
 late double _h;

     Color redColor = false ? logoMainColor : Color(0xFFe22e23);
  Color fadedColor =  Color(0xFFc2c7cc);

  CarouselController _carouselController = CarouselController();

 late  bool _showPackageTypeSelections;

 @override
  void initState() {
   _showPackageTypeSelections = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return BaseView<ParcelsModel>(
        child: Container(
          width: _w,
          height: _h,
          padding: EdgeInsets.only(top: 40.0),
          child: Stack(
            children: [
              Container(
                 padding: EdgeInsets.only(left: 20.0,right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                          width: _w,
                          margin: EdgeInsets.only(bottom: 35.0,),
                          
                          child: Row(
                            children: [

                                SizedBox(width: 5,child: Icon(AntDesign.arrowleft,color: redColor,size: 18.0)),
                              

                                Expanded(child: SizedBox()),
                              
                                Text('Package Size',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.5)),

                                Expanded(child: SizedBox()),
                              
                              SizedBox(child: Icon(Feather.check ,color: redColor,size: 18.0)),






                              
                              
                            ],
                          ),
                        ),


                        SizedBox(width: _w * 0.6,child: Text("Now, let's set the package route.",style: TextStyle(fontWeight: FontWeight.bold,fontSize:22.0))),

                        SizedBox(height: 25.0,),

                        
                      SizedBox(
                        width: _w,
                        child: Row(
                          children: [
                            Text('Select your package size',style: TextStyle(color: fadedColor, fontSize: 11.5, fontWeight: FontWeight.bold)),

                              Expanded(child: SizedBox()),
                            roundedScrollDots(color: redColor),
                            roundedScrollDots(),
                            roundedScrollDots(),
                            roundedScrollDots(),
                            roundedScrollDots(),
                            

                            
                          ],
                        ),
                      ),

                      SizedBox(height: 15.0,),

        CarouselSlider(
                carouselController:_carouselController ,
        options: CarouselOptions(
                height: 400.0,
                enlargeCenterPage: true,
                viewportFraction: 0.6
                ),
        items: [1,2,3,4,5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return   parcelSizeWidget();
                  },
                );
        }).toList(),
      ),
                  

   
                  ],
                ),
              ),
          

         
    Positioned(
      bottom: 0.0,
      child: Stack(
        children: [

         
          Material(
            elevation: 35.0,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight:Radius.circular(25.0) ),
            color: redColor,
            child: AnimatedContainer(
                      duration:Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                      width: _w,
                      height:_showPackageTypeSelections ? _h * 0.5 : _h * 0.11,
                      padding: EdgeInsets.only(top: 15.0,right: 15.0,left: 15.0),
                      decoration: BoxDecoration(
                         color: redColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight:Radius.circular(25.0) ),),
                      child: !_showPackageTypeSelections ? PlayAnimation
                      <double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 700),
                        builder: (context,child,value) {
                            return  Opacity(
                              opacity: value,
                              child: InkWell(onTap: (){
                                setState(() {
                                  _showPackageTypeSelections = true;
                                });
                              },child: Container(width: _w,alignment: Alignment.center,child: Text('Tap to select package type',style: TextStyle(color: white,fontSize: 19.0,fontWeight: FontWeight.bold)))));
                        } ) : 
                        
                         PlayAnimation<double>(
                           tween: Tween(begin: 0.0,end: 1.0),
                           curve: Curves.easeInOut,
                           duration: Duration(milliseconds: 700),
                           
                           builder: (context, snapshot,value) {
                             return Opacity(
                               opacity: value,
                               
                               child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Container(
                                  width: _w,
                                  margin: EdgeInsets.symmetric(horizontal: 15.0,),
                                  child: Row(
                                    children: [
                                      Text('I am sending:',style: TextStyle(color:white.withOpacity(0.5), fontSize: 12.5, fontWeight: FontWeight.bold)),
                                      Expanded(child: SizedBox()),
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            _showPackageTypeSelections = false;
                                          });
                                        }
                                        ,child: Icon(Feather.x,color: white.withOpacity(0.5),size: 17.0)),
                                    ],
                                  )),
                                SizedBox(height: 10.0,),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 700),
                                  curve: Curves.easeInOut,
                                  width: _w,
                                  height:true ?_h * 0.43 : _h * 0.06,
                                  child: ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    children: [
                                      
                                      Wrap(
                                        runSpacing: 10.0,
                                        spacing: 10.0,
                                        runAlignment: WrapAlignment.start,
                                        children: [
                                          parcelTypeWidget('Envelope',isSelected: true),
                                          parcelTypeWidget('Clothing'),
                                          parcelTypeWidget('Metallic Artefact'),
                                          parcelTypeWidget('Glass Artefact'),
                                          parcelTypeWidget('Mobile Phone'),
                                          parcelTypeWidget('Laptop'),
                                          parcelTypeWidget('Television'),
                                          parcelTypeWidget('Speakers'),
                                          parcelTypeWidget('Other electronic gadgets'),
                                          parcelTypeWidget('Plastic Artefact'),
                                         
                                         
                                        ],
                                      ),
                                                      
                                      SizedBox(height: 50.0,),
                                    ],
                                  ),
                                ),
                                                
                                                
                                                   ],
                                                 ),
                             );
                           }
                         ),
                    ),
          ),
        ],
      ),
    )
           
          
            ],
          ),
        ),
    );
  }


  Widget parcelTypeWidget (title, {bool isSelected = false}){
    return  Container(
                 // width: _w * 0.15,
                  height: _w * 0.1,
                //  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 8.5,right: 25.0,left: 25.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: isSelected ?redColor : white)
                    ,borderRadius: BorderRadius.circular(16.5),color:isSelected ? white : Color(0xFFbf022b)),
                  child: Text(title,style: TextStyle(color:isSelected ? redColor: white, fontSize: 12.5,fontWeight: FontWeight.bold)),
                );
              
              
  } 



  Widget parcelSizeWidget({imagePath = 'assets/images/parcel_size_1.png'}){
    return  
          Stack(
            clipBehavior: Clip.none,
            children: [
    
               Positioned(
                    bottom: _h * 0.1,
                    
                    child: Container(
                      width: _w * 0.42,
                      height: _h * 0.15,
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: black.withOpacity(0.3) ),
                        borderRadius: BorderRadius.circular(13.0)
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Min. Parcel Price',style: TextStyle(color: fadedColor,fontSize: 10.0,fontWeight: FontWeight.bold)),
                  
                            Text('${Constants.CEDI_SYMBOL} 13.99',style: TextStyle(color:  black.withOpacity(0.9),fontSize: 24.0,fontWeight: FontWeight.w400)),
                  
                          ],
                      ),
                    ),
                  ),
    
                 
              Material(
                elevation: 35.0 ,
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: _w * 0.425,
                  height: _h * 0.32,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15.0),
                     color: redColor 
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Small',style: TextStyle(color: white,fontSize: 13.0,fontWeight: FontWeight.bold)),
                      Text('Fits in a shoe box',style: TextStyle(color: white.withOpacity(0.35),fontSize: 11.0,fontWeight: FontWeight.bold)),
    
    
                       Expanded(child: SizedBox()),
                      Container(
                        width: 135,
                        height: 135,
                        child: Image.asset(imagePath,fit: BoxFit.cover),
                      ),
    
    
                      Expanded(flex: 2,child: SizedBox()),
    
                       Container(width: _w * 0.425,alignment: Alignment.centerRight,child: Text('Max. Weight/Length: ',style: TextStyle(color: white.withOpacity(0.3),fontSize: 11.0,fontWeight: FontWeight.bold))),
                      Container(width: _w * 0.425,alignment: Alignment.centerRight,child: Text('15kg | 33cm',style: TextStyle(color: white,fontSize: 14.0,fontWeight: FontWeight.bold))),
                     
    
    
                    ],
                  ),
                ),
              ),
          
              Positioned(
                bottom: _h * 0.17,
                left: 65.0,
                child: Icon(Ionicons.checkmark_circle,color: redColor,size: 22.0))
          
            ],
          );
  
  }


  Widget roundedScrollDots({color}){
    return Container(
        width: 5.0,
        height: 5.0,
        margin: EdgeInsets.only(right: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:color ?? fadedColor,
        ));
  }
}