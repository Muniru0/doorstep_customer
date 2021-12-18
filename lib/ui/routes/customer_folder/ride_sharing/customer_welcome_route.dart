
import 'dart:async';
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/helper_functions.dart/functions.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/directions.dart' as mapDirections;
import 'package:smooth_star_rating/smooth_star_rating.dart';



class CustomerWelcomeRoute extends StatefulWidget {
  const CustomerWelcomeRoute({ Key? key }) : super(key: key);

  @override
  _CustomerWelcomeRouteState createState() => _CustomerWelcomeRouteState();
}

class _CustomerWelcomeRouteState extends State<CustomerWelcomeRoute> {
  
  late double _w;
  late double _h;

  
   Color mainColor = true ? Color(0xFF000000) : logoMainColor;



  late String _mapStyle;
  Completer<GoogleMapController> _controller = Completer();


 GoogleMapsPlaces places =  GoogleMapsPlaces(apiKey: Constants.GOOGLE_WEB_SERVICES_MAPS_API_KEY);
   var locationsMarkers = <MarkerId,Marker>{};

 mapDirections.GoogleMapsDirections directions = mapDirections.GoogleMapsDirections(apiKey: Constants.GOOGLE_WEB_SERVICES_MAPS_API_KEY); 

  BitmapDescriptor? locationPinIcon;

  FocusNode focusNode = FocusNode();


  TextEditingController _phoneController = TextEditingController();

 late  bool isAcquiringLocation;

 CameraPosition? lastKnownCameraPosition;

 late double selectedLocationLat;

 late double selectedLocationLng;

 late bool _loadedPinIcon;

    Color fadedColor =  Color(0xFFc2c7cc);


 @override
 void initState() {
    
    isAcquiringLocation = false;
    _loadedPinIcon = false;
   selectedLocationLat = 0.0;
   selectedLocationLng = 0.0;
    rootBundle.loadString(Constants.CUSTOM_MAP_STYLE_FILE_PATH).then((string) {
    _mapStyle = string;
  });
  
   super.initState();
  
 }

 Future<void> _onMapCreated(GoogleMapController controller) async {

       await setCustomMapPin();
   
      LatLng latLng = LatLng(5.708696077300338,-0.2004465088248253);

    try{
              controller.setMapStyle(_mapStyle);
              _controller.complete(controller);
            setState(()=>isAcquiringLocation = true);

       Position     position =  await Geolocator.getCurrentPosition();
            latLng = LatLng(position.latitude,position.longitude);

        }on PlatformException catch(e){

     bool isLocationServicesEnabled =  await  Geolocator.isLocationServiceEnabled();
     if(e.message == 'The location service on the device is disabled.'){
            myPrint('use the string for the error identification');
     }
     if(!isLocationServicesEnabled){

          UtilityWidgets.getToast('Location services on the device have being disabled.',duration: '2',);
     }else{

        UtilityWidgets.getToast('Unexpected error, while fetching location data.',duration: '2');
     }

    }
  
   lastKnownCameraPosition = CameraPosition(
      bearing:30,
      target: LatLng(latLng.latitude, latLng.longitude),
     tilt: 45.0,
      zoom: 18.595899200439453);
     // chooseLocationWithLatLng(latLng.latitude, latLng.longitude);

    //setState(() { selectedLocationLat = position.latitude; selectedLocationLng = position.longitude;});

   // cameraPosition = position.latitude 
    controller.animateCamera(CameraUpdate.newCameraPosition(
      
      CameraPosition(
      bearing: 0.0 ,
      target: LatLng(latLng.latitude, latLng.longitude),
      tilt: 0.0,
      zoom: 13.595899200439453)
        )).then((value) => null).whenComplete(() => setState(()=>isAcquiringLocation = false)) ;

  if(locationsMarkers.isNotEmpty){
           locationsMarkers.clear();
      }

     selectedLocationLat = latLng.latitude;
     selectedLocationLng = latLng.longitude;


          var locationLat = 5.709760636414532;
          var locationLng = -0.2004465088248253;
          var  destinationLat =  5.708696077300338;
          var  destinationLng = -0.19875671714544296;
  
  mapDirections.DirectionsResponse destinationDirections = await  directions.directionsWithLocation(Location(lat: locationLat,lng:locationLng), Location(lat: 5.682697669786985,lng: -0.17163723707199097,),transitRoutingPreference: TransitRoutingPreferences.fewerTransfers);


    List<mapDirections.Route>  routes   = destinationDirections.routes;

  

      if(destinationDirections.status != 'OK'){

          UtilityWidgets.getToast('Error displaying delivery personels information.');
          
      }


    
  Location legStartLocation =    routes.first.legs.first.steps.first.startLocation;

  Location legEndLocation   =  routes.first.legs.first.steps.first.endLocation;

 var bearing = Geolocator.bearingBetween(legStartLocation.lat, legStartLocation.lng, legEndLocation.lat, legEndLocation.lng);




  
    //    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //   bearing: bearing,
    //   target: LatLng(position.latitude, position.longitude),
    //  tilt: 0.0,
    //   zoom: 13.595899200439453)));

        // locationsMarkers[MarkerId('marker')] = Marker(

        //   markerId: MarkerId('marker'),
        //   //zIndex: 30.0,
        //   anchor: Offset(0.5,0.5),
        //   position: LatLng(legStartLocation.lat,legStartLocation.lng),
        //  // rotation: bearing,
        //   infoWindow: InfoWindow(
        //     title: 'Yussif Muniru',
        //     snippet: 'rating: 4.6',
            
        //   ),
        //   icon: locationPinIcon!
        // );

     // chooseLocationWithLatLng(position.latitude,position.longitude);
       
    //   for (final office in googleOffices.offices) {
    //     final marker = Marker(
    //       markerId: MarkerId(DateTime.now().toString()),
    //       position: LatLng(office.lat, office.lng),
    //       infoWindow: InfoWindow(
    //         title: 'Title',
    //         snippet: 'Address',
    //       ),
    //     );
    //     _markers[office.name] = marker;
    //   }
    // });

    

   
  }




