

import 'dart:async';

import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/model_registry.dart';
import 'package:doorstep_customer/models/parcels_model.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/helper_functions.dart/functions.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart' as mapDirections;
import 'package:google_maps_webservice/places.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:flutter/services.dart' show PlatformException, rootBundle;

class ParcelTrackingRoute extends StatefulWidget {
  const ParcelTrackingRoute({ Key? key }) : super(key: key);

  @override
  _ParcelTrackingRouteState createState() => _ParcelTrackingRouteState();
}

class _ParcelTrackingRouteState extends State<ParcelTrackingRoute> with WidgetsBindingObserver{
 
 late double _w;
 late double _h;

   Color redColor = false ? logoMainColor : Color(0xFFe22e23);
  Color fadedColor =  Color(0xFFc2c7cc);



  late String _mapStyle;
  Completer<GoogleMapController> _controller = Completer();


 GoogleMapsPlaces places =  GoogleMapsPlaces(apiKey: Constants.GOOGLE_WEB_SERVICES_MAPS_API_KEY);

 mapDirections.GoogleMapsDirections directions = mapDirections.GoogleMapsDirections(apiKey: Constants.GOOGLE_WEB_SERVICES_MAPS_API_KEY); 

  FocusNode focusNode = FocusNode();


  TextEditingController searchLocationController = TextEditingController();
  late bool showLocationsSuggestions;

  String previousValue = '';
  late bool isLoadingMapStyle;
  late bool isAcquiringLocation;
  var locationsMarkers = <MarkerId,Marker>{};
  late double selectedLocationLat;
  late double selectedLocationLng;
  late String selectedLocationPlaceID;

 late bool isSearchBarVisible;

 late String selectedLocationAddr;

 late bool isSearchingLocationByText;

  FocusNode searchLocationFocusNode = FocusNode();

 late double moveMyImage;

 CameraPosition? lastKnownCameraPosition;

 late double lastFetchedLocationLat;

 late double lastFetchedLocationLng;
 late StreamSubscription<Position> currentPositionStream;


  final deliveryPersonelPillKey = GlobalKey();

  late double mapBearing;
 List<LatLng> kLocations = [
   LatLng(5.71053128123312,-0.200749933719635),
   LatLng(5.710427861425905,-0.2007509395480156),
   LatLng(5.7100999204299026,-0.20063761621713638),
   LatLng(5.709838368168349,-0.2004558965563774),
  LatLng(5.709508425157901,-0.20030803978443146),
  LatLng(5.70960717455202,-0.2002326026558876),
  LatLng(5.709010674574394,-0.2001253142952919),
  LatLng(5.708685401673999,-0.19999857991933823),
  LatLng(5.7082460327554765,-0.19989833235740662),
 ]; 
 late Stream stream;

late double containerHeight; 

 BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

 late bool showDeliveryPersonelsSideBarList;

  late bool openDrawer;

 late Image doorstepLogo;

 BitmapDescriptor? pinLocationIcon;

 List<Widget> locationsWidget = [];


@override
void initState(){
 
    WidgetsBinding.instance!.addObserver(this);
  lastFetchedLocationLat = 0.0;
  lastFetchedLocationLng = 0.0;
  selectedLocationLat = 0.0;
  selectedLocationLng = 0.0;
  mapBearing = 0.0;
  containerHeight = 0.0;
  showDeliveryPersonelsSideBarList = false;
  isLoadingMapStyle = false;
   isSearchBarVisible = false;
   isSearchingLocationByText = false;
   openDrawer = false;
   selectedLocationAddr = Constants.LOCATION_LOADING_DOTS;
   selectedLocationPlaceID = '';
   showLocationsSuggestions = false;
   isAcquiringLocation = false;
   rootBundle.loadString(Constants.CUSTOM_MAP_STYLE_FILE_PATH).then((string) {
    _mapStyle = string;
  });
  doorstepLogo = Image.asset(Constants.DOORSTEP_LOGO_PATH,fit: BoxFit.cover,);

   

setCustomMapPin();

 super.initState();

}


