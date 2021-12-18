
import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math' ;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/model_registry.dart';
import 'package:doorstep_customer/services/data_models/parcel_data_model.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/helper_functions.dart/functions.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import "package:google_maps_webservice/places.dart";
import 'package:google_maps_webservice/directions.dart' as mapDirections;




class LocationUtilsCode extends StatefulWidget {
  @override
  _LocationUtilsCodeState createState() => _LocationUtilsCodeState();
}

class _LocationUtilsCodeState extends State<LocationUtilsCode> {
 
  
  late double _w;
  late double _h;
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


void newLocationUpdate(LatLng previousLatLng,LatLng latLng) {


     var marker = Marker(
        markerId: MarkerId('marker'),
          //zIndex: 30.0,
          anchor: Offset(0.5,0.5),
         // position: LatLng(5.7082460327554765,-0.19989833235740662),
         position:latLng ,
          rotation: Geolocator.bearingBetween(previousLatLng.latitude, previousLatLng.longitude, latLng.latitude, latLng.longitude),
          infoWindow: InfoWindow(
            title: 'Yussif Muniru',
            snippet: 'rating: 4.6',
            
          ),
          icon: pinLocationIcon!
        );
     setState(() => locationsMarkers[MarkerId('marker')] = marker);
  }

@override
void initState(){
  super.initState();

  lastFetchedLocationLat = 0.0;
  lastFetchedLocationLng = 0.0;
  selectedLocationLat = 0.0;
  selectedLocationLng = 0.0;
  mapBearing = 0.0;
  isLoadingMapStyle = false;
   isSearchBarVisible = false;
   isSearchingLocationByText = false;
   selectedLocationAddr = Constants.LOCATION_LOADING_DOTS;
   selectedLocationPlaceID = '';
   showLocationsSuggestions = false;
   isAcquiringLocation = false;
   rootBundle.loadString(Constants.CUSTOM_MAP_STYLE_FILE_PATH).then((string) {
    _mapStyle = string;
  });


   Future.delayed(Duration(seconds: 5),(){
         
            Timer.periodic(Duration(seconds: 1), (timer) { 
              myPrint('hitting');
                myPrint(kLocations.length,heading: 'Lenght of locations list');
                myPrint(timer.tick,heading: 'Ticks');

                 if(timer.tick == kLocations.length){
                timer.cancel();
                myPrint('Cancelled');
              }
                   newLocationUpdate(kLocations[timer.tick],kLocations[timer.tick] );
                 
           
             

            });

         
    // locationsMarkers.remove(MarkerId('marker')); 
    //    locationsMarkers[MarkerId('marker')] = Marker(

    //       markerId: MarkerId('marker'),
    //       //zIndex: 30.0,
    //       anchor: Offset(0.5,0.5),
    //       position: LatLng(5.7082460327554765,-0.19989833235740662),
    //      // rotation: bearing,
    //       infoWindow: InfoWindow(
    //         title: 'Yussif Muniru',
    //         snippet: 'rating: 4.6',
            
    //       ),
    //       icon: pinLocationIcon!
    //     )
       
    //    ;
    //        setState(() {
      
    //              });
     });
     
   
    
  // stream = Stream.periodic(Duration(seconds: 2), (count) => kLocations[count]).take(kLocations.length);
  
  // stream.forEach((value) => newLocationUpdate(value));

  //  BitmapDescriptor.fromAssetImage(
  //     ImageConfiguration(devicePixelRatio: 2.5),
  //     'assets/images/cropped_delivery_bike_icon.png').then((value) => setState(() => pinLocationIcon = value ));

setCustomMapPin();
//       currentPositionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation,intervalDuration: Duration(milliseconds:500),timeLimit: Duration(seconds: 8)).listen(
//     (Position position) {
//      if(position != null){
      

//   chooseLocationWithLatLng(position.latitude, position.longitude);

//  _controller.future.then((GoogleMapController controller){

//    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//       bearing: 23.047945022583008,
//       target: LatLng(position.latitude, position.longitude),
//      tilt: 0.0,
//       zoom: 16.595899200439453)));
  
 
//  } ).onError((error, stackTrace) => UtilityWidgets.getToast('Location taking too long.'));


//      }
//     });

  
 



}

