
import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import "package:google_maps_webservice/places.dart";




class SelectLocationOnMapRoute extends StatefulWidget {
  @override
  _SelectLocationOnMapRouteState createState() => _SelectLocationOnMapRouteState();
}

class _SelectLocationOnMapRouteState extends State<SelectLocationOnMapRoute> {
 
  
  late double _w;
  late double _h;
  late String _mapStyle;
  Completer<GoogleMapController> _controller = Completer();
 final places =  GoogleMapsPlaces(apiKey: Constants.GOOGLE_WEB_SERVICES_MAPS_API_KEY);
  FocusNode focusNode = FocusNode();

  TextEditingController searchLocationController = TextEditingController();
  late bool showLocationsSuggestions;

  String previousValue = '';
  late bool isLoadingMapStyle;
  late bool isAcquiringLocation;
  Set<Marker> selectedLocationMarker = HashSet<Marker>();
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



@override
void initState(){
  super.initState();

  lastFetchedLocationLat = 0.0;
  lastFetchedLocationLng = 0.0;
  selectedLocationLat = 0.0;
  selectedLocationLng = 0.0;
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
currentPositionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation,intervalDuration: Duration(milliseconds:500),timeLimit: Duration(seconds: 8)).listen(
    (Position position) {
     if(position != null){
      

  chooseLocationWithLatLng(position.latitude, position.longitude);

 _controller.future.then((GoogleMapController controller){

   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 23.047945022583008,
      target: LatLng(position.latitude, position.longitude),
     tilt: 0.0,
      zoom: 16.595899200439453)));
  
setCustomMapPin();
 } ).onError((error, stackTrace) => UtilityWidgets.getToast('Location taking too long.'));


     }
    });

  
 

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
      if(selectedLocationMarker.isNotEmpty){
           selectedLocationMarker.clear();
      }


    
     
        selectedLocationMarker.add( Marker(
          markerId: MarkerId('marker'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: 'Title',
            snippet: 'Address',
            anchor: Offset(0.0,0.0) ,
          ),
         zIndex: 10.0,
          icon:pinLocationIcon ,
        ));
      
      
    });

   
      
   return true;
}


 void goToLocation(double lat, double lng)async{
      GoogleMapController controller = await _controller.future;
     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 23.047945022583008,
      target: LatLng(lat, lng),
     tilt: 0.0,
      zoom: 16.595899200439453))).whenComplete(() => showLocationsSuggestions = false);
       setState(() {
      if(selectedLocationMarker.isNotEmpty){
           selectedLocationMarker.clear();
      }
       });

    
     
        selectedLocationMarker.add( Marker(
          markerId: MarkerId('marker'),
          zIndex: 30.0,
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: 'Title',
            snippet: 'Address',
            
          ),
          icon: pinLocationIcon
        ));
        chooseLocationWithLatLng(lat, lng);
 }

      final Map<String, Marker> _markers = {};
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
      bearing: 23.047945022583008,
      target: LatLng(position.latitude, position.longitude),
     tilt: 0.0,
      zoom: 16.595899200439453);
      chooseLocationWithLatLng(position.latitude, position.longitude);

    //setState(() { selectedLocationLat = position.latitude; selectedLocationLng = position.longitude;});
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 23.047945022583008,
      target: LatLng(position.latitude, position.longitude),
     tilt: 0.0,
      zoom: 16.595899200439453))).then((value) => null).whenComplete(() => setState(()=>isAcquiringLocation = false)) ;