  setCustomMapPin() async {


     locationPinIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 1.0),
      false ? 'assets/images/gray_search.png' :Constants.DELIVERY_BIKE_ICON,);

      setState(() {
        _loadedPinIcon = true;
      });

   }



  
  @override
  Widget build(BuildContext context) {
   
   _w = MediaQuery.of(context).size.width;
   _h = MediaQuery.of(context).size.height;
   
    return BaseView<UserModel>(
        child: Container(
          width: _w,
          height: _h,
          padding: EdgeInsets.only(top: 20.0),
          child: Stack(
            children: [
              Opacity(opacity: 0.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Material(
                       elevation: 1.0,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(35),bottomLeft: Radius.circular(35),),
                        color: mainColor,
                       child: Stack(
                         alignment: Alignment.center,
                         children: [
                           Container(
                             width: _w,
                             height: _h * 0.6,
                          
                            
                             decoration: BoxDecoration(
                               color: mainColor,
                               borderRadius: BorderRadius.only(bottomRight: Radius.circular(35),bottomLeft: Radius.circular(35),)
                             ),
                             ),
              
                                SizedBox(
                                   width: _w,
                             height: _h * 0.6,
                                // width: 300,
                                // height: 300,
                                child: 
                                Transform.rotate(angle: 3.14 ,child: 
                                Image.asset('assets/images/delivery_bike_icon.png',fit: BoxFit.contain)),
                                ),
                         ],
                       ),
                     ),
              
              
                Container(
                  width: _w,
                  height: _h * 0.4,
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              
              
                Container(
                  width: _w,
                
                   margin: EdgeInsets.only(top: 35.0,bottom: 45.0),
                   child: RichText(text : TextSpan(text: 'Welcome to ',style: TextStyle(fontSize: 17.5,color: black),
                   children: [
                     TextSpan
                        (text: 'Doo',style: TextStyle(color: mainColor,fontSize: 17.5,fontWeight: FontWeight.bold)),
                         TextSpan
                        (text: 'R',style: TextStyle(color: logoMainColor,fontSize: 17.5,fontWeight: FontWeight.bold)),
                         TextSpan
                        (text: 'step',style: TextStyle(color: mainColor,fontSize: 17.5,fontWeight: FontWeight.bold)),
                     
                   ]
                   ),
                   
              
                ),
                ),
              
              
              
                Container(
                  width: _w,
                  padding: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    border: Border(bottom:BorderSide(width: 0.1, color: fadedHeadingsColor) ),
                  ),
                  child: Row(
                    children: [
                    Container(
                     // padding: EdgeInsets.all(7.5),
                      
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        // color: black.withOpacity(0.5)
                      ),
                      child: Container(
                        width: 30,
                        height: 30.0,
                        decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainColor
                      ),   
                      ),
                    
                    ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 9.0),
                        child: Icon(AntDesign.caretdown,color: fadedHeadingsColor,size: 12.5),
                      ),
                      Text('+233',style: TextStyle(color: mainColor.withOpacity(0.7),fontSize: 11.5,fontWeight: FontWeight.bold)),
              
                      Container(
                        margin: EdgeInsets.only(left: 15.0,bottom: 3.5),
                        width: _w * 0.5,
                        child:  TextField(
                                    keyboardType: TextInputType.phone  ,
                                    controller: _phoneController,
                                   
                                    style: TextStyle(
                                      color: warmPrimaryColor,
                                      fontWeight : FontWeight.bold,
                                    ),
                                    cursorColor: warmPrimaryColor,
                                    decoration: InputDecoration.collapsed(
                                      hintText: '221234567',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFd7e0ef),
                                        fontSize: 13,
                                      ),
                                    ),
                                    onChanged: (String phoneNumber){
              
                                    },
                                  ),
                               
                      ),
                    ],
                  ),
                ),
              
                Expanded(child: SizedBox()),
                Container(
                  child: Text('Or connect using a social media account',style: TextStyle(color: logoMainColor,fontWeight: FontWeight.w700,fontSize: 15.5)),
                ),
              
              
                    ],
                  )
                ),
              
                
              
                  ],
                ),
              ),
          

            Positioned(child: 
               Visibility(
              visible: false,
              child: Container(
              width: _w,
              height: _h ,
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
                  Container(
                    child: Icon(Feather.arrow_left,size: 20.0)
                  ),
            
            
                      Container(
              width: _w,
                      
               margin: EdgeInsets.only(top: 35.0,bottom: 20.0),
               child:Text
                    ('Enter your mobile number',style: TextStyle(color: mainColor,fontSize: 15.5,fontWeight: FontWeight.bold)),
                      ),
            
                     
            
                      Container(
              width: _w,
              padding: EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                border: Border(bottom:BorderSide(width: 0.1, color: fadedHeadingsColor) ),
              ),
              child: Row(
                children: [
                Container(
                 // padding: EdgeInsets.all(7.5),
                  
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    // color: black.withOpacity(0.5)
                  ),
                  child: Container(
                    width: 30,
                    height: 30.0,
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: mainColor
                  ),   
                  ),
                
                ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 9.0),
                    child: Icon(AntDesign.caretdown,color: fadedHeadingsColor,size: 12.5),
                  ),
                  Text('+233',style: TextStyle(color: mainColor.withOpacity(0.7),fontSize: 11.5,fontWeight: FontWeight.bold)),
            
                  Container(
                    margin: EdgeInsets.only(left: 15.0,bottom: 3.5),
                    width: _w * 0.5,
                    child:  TextField(
                                keyboardType: TextInputType.phone  ,
                                controller: _phoneController,
                               
                                style: TextStyle(
                                  color: warmPrimaryColor,
                                  fontWeight : FontWeight.bold,
                                ),
                                cursorColor: warmPrimaryColor,
                                decoration: InputDecoration.collapsed(
                                  hintText: '221234567',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFd7e0ef),
                                    fontSize: 13,
                                  ),
                                ),
                                onChanged: (String phoneNumber){
            
                                },
                              ),
                           
                  ),
                ],
              ),
                      ),
            
                      Expanded(child: SizedBox()),
                      Row(
              children: [
                Container(
                  width: _w * 0.7,
                  child: Text('By continuing you may receive SMS for verification. Message and data rates may apply ',style: TextStyle(color: mainColor,fontWeight: FontWeight.w500,fontSize: 12.5)),
                ),
                Expanded(child: SizedBox()),
                Container(
                  width: 50.0,
                  height: 50.0,
                  margin: EdgeInsets.only(right: 15.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: logoMainColor
                  )
                  ,child: Icon(Feather.arrow_right,color: white,size: 19.0,),)
              ],
                      ),
            
            
                ],
              )
                      ),
            ),
),
          

           Positioned(
             child:    
             Animarker(
              curve: Curves.ease,
              mapId: _controller.future.then<int>((value) => value.mapId), //Grab Google Map Id,
                zoom: 14.59,
                  markers:true ?
                    {RippleMarker(
                      ripple: false,
                     icon: _loadedPinIcon ? locationPinIcon : BitmapDescriptor.defaultMarker,
                     anchor: Offset(0.5,0.5),
                     position: LatLng( 5.710348128077925,-0.2006862312555313),
                      markerId: MarkerId('marker_id'), )}
                    : locationsMarkers.values.toSet(),
                child: GoogleMap(
                onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal ,
                  //markers: locationsMarkers.values.toSet(),
                  onTap: (LatLng latLng){
                    print(latLng.latitude);
                    print(latLng.longitude);
                  },
                
    onCameraMove: (cameraPosition){
          
              
                  },
        onCameraMoveStarted: (){},
        compassEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
            target: LatLng(5.6778757, -0.0174085),
            zoom:20.0,
        ),
              
                      ),
                  ),
                                
    ),
           
           Positioned(
             top: 25.0,
             left: 15.0
             ,child:  Material(
                  elevation: 25.0,
                  shape: CircleBorder(),
                  child: Container(
                  width: 50.0,
                  height: 50.0,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white
                  )
                  ,child: Icon(Feather.arrow_left,color: logoMainColor,size: 19.0,),)
                ),),
        
        
        // delivery bike
           Positioned(
             bottom: _h * 0.43,
             left: 10.0,
             child: 
             Visibility(
               visible: false,
               child: Stack(
                 children: [
                   Material(
                     elevation: 35.0,
                     color: true ? white : Color(0xfff3f6fc).withOpacity(0.5),
                     borderRadius: BorderRadius.circular(15.0),
                     child: Container(
                       width: _w * 0.95,
                     //  height: _h * 0.2 ,
                       padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                       decoration: BoxDecoration(
                     color: true ? white : Color(0xfff3f6fc).withOpacity(0.5),
                     borderRadius: BorderRadius.circular(15.0),
                       ),
                       child:Row(
                      
                         children:[
                Container(
                  width: 75,
                  height: 75.0,
                  padding: EdgeInsets.all(7.0),
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                    color: Color(0xffededee),
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: Image.asset('assets/images/delivery_bike.png',fit: BoxFit.cover),
                ),
                         
                SizedBox(
                  width: _w * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Row(
                        children: [
                          Text('Delivery Bike',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
                          SizedBox(width: 15.0),
                          Expanded(child: SizedBox()),
                            Text('${Constants.CEDI_SYMBOL} 18',style: TextStyle(fontWeight: FontWeight.bold, color: logoMainColor,fontSize: 14.0)),
             
             
                        ],
                      ),
                      SizedBox(height: 5.0),
                      SizedBox(width: _w * 0.5,child: Text('Select this if the parcel can be carried by a delivery bike',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0,color: fadedHeadingsColor))),
                    ]
                  ),
                ),
                         
                         ]
                       ),
                     ),
                   ),
                
                 ],
               ),
             ),
),
          
          
            // delivery car and van
            Positioned(
             bottom: _h * 0.135,
             left: 20.0,
             child: 
             Visibility(
               visible: false,
               child: Column(
                 children: [
                   Material(
                     elevation: 35.0,
                     color: Color(0xfff3f6fc).withOpacity(0.5),
                     borderRadius: BorderRadius.circular(15.0),
                     child: Container(
                       width: _w * 0.9,decoration: BoxDecoration(
                     color: Color(0xfff3f6fc).withOpacity(0.5),
                     borderRadius: BorderRadius.circular(15.0),
                       ),
                       child:Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                Container(
                  width: _w * 0.9,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(  
                    color: false ? white :  null,
                    borderRadius: BorderRadius.circular(15.0),),
                  child: Row(
                      
                      children:[
                        Container(
                          width: 75,
                          height: 75.0,
                          padding: EdgeInsets.all(7.0),
                          margin: EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            color: Color(0xffededee),
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Image.asset('assets/images/delivery_bike.png',fit: BoxFit.cover),
                        ),
                      
                        SizedBox(
                          width: _w * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Row(
                                children: [
                                  Text('Delivery Car',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
                                  SizedBox(width: 15.0),
                                  Expanded(child: SizedBox()),
                                    Text('${Constants.CEDI_SYMBOL} 18',style: TextStyle(fontWeight: FontWeight.bold, color: logoMainColor,fontSize: 13.0)),
             
             
                                ],
                              ),
                              SizedBox(height: 5.0),
                              SizedBox(width: _w * 0.5,child: Text('A small car that can carry about two big boxes.',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0,color: fadedHeadingsColor))),
                            ]
                          ),
                        ),
                      
                      ]
                    ),
                ),
               
             
             
                Container(
                  width: _w * 0.8,
                  margin: EdgeInsets.only(left: _w * .05),
                  child: Divider(
                    thickness: 0.2,
                    color: fadedHeadingsColor,
                  ),
                ),
                Container(
                  width: _w * 0.9,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(  
                  color:false ? white : null,
                  borderRadius: BorderRadius.circular(15.0),),
                  child: Row(
                      
                    children:[
                      Container(
                        width: 75,
                        height: 75.0,
                        padding: EdgeInsets.all(7.0),
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xffededee),
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Image.asset('assets/images/delivery_bike.png',fit: BoxFit.cover),
                      ),
                    
                      SizedBox(
                        width: _w * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                             Container(
                                padding: EdgeInsets.all(5.0),
                               // width:_w * 0.5 ,
                               decoration: BoxDecoration(
                                color: logoMainColor,
                               borderRadius: BorderRadius.circular(10.0)
                             ),child: Text('VIPex',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0,color: white))),
                            Row(
                              children: [
                                Text('Delivery Van',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
                                SizedBox(width: 15.0),
                                Expanded(child: SizedBox()),
                                  Text('${Constants.CEDI_SYMBOL} 28',style: TextStyle(fontWeight: FontWeight.bold, color: logoMainColor,fontSize: 14.0)),
             
             
                              ],
                            ),
                            SizedBox(height: 5.0),
                            SizedBox(width: _w * 0.5,child: Text('A delivery van that can carry about 10 large boxes',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0,color: fadedHeadingsColor))),
                          ]
                        ),
                      ),
                    
                    ]
                  ),
                ),
                   
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             ),
),




          // parcel details and order button
           Positioned(
             bottom:0.0,
           
             child: 
               Visibility(
                 visible: true,
                 child: Material(
                         elevation: 35.0,
                         shadowColor: Colors.black,
                         color:  white ,
                         borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0)),
                         child: Column(
                           children: [

                        Container(
                          width: _w,
                          padding: EdgeInsets.only(right: 15.0,left: 15.0,top: 10.0),
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: 45.0,height: 2.5,
                       decoration: BoxDecoration(
                                color: fadedColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(7.5)
                              ),),
                          ],
                        ),
                        

                Container(
                  width: _w,
                  padding: EdgeInsets.only(bottom: 25.0,top: 20.0),
                  margin: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.5,color: fadedColor.withOpacity(0.7))),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: SizedBox(
                          width: 55.0,
                          height: 55.0,
                          child: Image.asset( 'assets/images/test_parcel_5.jpg',fit: BoxFit.cover,),
                        ),
                      ),
                      SizedBox(width: 8.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Dispatch',style: TextStyle(color: fadedColor,fontSize: 10.5,fontWeight: FontWeight.w900)),
                          SizedBox(height: 2.5,),
                          Row(
                            children: [
                              Text('Wasiu Omar',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.5)),
                              SizedBox(width: 3.0),
                              Icon(Ionicons.checkmark_circle,color :logoMainColor,size: 15.0 ),
                            ],
                          ),
                          SizedBox(height: 3.0),
                            SmoothStarRating(
                                  rating:4.0 ,
                                  size: 11.0,
                                  allowHalfRating: true,
                                  color:goldColor,
                                  defaultIconData: FontAwesome.star,
                                  borderColor: fadedColor,
                                  
                                   ),
                        ],
                      ),

                      Expanded(child: SizedBox()),

                      Icon(MaterialIcons.favorite,color: fadedColor,size: 22.5),
                      SizedBox(width: 15.0),
                      Icon(Ionicons.call,color: logoMainColor,size: 22.5),

                    ],
                  ),
                ),


                Container(
                  width: _w,
                  padding: EdgeInsets.only(bottom: 20.0),
                  margin: EdgeInsets.only(bottom: 25.0),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.75,color: fadedColor))),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Delivery #',style: TextStyle(color: fadedColor,fontSize: 11.0, )),
                          SizedBox(height: 5.0),
                           Text('DSX3245',style: TextStyle(color: black.withOpacity(0.75),fontSize: 13.5,fontWeight: FontWeight.bold )),
                        ],
                      ),
                  
                    SizedBox(width: 20.0,),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Est. Delivery #',style: TextStyle(color: fadedColor,fontSize: 11.0,fontWeight: FontWeight.bold )),
                          SizedBox(height: 5.0),
                           Text('07:04am',style: TextStyle(color: black.withOpacity(0.75),fontSize: 13.5,fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(width: 20.0,),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Royal Bike',style: TextStyle(color: fadedColor,fontSize: 11.0,fontWeight: FontWeight.bold )),
                          SizedBox(height: 5.0),
                           Text('#5423-21',style: TextStyle(color: black.withOpacity(0.75),fontSize: 13.5,fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Container(child: Row(
                       children:[
                          Container(width: 7.0,height: 7.0,
                          margin: EdgeInsets.only(right: 7.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF64cc75),
                            shape: BoxShape.circle,
                          ),),
                          Text('On time',style: TextStyle(color: black.withOpacity(0.7),fontSize: 11.5,fontWeight: FontWeight.bold)),
                       ]
                      ),)

                    ],
                  ),
                ),

                      ]),
          ),

                             Container(
                             width: _w ,
                             height: _h * 0.13,
                             padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                             decoration: BoxDecoration(
                       color:  white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0)),
                             ),
                             child:
                             Row(
                        
                               children:[
                                 Container(
                  width: 75,
                  height: 75.0,
                  padding: EdgeInsets.all(7.0),
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                    color: Color(0xffededee),
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: Image.asset('assets/images/parcel_size_1.png',fit: BoxFit.cover),
                                 ),
                               
                                 Expanded(
                  // width: _w * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      
                    Row(
                      children: [
                       
                        RichText(text: TextSpan(
                                   text: 'Parcel Type:',
                                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0,color: black.withOpacity(0.5),),
               
                                   children: [
                                     TextSpan(
                                        text: 'Clothing',
                                        style: TextStyle(fontSize: 12.0,color: black
                                     ))
                                   ]
                                
                                 )),
               
                                  InkWell(
                              onTap: (){
                                myPrint('Go go parcel details route');
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 5.0),
                                child: Icon(EvilIcons.question,color: logoMainColor.withOpacity(0.8),size: 11.0),
                              ),
                        ),
                      ],
                    ),
               
               
                    RichText(text: TextSpan(
                             text: 'Parcel Size:',
                             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0,color: black.withOpacity(0.5)),
               
                             children: [
                               TextSpan(
                                  text: '1',
                                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0,color: black),
                               )
                             ]
                      
                       )),
               
                                       
                 
                  RichText(text: TextSpan(
                             text: 'Parcel Size info:',
                             style: TextStyle( fontSize: 11.0,color: black.withOpacity(0.5)),
               
                             children: [
                               TextSpan(
                                  text: 'fits into a shoe box',
                                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0,color: logoMainColor),
                               )
                             ]
                      
                       )),
                    ]
                  ),
                                 ),
               
               
               
                       Container(
                                 width: 75.0,
                                 height: 75.0,
                                 alignment: Alignment.center,
                                 decoration: BoxDecoration(
                  color: logoMainColor,
                  borderRadius: BorderRadius.circular(15.0),
                                 ),
                                 child:false ? InkWell(
                                   onTap: (){
                                     myPrint('Edit parcel Details');
                                   }
                                   ,child: Icon(Feather.edit_3,color: white, size: 18.0)) : Text("Cancel",style: TextStyle(fontSize: 18,color: white),)
                               ),
               
                               ]
                             ),
                      
                                
                       ),
                           ],
                         ),
                     ),
               ),
             
              
            
),
          
          
          Positioned(
            bottom: _h * 0.15,
            right: _w * 0.19 ,
            child: InkWell(
              onTap: (){
                print('Tapped');
              },
              child: Visibility(
                visible: false,
                child: Container(
                width:_w * 0.55,
                height: 55,
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: logoMainColor, borderRadius: BorderRadius.circular(12.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center
                  ,children: [
                  Container(
                    width: 20.0,
                    height: 20.0,
                    alignment:Alignment.center,
                    margin: EdgeInsets.only(right: 5.0),
                    decoration: BoxDecoration(
                      color: Color(0xffededee) ,
                      shape: BoxShape.circle
                    ),
                    child: Icon(Feather.x, size: 14.0),
                  ),
                          
                  Container(
                    child: Text('Cancel',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.5,color: white),
                  ),)
                  
                ],),
                        ),
              ),
            ))


          
            ],
          ),
        ),
    );
  }
}