 @override 
   dispose(){
      currentPositionStream.cancel(); 
     super.dispose();
   }



Future<bool> goToCurrentLocation()async{
   setState(()=>isAcquiringLocation = true);
           
               
    GoogleMapController controller = await _controller.future;
   Position position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  
    setState(() { selectedLocationLat = position.latitude; selectedLocationLng = position.longitude;});
     chooseLocationWithLatLng(position.latitude,position.longitude);
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 23.047945022583008,
      target: LatLng(position.latitude, position.longitude),
     tilt: 0.0,
      zoom: 16.595899200439453))).then((value) => null).whenComplete(() => setState(()=>isAcquiringLocation = false)) ;

 setState(() {
      if(locationsMarkers.isNotEmpty){
           locationsMarkers.clear();
      }


    
     
        locationsMarkers[MarkerId('marker')] = Marker(
          markerId: MarkerId('marker'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: 'Title',
            snippet: 'Address',
            anchor: Offset(0.0,0.0) ,
          ),
         zIndex: 10.0,
          icon:pinLocationIcon! ,
        );
      
      
    });

   
      
   return true;
}



 void animateCameraToLocation(double lat, double lng)async{
      GoogleMapController controller = await _controller.future;
     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 23.047945022583008,
      target: LatLng(lat, lng),
     tilt: 0.0,
      zoom: 16.595899200439453))).whenComplete(() => showLocationsSuggestions = false);
       setState(() {
      if(locationsMarkers.isNotEmpty){
           locationsMarkers.clear();
      }
       });

    
     
        locationsMarkers[MarkerId('marker')] = Marker(
          markerId: MarkerId('marker'),
          zIndex: 30.0,
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: 'Title',
            snippet: 'Address',
            
          ),
          icon: pinLocationIcon!
        );
        chooseLocationWithLatLng(lat, lng);
 }


 Future<void> _onMapCreated(GoogleMapController controller) async {
   
   
   // final googleOffices = await locations.getGoogleOffices();
    //GoogleMapController controller = await _controller.future;

    try{
     await controller.setMapStyle(_mapStyle);
      _controller.complete(controller);
     setState(()=>isAcquiringLocation = true);

   Position position =  await Geolocator.getCurrentPosition();
    print(position.latitude);
    print(position.longitude);
  
   lastKnownCameraPosition = CameraPosition(
      bearing:30,
      target: LatLng(position.latitude, position.longitude),
     tilt: 45.0,
      zoom: 17.595899200439453);
      chooseLocationWithLatLng(position.latitude, position.longitude);

    //setState(() { selectedLocationLat = position.latitude; selectedLocationLng = position.longitude;});
    controller.animateCamera(CameraUpdate.newCameraPosition(
      
      CameraPosition(
      bearing: true ? mapBearing : 23.047945022583008,
      target: LatLng(position.latitude, position.longitude),
     tilt: 45.0,
      zoom: 17.595899200439453)

    
      
      
      )).then((value) => null).whenComplete(() => setState(()=>isAcquiringLocation = false)) ;


print('called from the _onMapCreated Widget');
    
    
      if(locationsMarkers.isNotEmpty){
           locationsMarkers.clear();
      }

     selectedLocationLat = position.latitude;
     selectedLocationLng = position.longitude;


          var locationLat = 5.709760636414532;
          var locationLng = -0.2004465088248253;
          var  destinationLat =  5.708696077300338;
          var  destinationLng = -0.19875671714544296;


            

       


  mapDirections.DirectionsResponse destinationDirections = await  directions.directionsWithLocation(Location(lat: locationLat,lng:locationLng), Location(lat: 5.682697669786985,lng: -0.17163723707199097,),transitRoutingPreference: TransitRoutingPreferences.fewerTransfers);


    List<mapDirections.Route>  routes   = destinationDirections.routes;

  

      if(destinationDirections.status != 'OK'){

          UtilityWidgets.getToast('Error displaying delivery personels information.');
          
      }


  myPrint(routes.length,heading: 'Number of Routes');
  
     
  Location legStartLocation =    routes.first.legs.first.steps.first.startLocation;

  Location legEndLocation   =  routes.first.legs.first.steps.first.endLocation;



    

   var bearing = Geolocator.bearingBetween(legStartLocation.lat, legStartLocation.lng, legEndLocation.lat, legEndLocation.lng);


  
       controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: bearing,
      target: LatLng(position.latitude, position.longitude),
     tilt: 45.0,
      zoom: 17.595899200439453)));

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

      chooseLocationWithLatLng(position.latitude,position.longitude);
    

       

    //  Future.delayed(Duration(seconds: 5),(){
    // List<Marker>   markersAsList = locationsMarkers.toList();
    
    
    //    setState(() {

    //        markersAsList[(markersAsList.indexOf(oldMarker))] = 
    //          Marker(

    //       markerId: oldMarker.markerId,
    //       //zIndex: 30.0,
    //       anchor: Offset(0.5,0.5),
    //       position: LatLng(5.7082460327554765,-0.19989833235740662),
    //       rotation: bearing,
    //       infoWindow: InfoWindow(
    //         title: 'Yussif Muniru',
    //         snippet: 'rating: 4.6',
            
    //       ),
    //       icon: pinLocationIcon!
    //     );
       
    //    locationsMarkers = markersAsList.toSet();
    
    //    });
    
    //  });


      
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
    catch(e){
      print('$e line 236');
    }
   
  }





 void setCustomMapPin() async {


     pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      Constants.DELIVERY_BIKE_ICON);
     
     //.fromBytes(convertedWidgetRes['data'].buffer.asUint8List());

      // setState(() {
        
      //  });

   }


  BitmapDescriptor? pinLocationIcon;

 List<Widget> locationsWidget = [];


 Widget liveParcelWidget(Parcel parcel){

   var image = Random().nextInt(6);

   return  Container(
                  width: _w ,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(15),
                    color: white,
                      ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(15),
                    color: white,
                    shadowColor: Color(0xFFf7f7f9),
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      width: _w,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                    
                              Row(
                    
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(parcel.parcelsQuantity.toString(),style: TextStyle(color: white,fontSize: 12.5)),
                                    decoration: BoxDecoration(
                                      color: black,
                                      shape: BoxShape.circle,
                                    )
                                  ),
                                   Container(
                                     margin: EdgeInsets.only(left: 3.0),
                                    padding: EdgeInsets.all(7.0),
                                    child: Text('${parcel.parcelType}',style: TextStyle(fontWeight: FontWeight.bold,color: black,fontSize: 14.5)),
                                    
                                   
                                  ),
                                ],
                              ),
                    
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 7.0),
                                    child: Text('₵ ${parcel.parcelPrice}.0',style: TextStyle(color:Color(0xFFa7a5b3),fontSize: 13.5,fontWeight: FontWeight.bold )),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(right: 3.0,left: 7.0),
                                    child: Icon(Ionicons.time_sharp,color: fadedHeadingsColor,size: 12.0)
                                  ),
                                  Text('${parcel.parcelDeliveryTime.toStringAsFixed(0)}mins',style: TextStyle(fontSize: 12.5),),
                                  
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    alignment:Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:brightMainColor,
                                    ),
                                    child: Icon(AntDesign.staro,color: white,size: 20.0)
                                  ),
                    
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 7),
                                    child: Text('${parcel.parcelDeliveryPersonelRating}',style:TextStyle(color: brightMainColor,fontSize: 13.5,fontWeight: FontWeight.bold)),
                                  ),
                    
                                  Text('${parcel.parcelDeliveryPersonelName}',style: TextStyle(color: Color(0xFF9f9fb2),fontSize: 12.5,fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 13.0),
                              Text('${parcel.receipientFullname} , ${parcel.parcelDestinationAddress}',style: TextStyle(color:Color(0xFF363e4a),fontSize: 14.0,fontWeight: FontWeight.bold)),
                            ],
                          ),

                          Expanded(child: SizedBox()),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              width: 75,
                              height: 75,
                             
                              child: Image.asset('assets/images/test_parcel_$image.jpg'  ,fit: BoxFit.cover),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(15.0),
                              //   // image: DecorationImage(image: Image.asset('assets/images/test_parcel_1.png').image)
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            
            
 }
 
 
 
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:false ? Center(child: loadingIndicator(width: 15.0, height: 15.0)) : Container(
        width: _w,
        height: _h,
        child: true ?   
                      Stack(
                        children: [

     
          
                  Animarker(
                    curve: Curves.ease,
          mapId: _controller.future.then<int>((value) => value.mapId), //Grab Google Map Id,
           zoom: 17.59,
            
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
    onCameraIdle: ()async{

    await Future.delayed( Duration(seconds:1 ), );
      setState(() {
      if(!isSearchBarVisible){
        isSearchBarVisible = true;
      }
        if(selectedLocationAddr.isNotEmpty){
          return;
    }
        if(!showLocationsSuggestions && locationsWidget.isNotEmpty){
        showLocationsSuggestions = true;
      }
    });

                var lat;
                var lng;

                
                if(lastKnownCameraPosition != null){
                    lng = lastKnownCameraPosition!.target.longitude;
                  lat = lastKnownCameraPosition!.target.latitude;
                }

                if((lat == lastFetchedLocationLat && lastFetchedLocationLng == lng) || lat == null || lng == null){
                return;
                }
                setState(()=>isAcquiringLocation = true);

              await chooseLocationWithLatLng(lat,lng);
              setState((){
                isAcquiringLocation = false;
                lastFetchedLocationLat = lat;
                lastFetchedLocationLng = lng;
              });
            //  GoogleMapController controller = await _controller.future;
            //    //setState(() { selectedLocationLat = position.latitude; selectedLocationLng = position.longitude;});
            //    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            //      bearing: 23.047945022583008,
            //      target: LatLng(lat,lng),
            //     tilt: 0.0,
            //      zoom: 16.595899200439453))).then((value) => null).whenComplete(() => ) ;
            
          

    },
    onCameraMove: (cameraPosition){
    setState(() {
      if(isSearchBarVisible){
        isSearchBarVisible = false;
      }
      if(showLocationsSuggestions){
        showLocationsSuggestions = false;
      }

      print(cameraPosition.target.latitude);
      print(cameraPosition.target.longitude);
      lastKnownCameraPosition = cameraPosition;
    });



    },
    onCameraMoveStarted: (){},
    compassEnabled: false,
    zoomControlsEnabled: false,
    onLongPress: (LatLng latLng)async{
    return;
    setState(()=>isAcquiringLocation = true);
          await chooseLocationWithLatLng(latLng.latitude,latLng.longitude);
              GoogleMapController controller = await _controller.future;
                //setState(() { selectedLocationLat = position.latitude; selectedLocationLng = position.longitude;});
                controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  bearing: 23.047945022583008,
                  target: LatLng(latLng.latitude, latLng.longitude),
                tilt: 0.0,
                  zoom: 16.595899200439453))).then((value) => null).whenComplete(() => setState(()=>isAcquiringLocation = false)) ;
            
            
            print('called from the _onMapCreated Widget  ');
                setState(() {
                  if(locationsMarkers.isNotEmpty){
    locationsMarkers.clear();
                  }
            
            
                
                
                      locationsMarkers[MarkerId('marker')] = Marker(
    markerId: MarkerId('marker'),
    zIndex: 30.0,
    position: LatLng(latLng.latitude, latLng.longitude),
    infoWindow: InfoWindow(
      title: 'Title',
      snippet: 'Address',
      
    ),
    icon: pinLocationIcon!
                      );
                  
                  
                });
                  
            },
              initialCameraPosition: CameraPosition(
              target: LatLng(5.6778757, -0.0174085),
            
                zoom:15.0,
              ),
              
        ),
    ),
    ],
    )



                          :
               StreamBuilder<QuerySnapshot>(
                 stream: null,
                 builder: (context, snapshot) {




                    if(snapshot.connectionState == ConnectionState.waiting){
                      myPrint('Loading .....');
                    }


                    if(snapshot.hasError){

                      myPrint(snapshot.error);  
                       }

                       if(snapshot.hasData){
                         if(snapshot.data != null){

                            myPrint('Yh... we have data for the best');
                         }

                       }

                       

                   return Stack(
                     alignment: Alignment.center,
                     children: [

                        GoogleMap(
                          onMapCreated: _onMapCreated,
                          myLocationEnabled: true,
                          trafficEnabled: false,
                          myLocationButtonEnabled: false,
                          mapType: MapType.normal ,
                          markers:  {Marker(markerId: MarkerId('m'),position: LatLng(5.6778757, -0.0174085))},
                          onCameraMoveStarted: (){},
                          compassEnabled: false,
                          zoomControlsEnabled: false,
                           initialCameraPosition: CameraPosition(
                          target: LatLng(5.6778757, -0.0174085),
                         zoom:15.0,
                                     ),
                                     
                               ),
                      
                         
               
                          //  Positioned.fill(child:Container(color: black.withOpacity(0.8))),
                            // AnimatedPositioned(
                            // bottom: 0,
                            // duration: Duration(seconds: 3),
                            // curve: Curves.easeInOut,
                            // child: Visibility(
                            //   visible: false,
                            //   child: Material(
                            //   elevation: 35.0,
                            //   borderRadius: BorderRadius.circular(30.0),
                            //   color: Color(0xFFf7f7f9).withOpacity(0.93),
                            //   child: Container(
                            //       width: _w ,
                            //       height: _h * 0.8,
                            //     padding: EdgeInsets.all(15.0),
                            //     child: Column(
                            //       children: [
                            
                            //     GestureDetector(
                            //       onTap: (){
                            //         print('tapped');
                            //       },
                            //       onVerticalDragUpdate: (DragUpdateDetails details){
                            
                            //         print(details.localPosition.dy);
                            //         print(details.globalPosition.dy);
                            //       },
                            //       child:  Column(
                            //         children: [
                            //           Container(
                            //             width: 50,
                            //             height: 5,
                            //             decoration: BoxDecoration(
                            //               color: Color(0xFF999ab7),
                            //               borderRadius: BorderRadius.circular(10.0),
                            //             ),
                            //           ),
                            //            Container(
                            //     margin: EdgeInsets.symmetric(vertical: 10.0),
                            //     child: Text('Tap on the parcels below to view more info',style: TextStyle(fontSize: 12.5,color: Color(0xFF999ab7),fontWeight: FontWeight.bold )),
                            //   ),
                            //         ],
                            //       ),),
                                
                                                       
                            //             Container(
                                      
                            //                   width: _w ,
                            //                   height: _h * 0.7,
                                
                            //                   child: ListView.builder(
                            //                     shrinkWrap: true,
                            //                     padding: EdgeInsets.all(0.0),
                            //                     itemCount: 10,
                            //                     itemBuilder: (context,index)=>  liveParcelWidget(Parcel(parcelsQuantity: 3,parcelType: 'Cloth',parcelDeliveryTime: 25 ,parcelPrice: 11,parcelDeliveryPersonelRating: 3.6,parcelDeliveryPersonelName: 
                            //                       'Yussif Muniru',receipientFullname: 'Yussif Muniru',parcelDestinationAddress: 'Maglo Mini-mart')), 
                                                  
                            //                           ),
                            //           ),
                            //         ],
                            //       ),
                            //       ),
                            //       ),
                            // ),
                              
                                                      
                                             
                            //               ),
                             
                                    
    
               
                        // AnimatedPositioned(
                        //   duration: Duration(milliseconds: 600),
                        //   curve: Curves.easeInOut,
                        //   top: _h * 0.419,
                        //                         child: 
                        //                         Container(width:60,height: 60.0 ,child: Image.asset(Constants.SELECT_LOCATION_MARKER,)),
                        //                       ),
               


                                    //            Positioned(
                                    //              left: 15.0,
                                    //              top: 30.0,
                                    //              child:   InkWell(
                                    //                onTap: (){
                                    //                  if(Navigator.canPop(context)){
                                    //                    Navigator.pop(context);
                                    //                  }
                                    //                },
                                    //                            child: Container(
                                    //                width: _w * 0.1,
                                    //                height: _w * 0.1,
                                    //                decoration: BoxDecoration(shape: BoxShape.circle),
                                    //            child:
                                    //                Material(
                                    //                  elevation: 15.0,
                                    //                  borderRadius: BorderRadius.circular((_w * 0.1) / 2),
                                                 
                                    //                  color: Colors.white,child: Icon(Ionicons.ios_arrow_back,size: 14.0 ))),
                                    //              ),
                                    //  ),
                                     
                                     
               
               
                                         AnimatedPositioned(
                                              top: showLocationsSuggestions ? 90.0: 45.0 ,
                                                  // top: 135.0,
                                                      left:15.0 ,
                                                      duration: Duration(milliseconds: 600),
                                                      curve: Curves.easeInOut,
                                                      child: AnimatedOpacity(
                                                     opacity:showLocationsSuggestions ? 1.0 : 0.0,
                                                   //  opacity: 1.0,
                                                        duration: Duration(milliseconds: 600),
                                                        curve: Curves.easeInOut,
                                                       child: Container(
                                               width: _w * 0.9 ,
                                               height: _h * 0.43,
                                               margin: EdgeInsets.only(top: 30.0),
                                             padding: EdgeInsets.symmetric(horizontal: 13.0,vertical: 10.0),
                                             child:
                                         
                                               Material(
                                                 elevation: 10.0,
                                                 borderRadius: BorderRadius.circular(5.0),
                                                 color: Colors.white,
                                               child: 
                                                   ListView(
                                                     shrinkWrap: true,
                                                     children:locationsWidget
                                                   ),
                                                
                                               ),
                                             
                                             ),
                                                      ),
                                                          ),
                                     
                                                              
                                     
                           //                                       AnimatedPositioned(
                           //                                       top:isSearchBarVisible ? 60.0 : 0.0 ,
                           //                                        duration: Duration(seconds: 1),
                           //                                  curve: Curves.easeInOut,
                           //                                       child: AnimatedOpacity(
                           //                                  duration: Duration(seconds: 1),
                           //                                  curve: Curves.easeInOut,
                           //                                  opacity: isSearchBarVisible ? 1.0: 0.0,
                           //                                            child: 
                           //                                        Container(
                           //                                width: _w ,
                           //                                height: _h * 0.08,
                           //                             //   margin: EdgeInsets.only(top: 30.0),
                           //                              padding: EdgeInsets.symmetric(horizontal: 13.0,vertical: 5.0),
                           //                              child:
                                         
                           //                                Material(
                           //                                  elevation: 15.0,
                           //                                  borderRadius: BorderRadius.circular(5.0),
                           //                                  color: Colors.white,
                           //                                child: Row(
                           //                                 children: [
                                             
                           //                                      Container(
                           //                                        width: 10.0,
                           //                                        height:10.0,
                                                     
                           //                                          margin: EdgeInsets.only(left: 10.0,right: 10.0),
                           //                                        decoration: BoxDecoration(
                           //                                          color: true ? linkColor : Colors.black,
                           //                                          shape: BoxShape.circle,
                           //                                        ),
                                                   
                                             
                                               
                           //                              ),
                                              
                           // //                         Container(
                           // //                                  width: _w * 0.7,
                           // //                                  padding: EdgeInsets.only(right: 15.0),
                           // //                                  child: TextField(
                           // //                                    controller: searchLocationController,
                           // //                                    focusNode: searchLocationFocusNode,
                           // //                                    style: TextStyle(
                           // //                                      color: warmPrimaryColor,
                           // //                                      fontWeight: FontWeight.bold,
                           // //                                      fontSize: 13.0,
                           // //                                    ),
                           // //                                    cursorColor: warmPrimaryColor,
                           // //                                    decoration: InputDecoration.collapsed(
                           // //                                      hintText: 'search location',
                           // //                                      hintStyle: TextStyle(
                           // //                                        color: Color(0xFFd7e0ef),
                           // //                                        fontSize: 13,
                           // //                                      ),
                           // //                                    ),
                           // //                                    onChanged: (String location)async{
                           // //                                      if(location.isEmpty){
                                                     
                           // //                                      setState((){
                                                       
                           // //                                         showLocationsSuggestions = false;
                           // //                                      });
                           // //                                      return;
                           // //                                      }
                           // //                                       setState(() { isAcquiringLocation = true;
                                                      
                           // //                                       showLocationsSuggestions = true;
                           // //                                       });
                           // //                                       setState(() {
                           // //                                         locationsWidget = searchingLocationsIndicators();
                           // //           });
                           // //           List<PlacesSearchResult> locationRes =    (await  places.searchByText(location,radius: 50000)).results;
                           // //           List<Widget> locations = [];
                           // //           locationRes.forEach((PlacesSearchResult place) {
                            
                           // //                   locations.add(locationSuggestionWidget(name: place.name , city: place.formattedAddress , onTap: ()async{
                           // //                     setState(() {
                                      
                           // //                       isAcquiringLocation = true;
                           // //                       showLocationsSuggestions = false;
                           // //                     });
                           // //                    searchLocationFocusNode.unfocus();
                           // //                   await chooseLocationWithLatLng(place.geometry!.location.lat, place.geometry!.location.lng);
                           // //                    setState((){
                           // //                      isAcquiringLocation = false;
                           // //                    });
                           // //                    animateCameraToLocation(place.geometry!.location.lat, place.geometry!.location.lng);
                           // //                                       }
                                            
                           // //           ));
                           // //                             print(place.name);
                           // //                             print(place.vicinity);
                           // //                             print(place.scope);
                           // //                             print(place.placeId);
                           // //                             print(place.formattedAddress);
                           // //                               });
                           // //               print(locationsWidget.length);
                           // //                           if(locations.isNotEmpty){
                           // //                             setState(() => locationsWidget = locations);
                           // //                             print(locationsWidget.length);
                           // //                             print('Above is the locations widget length.please verify');
                           // //                           }else{
                           // //                             print('Ooops!!!, no result found.');
                           // //                           }  
                                                
                           // //                                   setState(() {
                           // //                                     isAcquiringLocation = false;
                           // //           if(locations.isEmpty){
                           // //           setState(() => locationsWidget = [ Column(
                      
                           // //             children: [
                           // //               Container(
                           // //                 margin: EdgeInsets.only(top: 70.0),
                           // //                 width:40.0,
                           // //                 height: 40.0,child:Image.asset(Constants.GRAY_SEARCH_ICON,fit: BoxFit.cover) ),
                           // //               Container(
                           // //                 margin: EdgeInsets.only(bottom: 10.0),
                           // //                 child: Text('Oops!!! No Locations found',style: TextStyle(color: warmPrimaryColor,fontSize: 17.0, fontWeight: FontWeight.bold)),
                           // //               ),
                           // //                Container(
                           // //                child: Text('Please check the location name and try again.',style: TextStyle(color: fadedHeadingsColor,fontSize: 12.0)),
                           // //               ),
                           // //             ],
                           // //           )]);
                          
                           // //           }
                         
                           // // });
                             
                           // //                               },
                           // //                             ),
                           // //                         ),
                                          
               
                                    
                           //                                   InkWell(
                           //                                     onTap: (){
                           //                           if(searchLocationController.text.isNotEmpty){
                          
                           //                             setState(() {
                           //                               searchLocationController.text = '';
                           //                               if(showLocationsSuggestions){
                           //                                  showLocationsSuggestions = false;
                           //                               }
                                             
                           //                             });
                          
                           //                           }
                           //                                     },
                           //                                                             child: Container(
                                                      
                           //                                       child: Icon(Feather.x, size: 19.0, color: warmPrimaryColor)
                           //                                     ),
                           //                                   ),       
                           //                                         ]
                           //                                     ),
                           //                           ),
                                        
                           //                         ),
                           //                                 )
                           //                                     ),
                                
                                                    
                             
                 
                      // Positioned(
                      //                       bottom: 200.0,
                      //                       right: 20.0,
                      //                       child:   InkWell(
                      //                         onTap: ()async{
                      //                         print('tapped');
                      //                         await goToCurrentLocation();
                                              
                      //                         },
                      //                         child: AnimatedOpacity(
                      //                                       opacity: isAcquiringLocation ? 0.5 : 1.0,
                      //                                       duration: Duration(milliseconds: 400),
                      //                                       curve: Curves.easeInOut, 
                      //                                       child: Container(
                      //                                 width: _w * 0.1,
                      //                         height: _w * 0.1,
                      //                   // padding: EdgeInsets.symmetric(horizontal: 13.0,),
                      //                     decoration: BoxDecoration(shape: BoxShape.circle),
                      //                     child:
                      //                         Material(
                      //                           elevation: 10.0,
                      //                           borderRadius: BorderRadius.circular((_w * 0.1) / 2),
                      //                         //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((_w*0.2) /2)) ,
                      //                           color: Colors.white,child: Icon(EvilIcons.location ,size: 16.0 ))),
                      //                                     ),
                      //                       ),
                      //           ),
                                              
                                              
                                              
                                                ],
                                              );
                 }
               ),
                                      
                                      
                                  ),
                                  
                                );
                              }





  Widget deliveryPill(){
    return RepaintBoundary(
     key: deliveryPersonelPillKey,
     child: Stack(
      
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
                    child:  true ? Container(child: Icon(MaterialIcons.my_location,size:37)) : Image.asset('assets/images/parcel_icon.png',fit: BoxFit.cover),
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
                    color:  Color(0xFFf7f7f9).withOpacity(0.93),
                ),
                
                height: 20,
                width: 20,
                
              ),
            ),
          ),
   
   
   
                  
                  ],
                ),
   );
           
  }

  Widget isSearchingLocationByTextWidget(){
        
      return Container(child: loadingIndicator(width: 30.0,height: 30.0,valueColor: warmPrimaryColor));
      }       
  
                      