print('called from the _onMapCreated Widget');
    setState(() {
      if(selectedLocationMarker.isNotEmpty){
           selectedLocationMarker.clear();
      }
     selectedLocationLat = position.latitude;
     selectedLocationLng = position.longitude;
     
        selectedLocationMarker.add( Marker(
          markerId: MarkerId('marker'),
          zIndex: 30.0,
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: 'Title',
            snippet: 'Address',
            
          ),
          icon: pinLocationIcon
        ));
      
      chooseLocationWithLatLng(position.latitude,position.longitude);
    });
      
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
      Constants.SELECT_LOCATION_MARKER);
   }


 late BitmapDescriptor pinLocationIcon;

 List<Widget> locationsWidget = [];
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:isLoadingMapStyle ? Center(child: loadingIndicator(width: 15.0, height: 15.0)) : Container(
        width: _w,
        height: _h,
        child: 
               Stack(
                 alignment: Alignment.center,
                 children: [
                  
                     GoogleMap(
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      mapType: MapType.normal ,
                     // markers: selectedLocationMarker,
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
                 if(selectedLocationMarker.isNotEmpty){
                        selectedLocationMarker.clear();
                 }
           
           
               
                
                     selectedLocationMarker.add( Marker(
                       markerId: MarkerId('marker'),
                       zIndex: 30.0,
                       position: LatLng(latLng.latitude, latLng.longitude),
                       infoWindow: InfoWindow(
                         title: 'Title',
                         snippet: 'Address',
                         
                       ),
                       icon: pinLocationIcon
                     ));
                 
                 
               });
                 
                               },
                                 initialCameraPosition: CameraPosition(
                                 target: LatLng(5.6778757, -0.0174085),
                               
                                   zoom:15.0,
                                 ),
                                 
                           ),
                    


                    AnimatedPositioned(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      top: _h * 0.419,
                                            child: 
                                            Container(width:60,height: 60.0 ,child: Image.asset(Constants.SELECT_LOCATION_MARKER,)),
                                          ),

                                           Positioned(
                                             left: 15.0,
                                             top: 30.0,
                                             child:   InkWell(
                                               onTap: (){
                                                 if(Navigator.canPop(context)){
                                                   Navigator.pop(context);
                                                 }
                                               },
                                                           child: Container(
                                               width: _w * 0.1,
                                               height: _w * 0.1,
                                               decoration: BoxDecoration(shape: BoxShape.circle),
                                           child:
                                               Material(
                                                 elevation: 15.0,
                                                 borderRadius: BorderRadius.circular((_w * 0.1) / 2),
                                             
                                                 color: Colors.white,child: Icon(Ionicons.ios_arrow_back,size: 14.0 ))),
                                             ),
                                 ),
                                 
                                 
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
                                 
                                                          
                                 
                                                  AnimatedPositioned(
                                                  top:isSearchBarVisible ? 60.0 : 0.0 ,
                                                   duration: Duration(seconds: 1),
                                             curve: Curves.easeInOut,
                                                  child: AnimatedOpacity(
                                             duration: Duration(seconds: 1),
                                             curve: Curves.easeInOut,
                                             opacity: isSearchBarVisible ? 1.0: 0.0,
                                                       child: 
                                                   Container(
                                           width: _w ,
                                           height: _h * 0.08,
                                        //   margin: EdgeInsets.only(top: 30.0),
                                         padding: EdgeInsets.symmetric(horizontal: 13.0,vertical: 5.0),
                                         child:
                                     
                                           Material(
                                             elevation: 15.0,
                                             borderRadius: BorderRadius.circular(5.0),
                                             color: Colors.white,
                                           child: Row(
                                            children: [
                                         
                                                 Container(
                                                   width: 10.0,
                                                   height:10.0,
                                                 
                                                     margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                                   decoration: BoxDecoration(
                                                     color: true ? linkColor : Colors.black,
                                                     shape: BoxShape.circle,
                                                   ),
                                               
                                         
                                           
                                         ),
                                          
                                    Container(
                                             width: _w * 0.7,
                                             padding: EdgeInsets.only(right: 15.0),
                                             child: TextField(
                                               controller: searchLocationController,
                                               focusNode: searchLocationFocusNode,
                                               style: TextStyle(
                                                 color: warmPrimaryColor,
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: 13.0,
                                               ),
                                               cursorColor: warmPrimaryColor,
                                               decoration: InputDecoration.collapsed(
                                                 hintText: 'search location',
                                                 hintStyle: TextStyle(
                                                   color: Color(0xFFd7e0ef),
                                                   fontSize: 13,
                                                 ),
                                               ),
                                               onChanged: (String location)async{
                                                 if(location.isEmpty){
                                                 
                                                 setState((){
                                                   
                                                    showLocationsSuggestions = false;
                                                 });
                                                 return;
                                                 }
                                                  setState(() { isAcquiringLocation = true;
                                                  
                                                  showLocationsSuggestions = true;
                                                  });
                                                  setState(() {
                                                    locationsWidget = searchingLocationsIndicators();
                      });
                      List<PlacesSearchResult> locationRes =    (await  places.searchByText(location,radius: 50000)).results;
                      List<Widget> locations = [];
                      locationRes.forEach((PlacesSearchResult place) {
                        
                              locations.add(locationSuggestionWidget(name: place.name , city: place.formattedAddress , onTap: ()async{
                                setState(() {
                                  
                                  isAcquiringLocation = true;
                                  showLocationsSuggestions = false;
                                });
                               searchLocationFocusNode.unfocus();
                              await chooseLocationWithLatLng(place.geometry!.location.lat, place.geometry!.location.lng);
                               setState((){
                                 isAcquiringLocation = false;
                               });
                               goToLocation(place.geometry!.location.lat, place.geometry!.location.lng);
                                                  }
                                        
                      ));
                                        print(place.name);
                                        print(place.vicinity);
                                        print(place.scope);
                                        print(place.placeId);
                                        print(place.formattedAddress);
                                          });
                          print(locationsWidget.length);
                                      if(locations.isNotEmpty){
                                        setState(() => locationsWidget = locations);
                                        print(locationsWidget.length);
                                        print('Above is the locations widget length.please verify');
                                      }else{
                                        print('Ooops!!!, no result found.');
                                      }  
                                            
                                              setState(() {
                                                isAcquiringLocation = false;
                      if(locations.isEmpty){
                      setState(() => locationsWidget = [ Column(
                  
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 70.0),
                            width:40.0,
                            height: 40.0,child:Image.asset(Constants.GRAY_SEARCH_ICON,fit: BoxFit.cover) ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Text('Oops!!! No Locations found',style: TextStyle(color: warmPrimaryColor,fontSize: 17.0, fontWeight: FontWeight.bold)),
                          ),
                           Container(
                           child: Text('Please check the location name and try again.',style: TextStyle(color: fadedHeadingsColor,fontSize: 12.0)),
                          ),
                        ],
                      )]);
                      
                      }
          
            });
                         
                                          },
                                        ),
                                    ),
                                      
                                
                                              InkWell(
                                                onTap: (){
                                      if(searchLocationController.text.isNotEmpty){
                      
                                        setState(() {
                                          searchLocationController.text = '';
                                          if(showLocationsSuggestions){
                                             showLocationsSuggestions = false;
                                          }
                                         
                                        });
                      
                                      }
                                                },
                                                                        child: Container(
                                                  
                                                  child: Icon(Feather.x, size: 19.0, color: warmPrimaryColor)
                                                ),
                                              ),       
                                                    ]
                                                ),
                                      ),
                                    
                                    ),
                                            )
                                                ),
                            
                                                
                                                
                                                  AnimatedPositioned(
                                            bottom: isLoadingMapStyle ?  -50.0  : -10.0,
                                            duration: Duration(seconds: 3),
                                            curve: Curves.easeInOut,
                                          //   left:25.0 ,
                                            child: Container(
                                      width: _w ,
                                      height: _h * 0.3,
                                      margin: EdgeInsets.only(top: 30.0),
                                    padding: EdgeInsets.symmetric(vertical: 10.0),
                                    child:
                                      Material(
                                        elevation: 35.0,
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.white,
                                      child: Container(
                                        padding: EdgeInsets.only(top: 15.0,left: 20.0, right: 20.0),
                                        child: Column(
                                          crossAxisAlignment : CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(bottom: 10.0,top: 10.0),
                                              child: Text('Select Location', style: TextStyle(color: warmPrimaryColor.withOpacity(0.9),fontSize: 16.0, fontWeight: FontWeight.bold)),
                                            ),
                                            Container(
                                              width: _w * 0.9,
                                              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 15.0 ),
                                              decoration: BoxDecoration(
                                                color:Color(0xFFC0C0C0).withOpacity(0.3) ,
                                                borderRadius: BorderRadius.circular(7),
                                              ),
                            
                                              child:Row(
                                                children: [
                                                  AnimatedOpacity(duration: Duration(milliseconds: 400),curve: Curves.easeInOut,opacity: isAcquiringLocation ? 0.5 : 1.0,child: isAcquiringLocation ? Text('...........', style: TextStyle( fontWeight:FontWeight.bold ,fontSize: 12.0)) :  Container(width: _w * 0.7,child:Text(selectedLocationAddr,overflow: TextOverflow.ellipsis ,style: TextStyle( fontWeight:FontWeight.bold ,fontSize: 16.0)))),
                                             //     Expanded(child: SizedBox()),
                                                  Container(
                                                    child: AnimatedOpacity(
                                                      opacity: isAcquiringLocation ? 1.0 : 0.0 ,
                                                      curve: Curves.easeInOut,
                                                      duration: Duration(milliseconds:500 ),
                                                      child: 
                                                      loadingIndicator(width: 25.0, height:25.0))
                                                  ),
                                                ],
                                              ),
                                            
                                            ),
                            
                                                  Container(
                                                    margin: EdgeInsets.only(top: 20.0),
                                                    child: UtilityWidgets.customCancelButton(context,(){
                                                      if(Navigator.canPop(context)){
                                                         Navigator.pop(context,[selectedLocationAddr, selectedLocationLat,selectedLocationLng]);
                                                      }
                                               
                                                    }, cancelText: isAcquiringLocation ? 'Loading...please wait' : 'Choose Location',isLong: true, isDisabled: isAcquiringLocation),
                                                  ),    
                                                      ]
                                                  ),
                                      ),
                                      ),
                                    
                                    ),
                                                ),
                                              
                  Positioned(
                                        bottom: 200.0,
                                        right: 20.0,
                                        child:   InkWell(
                                          onTap: ()async{
                                          print('tapped');
                                          await goToCurrentLocation();
                                          
                                          },
                                          child: AnimatedOpacity(
                                                        opacity: isAcquiringLocation ? 0.5 : 1.0,
                                                        duration: Duration(milliseconds: 400),
                                                        curve: Curves.easeInOut, 
                                                        child: Container(
                                                  width: _w * 0.1,
                                          height: _w * 0.1,
                                    // padding: EdgeInsets.symmetric(horizontal: 13.0,),
                                      decoration: BoxDecoration(shape: BoxShape.circle),
                                      child:
                                          Material(
                                            elevation: 10.0,
                                            borderRadius: BorderRadius.circular((_w * 0.1) / 2),
                                          //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((_w*0.2) /2)) ,
                                            color: Colors.white,child: Icon(EvilIcons.location ,size: 16.0 ))),
                                                      ),
                                        ),
                            ),
                                            ],
                                          ),
                                      
                                      
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
       loadingQueryLocationsIndicator(){
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