 void setCustomMapPin() async {


     pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      Constants.DELIVERY_BIKE_ICON);

   }





 Future<void> _onMapCreated(GoogleMapController controller) async {
   
   
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
      zoom: 18.595899200439453)

    
      
      
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
        //   icon: pinLocationIcon!
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



  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return BaseView<ParcelsModel>(
      
        child: Container(
          width: _w,
          height: _h,
          padding: EdgeInsets.only(top: 20.0),
          child: Stack(
            children: [

               Animarker(
                                curve: Curves.ease,
                                mapId: _controller.future.then<int>((value) => value.mapId), //Grab Google Map Id,
                                  zoom: 14.59,
                                    markers: locationsMarkers.values.toSet(),
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
                                
    
                
                      
                    Container(
                    width: _w,
                    margin: EdgeInsets.only(bottom: 40.0,top: 20.0),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [

                         SizedBox(width: 5,child: Icon(AntDesign.arrowleft,color: redColor,size: 18.0)),
                        

                          Expanded(child: SizedBox()),
                        
                          Text('Tracking',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.5)),

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


            Positioned(
              bottom: -10.0,
              child: Material(
                elevation: 25.0,
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  width: _w,
                  height: _h * 0.55,
                  padding: EdgeInsets.only(top: 7.0,left: 20.0,right: 20.0),
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
                      borderRadius: BorderRadius.circular(55 / 2),
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
                            Text('Peter Wrigley',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.5)),
                            SizedBox(width: 3.0),
                            Icon(Ionicons.checkmark_circle,color :redColor,size: 15.0 ),
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
                    Icon(Ionicons.call,color: redColor,size: 22.5),

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


            Text('Tracking History',style: TextStyle(color: fadedColor.withOpacity(0.5),fontSize: 12.5,fontWeight: FontWeight.bold)),

            SizedBox(
              width: _w,
              height: _h * 0.24,
              child: ListView(
                shrinkWrap: true,
                
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Column(
                      children: [
                          SizedBox(height: 7.0,),
                          Icon(
                            MaterialIcons.check_circle_outline,color: redColor,size: 15.0
                          ),
                          timelineDots(),
                        

                      ],
                    ),

                    Container(
                      width: _w * 0.7,
                      padding: EdgeInsets.only(bottom: 20.0),
                      margin: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.7, color: fadedColor.withOpacity(0.7)))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Yesterday - 09:43pm',style: TextStyle(color: fadedColor.withOpacity(0.7),fontSize: 10.5,fontWeight: FontWeight.bold)),
                          SizedBox(height: 3.0),
                          Text('Your Shipment was accepted',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5))
                        ],
                      ),
                    ),
                
                    

                  
                
                
                
                  ],),
              

               Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Column(
                      children: [
                          SizedBox(height: 7.0,),
                          Icon(
                            MaterialIcons.check_circle_outline,color: redColor,size: 15.0
                          ),
                          timelineDots(),
                         

                      ],
                    ),

                   
                     Container(
                      width: _w * 0.7,
                      padding: EdgeInsets.only(bottom: 20.0),
                      margin: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.7, color: fadedColor.withOpacity(0.7)))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Today - 06:23pm',style: TextStyle(color: fadedColor.withOpacity(0.7),fontSize: 11.5,fontWeight: FontWeight.bold)),
                          SizedBox(height: 3.0),
                          Text('Your parcel was picked up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5))
                        ],
                      ),
                    ),



                
                  ],),

                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Column(
                      children: [
                          SizedBox(height: 7.0,),
                          Icon(
                            MaterialIcons.check_circle_outline,color: redColor,size: 15.0
                          ),
                          timelineDots(),
                          

                      ],
                    ),

                   

                     Container(
                      width: _w * 0.7,
                      padding: EdgeInsets.only(bottom: 20.0),
                      margin: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.7, color: fadedColor.withOpacity(0.7)))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Today - 06:23pm',style: TextStyle(color: fadedColor.withOpacity(0.7),fontSize: 11.5,fontWeight: FontWeight.bold)),
                          SizedBox(height: 3.0),
                          Text("Your parcel is on it's way",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5))
                        ],
                      ),
                    )
                
                
                
                
                  ],)
              
              
              
                ],
              ),
            ),



                    ],
                  ))
              ),
            ),
            ],
          )
        ),
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