Widget locationSuggestionWidget({name = '', city = '',required  Function() onTap}){
     return  InkWell(
                      onTap: onTap,
                      child: Row(
                     children: [
                      
                            Container(
                              // width: 20.0,
                              // height:20.0,
                              child: Icon(Ionicons.ios_location,size: 14.0),
                              padding: EdgeInsets.all(7.0),
                              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 10.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFFC0C0C0).withOpacity(0.5) ,
                                  shape: BoxShape.circle,
                              ),
                        
                      
                      
                      ),
                      Expanded(
                                                          child: 
                                                          Container(
                          margin: EdgeInsets.only(right: 20.0),
                          padding: EdgeInsets.only(top: 20.0, bottom: 10.0,right: 10.0,),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color:Color(0xFFC0C0C0).withOpacity(0.3))),
                          ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: TextStyle( color: warmPrimaryColor.withOpacity(0.9),fontSize: 13.0, fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child:  Text(city, style: TextStyle( color:Color(0xFFC0C0C0).withOpacity(0.8),fontSize: 11.0, )),
                            ),
                          ],
                        ),
                        ),
                      ),
                      
                      ]
                      ),
                                );
                      
                      }
                            
                            
 Future<Position> _determinePosition() async {
                      bool serviceEnabled;
                      LocationPermission permission;
                      
                  
                      serviceEnabled = await Geolocator.isLocationServiceEnabled();
                      if (!serviceEnabled) {
                        return Future.error('Location services are disabled.');
                      } else {
                        await Geolocator.requestPermission();
                        if (Platform.isAndroid) {
                          await Geolocator.openLocationSettings();
                        
                        } else if (Platform.isIOS) {
                          await Geolocator.openAppSettings();
                        }
                      }
                  
                      permission = await Geolocator.checkPermission();
                      if (permission == LocationPermission.deniedForever) {
                        return Future.error(
                            'Location permissions are permantly denied, we cannot request permissions.');
                      }
                  
                      if (permission == LocationPermission.denied) {
                        permission = await Geolocator.requestPermission();
                        if (permission != LocationPermission.whileInUse &&
                            permission != LocationPermission.always) {
                          return Future.error(
                              'Location permissions are denied (actual value: $permission).');
                        }
                      }
                  
                      return await Geolocator.getCurrentPosition();
                    }
            
 
                      
Future<bool> chooseLocationWithLatLng(double latitude, double longitude)async {
      
               
                  // PlacesSearchResponse response = await places.searchNearbyWithRankBy( Location(latitude, longitude), "distance", keyword: '' );
                   PlacesSearchResponse response = await places.searchNearbyWithRankBy( Location(lat:latitude, lng:longitude), "distance", keyword: '' );
                  if(response.isDenied ){
                    print('Response not found, please try again later.');
                  return false ;
                  }
      
                  if(response.isInvalid){
                    print('Response not found, please try again later2.');
                  return false;
                  }
                  if( response.isNotFound){
                    print('Response not found, please try again later3.');
                  return false;
                  }
                  List<PlacesSearchResult> placesRes = response.results;
      
      
                  setState(() {
      
                  if( placesRes.first.name != selectedLocationAddr){
                      selectedLocationAddr =  placesRes.first.name;
                      selectedLocationPlaceID =  placesRes.first.placeId;
                      selectedLocationLat = placesRes.first.geometry!.location.lat;
                      selectedLocationLng = placesRes.first.geometry!.location.lng;
                  }

                  });
      
      return true;
      }

      
 List<Widget> searchingLocationsIndicators() {
      return 
     List.generate(10, (index) => loadingQueryLocationsIndicator());
      
      }


 Widget loadingQueryLocationsIndicator(){
         return   Container(width: 250.0,padding: EdgeInsets.symmetric(vertical: 15.0),child: Row(
            children: [
              Container(
                width: 25.0,
                height: 25.0,
               
                margin: EdgeInsets.only(left: 20.0,right: 10.0),
            
              decoration: BoxDecoration(
                 color: Color(0xFFC0C0C0).withOpacity(0.5) ,
              borderRadius: BorderRadius.circular(8.0))),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                  Container(
                width: 150.0,
                height: 10.0,
                  
              decoration: BoxDecoration(
                  color: Color(0xFFC0C0C0).withOpacity(0.5) ,
              borderRadius: BorderRadius.circular(3.5))),
                 Container(
                   margin: EdgeInsets.only(top: 10.0),
                width: 100.0,
                height: 10.0,
                  
              decoration: BoxDecoration(
                 color: Color(0xFFC0C0C0).withOpacity(0.5),
              borderRadius: BorderRadius.circular(5.0))),
              ]),
              
              
            ]));
       }
    
    
void searchByPlaceID(String placeId)async {
              print('Called in the app');
      PlacesDetailsResponse response = await places.getDetailsByPlaceId(placeId);
          if(response.isDenied ){
                  print('Response not found, please try again later.');
                return ;
                }
      
          if(response.isInvalid){
                  print('Response not found, please try again later2.');
                return ;
                }
          if( response.isNotFound){
                  print('Response not found, please try again later3.');
                return ;
                }
      
      PlaceDetails placesRes = response.result;
      
      print(placesRes.adrAddress);
      print(placesRes.geometry!.location.lat);

            if(placesRes.name.isEmpty ){
              print('Data missed please try again');
        return;
            }
            print(placesRes.name);
      
            print("placesRes.first.name");
            setState(() {
      
            if( placesRes.name != selectedLocationAddr){
            selectedLocationAddr =  placesRes.name;
            }
            });
                          }
      


}


