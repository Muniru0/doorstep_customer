

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/model_registry.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/helper_functions.dart/functions.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:location/location.dart' as bgLocation;
import 'package:validators/validators.dart';

class BookRidesScreen extends StatefulWidget {
  const BookRidesScreen({ Key? key }) : super(key: key);

  @override
  _BookRidesScreenState createState() => _BookRidesScreenState();
}

class _BookRidesScreenState extends State<BookRidesScreen>  with WidgetsBindingObserver {
  late bool _showBlurredOverlay;
  late PanelController _panelController;
  late double _w;
  late  double _h;
  late Completer<GoogleMapController> _googleMapController;

  late double _mapZoom;
  late Map<MarkerId,Marker> locationsMarkers ;
  BitmapDescriptor? pinLocationIcon; 
  late Map<PolylineId, Polyline> polylines;
  late   bool openDrawer;
  late WidgetsFlags _widgetFlag;
  late String _mapStyle;
  late UserModel _userModel;
  CameraPosition? _lastKnownCameraPosition;

  Color customFadedColor = const Color(0xFF636363);

  Color  customerWhiteColor = const Color(0xFFf7f7f9);

 late bool _addedToFavorites;
  final GlobalKey _firstMarkerLableKey = GlobalKey();
  final GlobalKey _secondMarkerLableKey = GlobalKey();
  final GlobalKey _thirdMarkerLableKey = GlobalKey();


 late TextEditingController _dropOffLocationSearchFieldController;

  late TextEditingController _pickupLocationSearchFieldController;

  late TextEditingController _preferedCourierServiceFieldController;

  late FocusNode _pickupLocationFocusNode;
  late FocusNode _dropOffLocationFocusNode;
  late FocusNode _preferedCourierServiceFocusNode;

   List<Widget> locationsWidget = [];

  late bool _showPlacesParentWidget;

late  bool isAcquiringLocation;
 final _googleMapsPlaces =  GoogleMapsPlaces(apiKey: Constants.GOOGLE_WEB_SERVICES_MAPS_API_KEY);

  late bool _addRecipientDetails;

  late TextEditingController _receiverNameTextEditingController;
  late TextEditingController _receiverPhoneTextEditingController;

  late FocusNode _receiverPhoneFocusNode;

  late FocusNode _receiverNameFocusNode;

  late bool _enableInterCityDeliveryType;

 late String _preferedCourierService;

 late bool _showInterCityLearnMoreWidget;

 late MarkerLabelData _firstMarkerLabelDataObj;
 late MarkerLabelData _secondMarkerLabelDataObj;
 late MarkerLabelData _thirdMarkerLabel;

  BitmapDescriptor? pickupLocationIcon;

  BitmapDescriptor? branchOfficeLocationIcon;

  BitmapDescriptor? destinationPlaceHolderIcon;

  BitmapDescriptor? parcelMarkerIcon;
  late bgLocation.Location location;

  var _firstLatLng;

  var _secondLatLng;

 final CarouselController _carouselController = CarouselController();

  late bool _showMultiplePhoneNumbersSelectionWidget;
  Contact? _receipientContact;

 late int _quantityOfParcels;

  late TextEditingController _courierServiceSearchTextEditingController;

  late bool _showCourierServiceSearchWidget;

 late bool _showIntercityDestinationSearchWidget;

 late String _selectedIntercityDestination;

  late bool _showParcelTypeSelectionWidget;

 late ParcelTypeObj _selectedParcelType;

  late String _selectedCourierService;


 final List<PolytheneBagParcelSizeObj> _polytheneBagParcelSizeObjList = [

        PolytheneBagParcelSizeObj(
          bagSize: 1,
          bagSizeSubCategory: 'Medium',
          bagStandardPrice: '0.50',
          parcelMaxWeight: 7.5,
          parcelMaxLength: 85,
          parcelMaxWidth:45,
          parcelMaxHeight: 100,
          parcelMinPrice:10.0,
          parcelSizeReferenceString: 'Can fit a 5kg rice bag',
          parcelSizeDescriptionString : '33.5 x 17.55 x 39" A parcel of this size can fit the standard medium sized black polythene bag. By reference, can fit a 5kg rice bag with considerable spacing around.'
        ),

        PolytheneBagParcelSizeObj(
          bagSize: 2,
          bagSizeSubCategory: 'Large',
          bagStandardPrice: '1.0',
          parcelMaxWeight: 25,
          parcelMaxLength: 150,
          parcelMaxWidth:90,
          parcelMaxHeight: 230,
           parcelMinPrice:10.0,
          parcelSizeReferenceString: 'Large size polythene',
          parcelSizeDescriptionString : '58 x 35.1 x 89.7" A parcel of this size can fit the standard large sized black polythene bag (mostly used as a bin liner).  By reference, can fit a 5kg rice bag with considerable spacing around.'
        ),


 ]; 

 final List<CorrugatedBoxParcelSizeObj> _corrugatedBoxParcelSizeObjList = [
   
    CorrugatedBoxParcelSizeObj(
      parcelSize: 1,
      parcelSizeSubCategory: 'Small',
      parcelMaxLength: 19.0,
      parcelMaxWidth:14.6,
      parcelMaxHeight: 6.4,
      parcelMaxWeight:0.35,
      parcelMinPrice: 5.1,
      parcelReferenceObj: 'Small phone box',
      parcelSizeReferenceString : 'Can fit in a small phone box',
      parcelSizeDescriptionString:'7.41 x 5.46 x 2.496" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit in a small phone box<b>.'
    ),

     CorrugatedBoxParcelSizeObj(
      parcelSize: 2,
      parcelSizeSubCategory: 'Small',
      parcelMaxLength: 15.0,
      parcelMaxWidth:15.0,
      parcelMaxHeight: 7.5,
      parcelMaxWeight:0.35,
      parcelMinPrice: 5.1,
      parcelReferenceObj: 'Small square cake',
      parcelSizeReferenceString : 'Can fit in a small square cake',
      parcelSizeDescriptionString:'5.58 x 5.58 x 2.925" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit in a small phone box<b>.'
    ),



      CorrugatedBoxParcelSizeObj(
      parcelSize: 3,
      parcelSizeSubCategory: 'Small',
      parcelMaxLength: 7.18,
      parcelMaxWidth:7.18,
      parcelMaxHeight: 3.07,
      parcelMaxWeight:0.45,
      parcelMinPrice: 5.1,
      parcelReferenceObj: 'Medium sized phone box',
      parcelSizeReferenceString : 'Can fit a medium sized phone box',
      parcelSizeDescriptionString:'2.8 x 2.8 x 1.2" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit in a medium phone box<b>.'
    ),


    CorrugatedBoxParcelSizeObj(
      parcelSize: 4,
      parcelSizeSubCategory: 'Small',
      parcelMaxLength: 5.128,
      parcelMaxWidth:2.56,
      parcelMaxHeight: 1.2,
      parcelMaxWeight:0.35,
      parcelMinPrice: 5.1,
      parcelReferenceObj: 'Small phone box',
      parcelSizeReferenceString : 'Can fit in a small phone box',
      parcelSizeDescriptionString:'2.0 x 1 x 0.5" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit in a small phone box<b>.'
    ),


     CorrugatedBoxParcelSizeObj(
      parcelSize: 5,
      parcelSizeSubCategory: 'Medium',
      parcelMaxLength: 40.0,
      parcelMaxWidth:20.0,
      parcelMaxHeight: 20,
      parcelMaxWeight:1.5,
      parcelMinPrice: 6.1,
      parcelReferenceObj: 'Small stereo',
      parcelSizeReferenceString : 'Can fit in a small stereo',
      parcelSizeDescriptionString:'15.6 x 7.6 x 7.6" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit in a small stereo<b>.'
    ),

    CorrugatedBoxParcelSizeObj(
      parcelSize: 6,
      parcelSizeSubCategory: 'Medium',
      parcelMaxLength: 55.0,
      parcelMaxWidth:55.0,
      parcelMaxHeight: 55.0,
      parcelMaxWeight:1.5,
      parcelMinPrice: 6.60,
      parcelReferenceObj: 'Small shoe box',
      parcelSizeReferenceString : 'Can fit in a small shoe box',
      parcelSizeDescriptionString:'21.45 x 21.45 x 21.45" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit in a small shoe box<b>.'
    ),




    CorrugatedBoxParcelSizeObj(
      parcelSize: 7,
      parcelSizeSubCategory: 'Medium',
      parcelMaxLength: 75,
      parcelMaxWidth:75,
      parcelMaxHeight: 10,
      parcelMaxWeight:1.9,
      parcelMinPrice: 7.50,
      parcelReferenceObj: 'Medium Sized Pizza box',
      parcelSizeReferenceString : 'Can fit a medium sized pizza box',
       parcelSizeDescriptionString:'21.45 x 21.45 x 21.45" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit in a small shoe box<b>.'

    ),

  
  
    CorrugatedBoxParcelSizeObj(
      parcelSize: 8,
      parcelSizeSubCategory: 'Medium',
      parcelMaxLength: 80,
      parcelMaxWidth:25,
      parcelMaxHeight: 65,
      parcelMaxWeight:1.9,
      parcelMinPrice: 7.99,
      parcelReferenceObj: 'Small laptop',
      parcelSizeReferenceString : 'Can fit a small laptop',
       parcelSizeDescriptionString:'31.2 x 9.75 x 25.35" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit a small laptop<b>.'

    ),



    CorrugatedBoxParcelSizeObj(
      parcelSize: 9,
      parcelSizeSubCategory: 'Medium',
      parcelMaxLength: 20,
      parcelMaxWidth:20,
      parcelMaxHeight: 80,
      parcelMaxWeight:1.9,
      parcelMinPrice: 7.99,
      parcelReferenceObj: 'A tall wine box',
      parcelSizeReferenceString : 'Can fit a tall wine box',
      parcelSizeDescriptionString:'7.8 x 7.8 x 31.2" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit a tall wine box<b>.'
  ),


    CorrugatedBoxParcelSizeObj(
      parcelSize: 10,
      parcelSizeSubCategory: 'Medium',
      parcelMaxLength: 75,
      parcelMaxWidth:60,
      parcelMaxHeight: 70,
      parcelMaxWeight:1.9,
      parcelMinPrice: 8.99,
      parcelReferenceObj: 'Standard Size Shoe box',
      parcelSizeReferenceString : 'Can fit a shoe box',
      parcelSizeDescriptionString:'39 x 39 x 39" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit a shoe box<b>.'


    ),

   CorrugatedBoxParcelSizeObj(
      parcelSize: 11,
      parcelSizeSubCategory: 'Medium',
      parcelMaxLength: 75,
      parcelMaxWidth:60,
      parcelMaxHeight: 70,
      parcelMaxWeight:1.9,
      parcelMinPrice: 8.99,
      parcelReferenceObj: 'Standard Size Shoe box',
      parcelSizeReferenceString : 'Can fit a shoe box',
      parcelSizeDescriptionString:'39 x 39 x 39" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit a shoe box<b>.'


    ),

     CorrugatedBoxParcelSizeObj(
      parcelSize: 12,
      parcelSizeSubCategory: 'Medium',
      parcelMaxLength: 75,
      parcelMaxWidth:60,
      parcelMaxHeight: 80,
      parcelMaxWeight:1.9,
      parcelMinPrice: 8.99,
      parcelReferenceObj: 'A large toaster',
      parcelSizeReferenceString : 'Can fit a large toaster',
      parcelSizeDescriptionString:'29 x 23.4 x 31.2" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit a large toaster<b>.'

),

    CorrugatedBoxParcelSizeObj(
      parcelSize: 13,
      parcelSizeSubCategory: 'Medium',
      parcelMaxLength: 75,
      parcelMaxWidth:60,
      parcelMaxHeight: 120,
      parcelMaxWeight:1.9,
      parcelMinPrice: 8.99,
      parcelReferenceObj: 'A mini small sized fridge',
      parcelSizeReferenceString : 'Can fit mini small sized fridge',
      parcelSizeDescriptionString:'29.25 x 23.4 x 39.0" corrugated boxes.These are industry standard sizes. But by reference, <b>can mini small sized fridge<b>.'

),
    
   CorrugatedBoxParcelSizeObj(
      parcelSize:14,
      parcelSizeSubCategory: 'Large',
      parcelMaxLength: 100,
      parcelMaxWidth:100,
      parcelMaxHeight: 145,
      parcelMaxWeight:1.9,
      parcelMinPrice: 10.00,
      parcelReferenceObj: 'Small vacuum cleaner',
      parcelSizeReferenceString : 'Fit a small vacuum cleaner',
     parcelSizeDescriptionString:'39 x 39 x 54.6" corrugated boxes.These are industry standard sizes. But by reference, <b>can fit a small vacuum cleaner<b>.'


    ),

   CorrugatedBoxParcelSizeObj(
      parcelSize: 15,
      parcelSizeSubCategory: 'X-Large',
      parcelMaxLength: 300,
      parcelMaxWidth:150,
      parcelMaxHeight: 150,
      parcelMaxWeight:45,
      parcelMinPrice: 25.99,
      parcelReferenceObj: '2/3 of bale a of clothes',
      parcelSizeReferenceString : 'Can fit 2/3 of a bale of cloth',
     parcelSizeDescriptionString:'117 x 58.5 x 58.5" corrugated boxes. By reference, <b>can fit 2/3 of a bale of cloth<b>.'


    ),

    


    
  ];

 late  bool _showParcelSizesSelectionWidget;

  late bool _boxParcelSizeApproximation;

  late double _selectedParcelSizeBagReference;


@override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
     if(state == AppLifecycleState.resumed){
      GoogleMapController _controller = await  _googleMapController.future;
      if(_controller != null){
        _controller.setMapStyle(_mapStyle);
      }
     
        // Geolocator.isLocationServiceEnabled().then((value) {
          
        //   if(!value){

        //      setState(() {
        //        _widgetsFlag = WidgetsFlag.showLocationDisabledWidget;
        //  });
        //   }

        // });
      
       // TODO: if the delivery personel is currently busy or not re-render the map widget
     }
    
    super.didChangeAppLifecycleState(state);
  }


  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance!.addObserver(this);

    _userModel = register<UserModel>();
    _dropOffLocationSearchFieldController = TextEditingController();
    _pickupLocationFocusNode               = FocusNode();
    _dropOffLocationFocusNode               = FocusNode();
    _pickupLocationSearchFieldController = TextEditingController();

    _receiverNameTextEditingController = TextEditingController();
    _receiverNameFocusNode               = FocusNode();
    _receiverPhoneFocusNode               = FocusNode();
    _preferedCourierServiceFocusNode      = FocusNode();
    _receiverPhoneTextEditingController = TextEditingController();
    _preferedCourierServiceFieldController = TextEditingController();
    _courierServiceSearchTextEditingController = TextEditingController();
    _preferedCourierService = 'courier service';
    _selectedIntercityDestination = '';
    _selectedCourierService = '';
    _selectedParcelType = ParcelTypeObj(name: '',iconData: Feather.x,weightedValue: 0.0);
    _showBlurredOverlay = false;
    openDrawer         = false;
    _addedToFavorites = false;
    _showInterCityLearnMoreWidget = false;
    _showPlacesParentWidget = false;
    isAcquiringLocation = false;
    _addRecipientDetails = false;
    _enableInterCityDeliveryType = false;
    _showMultiplePhoneNumbersSelectionWidget = false;
    _showCourierServiceSearchWidget = false;
    _showIntercityDestinationSearchWidget = false;
    _showParcelTypeSelectionWidget = false;
    _showParcelSizesSelectionWidget = false;
    _boxParcelSizeApproximation = true;
    _selectedParcelSizeBagReference = 0.25;
    _firstMarkerLabelDataObj = MarkerLabelData();
    _secondMarkerLabelDataObj = MarkerLabelData();
    _thirdMarkerLabel  = MarkerLabelData();
    _panelController = PanelController();
    _googleMapController = Completer();
    _mapZoom = 15.5;
    locationsMarkers = {};
    _widgetFlag = WidgetsFlags.showAllActivities;
    polylines = {};
    location =  bgLocation.Location();
    _quantityOfParcels = 1;
    

   rootBundle.loadString(Constants.CUSTOM_MAP_STYLE_FILE_PATH).then((string) {
    _mapStyle = string;
  });
     

    setCustomMapPin();
  }




void setCustomMapPin() async {


      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 1.0),
      Constants.CURRENT_LOCATION_ICON);

      parcelMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 1.0,),'assets/images/cropped_parcel_icon.png');

     
      branchOfficeLocationIcon =  await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 1.0,),'assets/images/parcel_icon.png');
      
      destinationPlaceHolderIcon =  await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 1.0,),'assets/images/ destination_place_holder_icon.png');

     
   }



  // on map created method

 Future<void> _onMapCreated(GoogleMapController controller) async {


       

      Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
      LatLng latLng = lastKnownPosition != null ? LatLng(lastKnownPosition.latitude , lastKnownPosition.longitude) :  const LatLng(5.708696077300338,-0.2004465088248253);

    try{
               controller.setMapStyle(_mapStyle);
              
               _googleMapController.complete(controller);
             
             

            Position  position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
           
            latLng = LatLng(position.latitude,position.longitude);

        }on  LocationServiceDisabledException catch(e){
     
                UtilityWidgets.getToast('Please turn-on location services.',);

    }

    LocationPermission _permission = await Geolocator.checkPermission();
    if(_permission != LocationPermission.always){
      myPrint('Location services is not permitted outside the app');
    }else{
      myPrint('Location services is permitted outside the app'); 
    }
     
       if(locationsMarkers.isNotEmpty){

             locationsMarkers.clear();

         }


             locationsMarkers[const MarkerId('pickup_location_marker')] = Marker(

          markerId:const MarkerId('pickup_location_marker'),
          zIndex: 30.0,
         // anchor:const Offset(0.5,0.5),
          position:latLng,
          rotation: 158.00,
          infoWindow: InfoWindow(
            title: _userModel.getUser.fullname,
            snippet: 'rating: 1',
            
          ),
          icon: pinLocationIcon!
        );

     
   

    _lastKnownCameraPosition = CameraPosition(
      bearing: 158.00,
      target: latLng,
      tilt: 45.0,
      zoom: 13.595899200439453);

 

     
     controller.animateCamera(CameraUpdate.newCameraPosition(_lastKnownCameraPosition!));



      setState(() {
        
      });

      List<LatLng> positionsList = [
        LatLng(  5.710143957278533,
 -0.2006268873810768),

  

  LatLng(  5.709692913032447,
  -0.20044147968292234),



  LatLng( 5.709620852676227,
-0.20041231065988538),




  LatLng(  5.709398332907895,
-0.20033184438943863), 
 




 LatLng(   5.709215513003599,
-0.20023293793201447),



  LatLng( 5.709139782843683,
 -0.20023562014102939),




  LatLng( 5.70898465274916,
-0.20016957074403763),


  LatLng(  5.708482231122554,
 -0.1999499648809433),
        
      ];




  }



  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    if(_widgetFlag == WidgetsFlags.addParcelLocations){
      _pickupLocationFocusNode.requestFocus();
    }else if(_pickupLocationFocusNode.hasFocus){
      _pickupLocationFocusNode.unfocus();
    }

    
    return   BaseView<UserModel>(
      bottomInset: _showCourierServiceSearchWidget ? false : true,
      child: Stack(
              children: [
                SlidingUpPanel(
                  maxHeight:_widgetFlag == WidgetsFlags.addParcelBasicInfo  || _widgetFlag == WidgetsFlags.addParcelPaymentInfo || _widgetFlag == WidgetsFlags.selectDeliveryBikeType || _widgetFlag == WidgetsFlags.addParcelDetailsContind || _showParcelSizesSelectionWidget  ? _h * 0.75 : _h * 0.0 ,
                  minHeight:_widgetFlag == WidgetsFlags.addParcelBasicInfo || _widgetFlag == WidgetsFlags.addParcelDetailsContind ||  _widgetFlag == WidgetsFlags.addParcelPaymentInfo || _widgetFlag == WidgetsFlags.selectDeliveryBikeType || _showParcelSizesSelectionWidget  ? _h * 0.75 : _h * 0.0,
                  
                  borderRadius:  BorderRadius.circular(30.0),
                   parallaxEnabled: true,
                   parallaxOffset: .1,
                   color: Colors.transparent,
                   boxShadow:const [BoxShadow(color: Colors.transparent)],
                   controller: _panelController ,
                   
                   body:
                 
                      SizedBox(
                        width: _w,
                        height:_h ,
                        child: 
                                     Stack(
                                       alignment: Alignment.center,
                                       children: [
                            
                                           
                                              // Positioned(
                                              //   top: 0.0,
                                              //   child: 
                                             
                                            
                                            
                              Positioned(
                                bottom: 0.0,
                                child: SizedBox(
                                  width: _w,
                                  height: _h,
                                  child: 
                                      Animarker(
                                      rippleColor: logoMainColor.withOpacity(0.4),
                                      rippleRadius: 0.05,
                                    curve: Curves.easeInOut,
                                    mapId: _googleMapController.future.then<int>((value) => value.mapId), //Grab Google Map Id,
                                    zoom: _mapZoom,
                                    useRotation: false,
                                    shouldAnimateCamera:false ,
                                    markers:Set<Marker>.of(locationsMarkers.values),
                                    child: 
                                    GoogleMap(
                                      
                                      onMapCreated: _onMapCreated,
                                      myLocationEnabled: true,
                                      polylines: Set<Polyline>.of(polylines.values),
                                      myLocationButtonEnabled: false,
                                      mapType: MapType.normal ,
                                    
                                      onCameraIdle: ()async{
                                        myPrint('Number of location markers as they idle ${locationsMarkers.length}');
                                            if(_widgetFlag == WidgetsFlags.previewParcelTransitRoute){
                                            
            GoogleMapController _controller = await _googleMapController.future;
           RenderObject? renderObj = _firstMarkerLableKey.currentContext!.findRenderObject();
          
          double _height = renderObj!.paintBounds.size.height;
          Marker marker = locationsMarkers[const MarkerId('pickup_location_marker')]!;

           ScreenCoordinate _screenCoordinate = await _controller.getScreenCoordinate(marker.position);

           double devicePixelRatio =   MediaQuery.of(context).devicePixelRatio;
          _firstMarkerLabelDataObj =   MarkerLabelData(markerLabelXCoordinate:(_screenCoordinate.x / devicePixelRatio) - 25,markerLabelYCoordinate: (_screenCoordinate.y / devicePixelRatio) - (_height + 15),markerLabelTitle: _firstMarkerLabelDataObj.markerLabelTitle,markerLabelDesc: _firstMarkerLabelDataObj.markerLabelDesc);
           
   

           renderObj = _secondMarkerLableKey.currentContext!.findRenderObject();
          
           _height = renderObj!.paintBounds.size.height;
            marker = locationsMarkers[const MarkerId('destination_location_marker')]!;
          
           _screenCoordinate = await _controller.getScreenCoordinate(marker.position);

            devicePixelRatio =   MediaQuery.of(context).devicePixelRatio;
         _secondMarkerLabelDataObj =   MarkerLabelData(markerLabelXCoordinate:(_screenCoordinate.x / devicePixelRatio) - 25,markerLabelYCoordinate: (_screenCoordinate.y / devicePixelRatio) - (_height + 15),markerLabelTitle:_secondMarkerLabelDataObj.markerLabelTitle,markerLabelDesc:_secondMarkerLabelDataObj.markerLabelDesc);

      setState(() {
        
      });

                     }           
            //            await Future.delayed( Duration(seconds:1 ), );
            //              setState(() {
            //               if(!isSearchBarVisible){
            //                 isSearchBarVisible = true;
            //               }
            //                 if(selectedLocationAddr.isNotEmpty){
            //                  return;
            //             }
            //                 if(!showLocationsSuggestions && locationsWidget.isNotEmpty){
            //                 showLocationsSuggestions = true;
            //               }
            //             });

            //     var lat;
            //     var lng;

               
            //     if(lastKnownCameraPosition != null){
            //        lng = lastKnownCameraPosition!.target.longitude;
            //       lat = lastKnownCameraPosition!.target.latitude;
            //     }

            //     if((lat == lastFetchedLocationLat && lastFetchedLocationLng == lng) || lat == null || lng == null){
            //     return;
            //     }
            //    setState(()=>isAcquiringLocation = true);

            //  await chooseLocationWithLatLng(lat,lng);
            //  setState((){
            //    isAcquiringLocation = false;
            //    lastFetchedLocationLat = lat;
            //    lastFetchedLocationLng = lng;
            //  });
            //  GoogleMapController controller = await _controller.future;
            //    //setState(() { selectedLocationLat = position.latitude; selectedLocationLng = position.longitude;});
            //    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            //      bearing: 23.047945022583008,
            //      target: LatLng(lat,lng),
            //     tilt: 0.0,
            //      zoom: 16.595899200439453))).then((value) => null).whenComplete(() => ) ;
           
          

                  
                                                      
                     
                                                      },
                                      onTap: (LatLng latLng){
                                    

                                      if(_firstLatLng == null){
                                        _firstLatLng  = latLng;
                                        myPrint('first pont registerd');
                                      }else if(_secondLatLng == null){
                                          
                                        _secondLatLng = latLng;
                                        myPrint('second point registerd');
                                      }else{
                                        LatLngBounds latLngBounds = LatLngBounds(southwest: _secondLatLng,northeast: _firstLatLng);

                                    bool isbetweenThem = latLngBounds.contains(latLng);

                                    if(isbetweenThem){
                                      myPrint('it is between the first and second point');
                                    }else{
                                      myPrint('It is not between the first and second point.');
                                    }
                                    _secondLatLng = null;
                                    _firstLatLng = null;
                                      }
                                   setState(() {});
                                             },
                                  compassEnabled: false,
                                  zoomControlsEnabled: false,
                                  initialCameraPosition:const CameraPosition(
                                      target: LatLng(5.6778757, -0.0174085),
                                      bearing: 120.0,
                                      zoom:15.0,
                                  ),
                                                                                    
                                                                                  ),
                                                                              ),
                                                                        
                                                ),
                                              ),

                    
                              Visibility(
                                visible: _widgetFlag == WidgetsFlags.pickLocationOnMap,
                                child: SizedBox(
                                width: 55,
                                height: 55.0,
                                child: Image.asset(Constants.CROPPED_PARCEL_ICON,fit: BoxFit.cover))),
                    
                    // locations suggestions widget
                    AnimatedPositioned(
                  top: _showPlacesParentWidget ? 180.0: 60,
                      
                          left:12.0 ,
                          duration:const Duration(milliseconds: 900),
                          curve: Curves.easeInOut,
                          child: AnimatedOpacity(
                          opacity:_showPlacesParentWidget ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 900),
                            curve: Curves.easeInOut,
                            child: AnimatedContainer(
                            duration: Duration(milliseconds: 900),
                            curve: Curves.easeInOut,
                            width: _w * 0.95 ,
                            height:_showPlacesParentWidget ? _h * 0.53 : 0.0,
                    margin:const EdgeInsets.only(top: 30.0),
                  padding: EdgeInsets.symmetric(horizontal: 13.0,vertical: 10.0),
                  child:
              
                    Material(
                      elevation: 30.0,
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


            // add locations cancel icon
            cancelIconWidget((){
              setState(() {
                _widgetFlag = WidgetsFlags.sendParcelActivity;
              });
            },showFlag: _widgetFlag == WidgetsFlags.addParcelLocations,topDistanceWhenShowed: 40.0),

             // add receipient details back icon
            cancelIconWidget((){
              setState(() {
                _widgetFlag = WidgetsFlags.addParcelLocations;
              });
            },showFlag: _widgetFlag == WidgetsFlags.addReceipientDetails,topDistanceWhenShowed: 40.0,icon:Transform.rotate(angle:  3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left  , size: 30.0,))),

            
            // add confirm delivery locations back button
            cancelIconWidget(()async{
             
                      
                // get the current location of the user
                bgLocation.LocationData _locationData = await location.getLocation();
                
                      

                // remove all the polylines
                 polylines.clear();


                  // remove all the marker labels
                  removeMarkerLabels();

                  // move the pickup marker to the current location of the user    
                  gotoLocation(latLng: _locationData.latitude == null || _locationData.longitude == null ? Constants.DEFAULT_LATLNG : LatLng(_locationData.latitude!,_locationData.longitude!),bearing:_locationData.heading != null ? _locationData.heading! : 158.0,markerID: 'pickup_location_marker',);

                _widgetFlag = WidgetsFlags.addReceipientDetails;
             
                
                // remove the destination marker  
                  clearDestinationMarker();

                  setState(() {
                    
                  });
                   
                 

                         

            },showFlag: _widgetFlag == WidgetsFlags.previewParcelTransitRoute,topDistanceWhenShowed: 40.0,icon:Transform.rotate(angle:  3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left  , size: 30.0,))),




            // parcel delivery type
            AnimatedPositioned(
            duration:const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            top: _widgetFlag == WidgetsFlags.addParcelLocations && !_addRecipientDetails ? 40.0 : -_h,
            right: 10.0,
            child:   Visibility(
              visible: false,
              child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: _w * 0.4,
                            height:_h * 0.09,
                            margin:const EdgeInsets.only(right: 10.0),
                            padding:const EdgeInsets.only(left: 10.0,top: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                            ),
                            child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                         width: _w * 0.4,
                        child: Row(children: [
                
                        
                              const Text("it's inter-city",style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.bold)),
            
                              const Expanded(child: SizedBox()),
                
                              InkWell(
                                    onTap: (){
                                      setState(() => _enableInterCityDeliveryType  = !_enableInterCityDeliveryType);
                                    },
                                    child: AnimatedContainer(
                                      duration:const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                      padding:const EdgeInsets.all(1.5),
                                      width: 50.0,
                                      height: 25.0,
                                      margin:const EdgeInsets.only(left: 5.0),
                                      alignment: _enableInterCityDeliveryType ? Alignment.centerRight: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        color: _enableInterCityDeliveryType ?  logoMainColor :const Color(0xFFf1f0f5) ,
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child:  Container(
                                          
                                        width: 24.0,
                                        height: 24.0,
                                        decoration:const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          
                                        ),
                                      ),
                
                                      ),
                                  ),
                          
                
                        ],),
                      ),
                
                    const Expanded(child: SizedBox()),
                    InkWell(
                        onTap: (){
                        setState(() {
                          _showInterCityLearnMoreWidget = true;
                        });
                        },
                      child:const Text('Learn more ?',style: TextStyle(color: Colors.lightBlueAccent, fontSize: 12.5,fontWeight: FontWeight.bold))),
                
                      const Expanded(child: SizedBox()),
                  
                    ],
                  )),),
            ),
              ),
        
        
                   

                   

            // widget to add recipient details
             AnimatedPositioned(
            top: 50.0 ,
            right:_widgetFlag == WidgetsFlags.addReceipientDetails ? -10.0 : -_h,
            child: SizedBox(
              width: _w,
              height: _h,
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                   Container(
                     width: _w,
                     alignment:Alignment.center,
                     child: const   Text('Recipient Details', style: TextStyle( fontSize: 13.5,fontWeight: FontWeight.bold))),

                   const SizedBox(height: 25.0,),
                        Material(
                          color: white,
                          elevation: 10,
                          borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: _w * 0.95,
                           height: _h * 0.16,
                         
                           decoration: BoxDecoration(
                               color: white,
                               borderRadius: BorderRadius.circular(10.0),
                           ),
                        
                          padding:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.5),
                          child: 
                          Row(children: [
                            Column(
                              children: [
                               const Icon(AntDesign.user,color: logoMainColor,size: 18),
                                 SizedBox(width:1.5,height:_w * 0.15),
                                const Icon(SimpleLineIcons.phone,color: logoMainColor,size: 18),
                              ],
                            ),

                          const  SizedBox(width: 10.0,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               
                               SizedBox(
                               width: _w * 0.68,
                                 child: Row(
                                   children: [
                                     InkWell(
                                       onTap: (){
                                        if(!_receiverPhoneFocusNode.hasFocus){
                                      _receiverPhoneFocusNode.requestFocus();
                                        }
                                       },
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text('receiver phone',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 10.5,fontWeight: FontWeight.bold)),
                                                                  
                            const    SizedBox(height: 5.0),
                                              
                      Container(
                      margin:const EdgeInsets.only(left: 10.0),
                        width: _w * 0.45,
                      padding:const EdgeInsets.only(right: 15.0),
                        child: TextField(
                      
                        controller: _receiverPhoneTextEditingController,
                  
                      textAlign: TextAlign.left,
                        style: const TextStyle( fontSize: 13.5,fontWeight: FontWeight.bold),
                        focusNode: _receiverPhoneFocusNode,                
                        cursorColor: warmPrimaryColor,
                        decoration: InputDecoration.collapsed(
                    hintText: 'receiver phone',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 13,
                    ),
                                                  ),
                    onChanged: (String receiverPhone){
                  
                    },
                      
                            ),
                                          ),
                                               
                                       
                                         ],
                                       ),
                                     ),
                               const Expanded(child: SizedBox()),
                                 InkWell(
                                   onTap: ()async{
                              Map<String,dynamic> results = await   getUserContact();

                                  if(results['result']){

                                    if(results['data'] != null){
                                   

                                          Contact contact = results['data'];
                                         
                                         
                                      if(contact.phones.isNotEmpty){
                                                  

                                              if(contact.phones.length  == 1 ){
                                                    Phone phone = contact.phones.first;
                                            if(phone.number.length < 10 || phone.normalizedNumber.isEmpty || phone.normalizedNumber.length < 10){
                                              
                                                  UtilityWidgets.refinedInformationDialog(context: context, onTap: (){
                                                      Navigator.pop(context);
                                                    },title: 'Contact Error',desc: 'The phone number ( ${phone.normalizedNumber} ) is invalid.',);
                                                  return;
                                              
                                            }
                                              
                                                if(!isNumeric(phone.normalizedNumber.substring(phone.normalizedNumber.length - 9))){
                                                      
                                                    UtilityWidgets.refinedInformationDialog(context: context, onTap: (){
                                                      Navigator.pop(context);
                                                    },title: 'Contacts Warning',desc: 'Please the select contact may have invalid characters attached.',);
                                                  return ;
                                                }

                                                 if(contact.name.first.isNotEmpty || contact.name.middle.isNotEmpty || contact.name.last.isNotEmpty ){
                                              _receiverNameTextEditingController.text = '${contact.name.first} ${contact.name.middle} ${contact.name.last}';
                                              myPrint('${contact.name.first} ${contact.name.middle} ${contact.name.last}');
                                             }
                                                _receiverPhoneTextEditingController.text = phone.normalizedNumber;
                                            



                                              }else{
                                                  _receipientContact = contact;
                                                _showMultiplePhoneNumbersSelectionWidget = true;
                                              }

                                           setState(() {
                                              
                                            });

                                              return;
                                      }
                                      


                                      UtilityWidgets.refinedInformationDialog(context: context, onTap: (){Navigator.pop(context);},title: 'Contact Error',desc: 'Sorry this contact does not contain any phone numbers.');
                                    
                                    }

                                 
                                  }else{
                                    UtilityWidgets.refinedInformationDialog(context: context, onTap: (){Navigator.pop(context);},title: 'Contact Error',desc: results['desc']);
                                  }
                                   }
                                   ,child: const Icon(AntDesign.contacts,color: logoMainColor,size: 18)),     
                                   ],
                                 ),
                               ),
                             
                          

                            

                            Container(margin:const EdgeInsets.symmetric(vertical: 7.5),width: _w * 0.67,child: Divider(thickness: 0.5, color: customFadedColor.withOpacity(0.3),)),

                             InkWell(
                               onTap: (){
                                 if(!_pickupLocationFocusNode.hasFocus){
                                    _pickupLocationFocusNode.requestFocus();
                                 }
                               },
                               child: SizedBox(
                                   width: _w * 0.68,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('Receiver Name',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 10.5,fontWeight: FontWeight.bold)),
                             
                                         const    SizedBox(height: 5.0),
                             
                               Container(
                              margin:const EdgeInsets.only(left: 10.0),
                                width: _w * 0.55,
                               padding:const EdgeInsets.only(right: 15.0),
                                child: TextField(
                               
                                controller: _receiverNameTextEditingController,
                                                         
                               textAlign: TextAlign.left,
                                style: const TextStyle( fontSize: 13.5,fontWeight: FontWeight.bold),
                                focusNode: _receiverNameFocusNode,                    
                                cursorColor: warmPrimaryColor,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'receiver name',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 13,
                                  ),
                                ),
                              onChanged: (String receiverName){

                              },                    
                                                         ),
                                                       ),
                                         
                                 
                                   ],
                                 ),
                               ),
                             ),
                          
                        

                            ],),

                          const  SizedBox(width: 20.0),

                          Container(margin:const EdgeInsets.only(bottom: 15.0),padding:const EdgeInsets.all(4.0),decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF0091FF).withOpacity(0.05)),child: const Icon(MaterialCommunityIcons.details, color: Color(0xFF0091FF),size: 15.0))

                          ],),

                        ),),

         
                      ]
                    ),
            )
             , duration:const Duration(milliseconds: 700),curve: Curves.easeInOut,),




            // add parcel pickup and destination addresses
            AnimatedPositioned(
            top: _widgetFlag == WidgetsFlags.addParcelLocations ? 30.0 : -_h,
            left:_addRecipientDetails ? -_h : 10.0,
            child:
             SizedBox(
              width: _w,
              height: _h,
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                  

                   const SizedBox(height: 45.0,),
                        Material(
                          color: white,
                          elevation: 10,
                          borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: _w * 0.95,
                           height: _h * 0.18,
                         
                           decoration: BoxDecoration(
                               color: white,
                               borderRadius: BorderRadius.circular(10.0),
                           ),
                          padding:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.5),
                          child: Row(children: [
                            Column(
                              children: [
                                Container(decoration: BoxDecoration(color: white,shape: BoxShape.circle,border: Border.all(width: 6.0, color: logoMainColor), ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                 Container(width:1.5,height:_w * 0.15,decoration: BoxDecoration(color: black.withOpacity(0.8),borderRadius: BorderRadius.circular(4.0)),),
                                 Container(decoration: BoxDecoration(shape: BoxShape.circle,color: white,border: Border.all(width: 6.0, color: black) ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                              ],
                            ),

                          const  SizedBox(width: 10.0,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            

                             InkWell(
                               onTap: (){
                                 if(!_pickupLocationFocusNode.hasFocus){
                                    _pickupLocationFocusNode.requestFocus();
                                 }
                               },
                               child: SizedBox(
                                  width: _w * 0.55,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('Pickup',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 10.5,fontWeight: FontWeight.bold)),
                             
                                         const    SizedBox(height: 5.0),
                             
                               Container(
                              margin:const EdgeInsets.only(left: 10.0),
                                width: _w * 0.55,
                               padding:const EdgeInsets.only(right: 15.0),
                                child: TextField(
                               
                                controller: _pickupLocationSearchFieldController,
                                                         
                               textAlign: TextAlign.left,
                                style: const TextStyle( fontSize: 13.5,fontWeight: FontWeight.bold),
                                focusNode: _pickupLocationFocusNode,                    
                                cursorColor: warmPrimaryColor,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'pick-up',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 13,
                                  ),
                                ),
                              onChanged: handlePlacesSearch,                    
                                                         ),
                                                       ),
                                         
                                 
                                   ],
                                 ),
                               ),
                             ),
                          

                            Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.67,child: Divider(thickness: 0.5, color: customFadedColor.withOpacity(0.3),)),

                             InkWell(
                               onTap: (){
                                 if(!_dropOffLocationFocusNode.hasFocus){
                                   _dropOffLocationFocusNode.requestFocus();
                                 }
                               },
                               child: SizedBox(
                                  width: _w * 0.55,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('Drop Off / destination',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 10.5,fontWeight: FontWeight.bold)),
                             
                                         const    SizedBox(height: 5.0),
                             
                               Container(
                              margin:const EdgeInsets.only(left: 10.0),
                                width: _w * 0.55,
                               padding:const EdgeInsets.only(right: 15.0),
                                child: TextField(
                               
                                controller: _dropOffLocationSearchFieldController,
                                                         
                               textAlign: TextAlign.left,
                                style: const TextStyle( fontSize: 13.5,fontWeight: FontWeight.bold),
                                focusNode: _dropOffLocationFocusNode,                
                                cursorColor: warmPrimaryColor,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'drop off',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 13,
                                  ),
                                ),
                                  onChanged: handlePlacesSearch,
                                    
                                         ),
                                                       ),
                                         
                                 
                                   ],
                                 ),
                               ),
                             ),
                          
                        
                             Visibility(visible: false,child: Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.67,child: Divider(thickness: 0.5, color: customFadedColor.withOpacity(0.3),))),

                             Visibility(
                               visible: false,
                               child: InkWell(
                                 onTap: (){
                                   if(!_preferedCourierServiceFocusNode.hasFocus){
                                     _preferedCourierServiceFocusNode.requestFocus();
                                   }
                                 },
                                 child: SizedBox(
                                    width: _w * 0.55,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text('Courier Service',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 10.5,fontWeight: FontWeight.bold)),
                               
                                           const    SizedBox(height: 5.0),
                               
                                 Container(
                                margin:const EdgeInsets.only(left: 10.0),
                                  width: _w * 0.55,
                                 padding:const EdgeInsets.only(right: 15.0),
                                  child: TextField(
                                 
                                  controller: _preferedCourierServiceFieldController,
                                                           
                                 textAlign: TextAlign.left,
                                  style: const TextStyle( fontSize: 13.5,fontWeight: FontWeight.bold),
                                  focusNode: _preferedCourierServiceFocusNode,                
                                  cursorColor: warmPrimaryColor,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Courier service',
                                    hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 13,
                                    ),
                                  ),
                                    onChanged: handleCourierServiceSearch,
                                      
                                           ),
                                                         ),
                                           
                                   
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                          
                        


                            ],),

                          const  SizedBox(width: 20.0),

                          InkWell(
                            onTap: ()async{
                            
                              
                               gotoLocation(latLng:const LatLng(Constants.XTRMXY,Constants.XTRMXX) ,bearing: 158.0,markerID: 'pickup_location_marker',showAnimatedCamera: false,);

                              await Future.delayed(const Duration(milliseconds:100));
                              _widgetFlag = WidgetsFlags.pickLocationOnMap;
                             
                             // _mapZoom = 18.2;
                              setState(() {
                               
                              });
                            },
                            child: Container(margin:const EdgeInsets.only(bottom: 15.0),padding:const EdgeInsets.all(4.0),decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF0091FF).withOpacity(0.05)),child:
                            
                            const Icon(Ionicons.ios_location, color: Color(0xFF0091FF),size: 15.0)),
                          )

                          ],),

                        ),),

                       
                      ]
                    ),
            )
            
            
             , duration:const Duration(milliseconds: 700),curve: Curves.easeInOut,),


            // pick location on map widget
            AnimatedPositioned(
                  top: _widgetFlag == WidgetsFlags.pickLocationOnMap ? 30.0 : -_h,
                  left: 10.0,
                 child: 
                 Column(
                   children: [
                     Material(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                              width: _w * 0.95,
                              height: 60,
                              padding:const EdgeInsets.symmetric(vertical: 7.5,horizontal: 15.0),
                              decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                children:[
                                InkWell(
                                  onTap: ()async{
                                bgLocation.LocationData _locationData = await location.getLocation();
                    
                  // move the marker back to the current location of the user
                  // gotoLocation(
                  //   latLng: _locationData.latitude == null || _locationData.longitude == null ? Constants.DEFAULT_LATLNG : LatLng(_locationData.latitude!,_locationData.longitude!),
                  //   bearing:_locationData.heading != null ? _locationData.heading! : 158.0,markerID: 'pickup_location_marker',);
                  gotoLocation(
                    latLng:  Constants.DEFAULT_LATLNG ,
                    bearing: 158.0,
                    markerID: 'pickup_location_marker',
                    );

                         
                              await Future.delayed(const Duration(milliseconds:100));
                                _widgetFlag = WidgetsFlags.addParcelLocations;
                                    setState(() {
                                      
                                    });
                                
                                
                                  }
                                  ,child: const  Icon(Feather.arrow_left,size: 30,)),
                                  Container(
                                    width: _w * 0.7,
                                    height: 50,
                                    alignment: Alignment.center,
                                    margin:const EdgeInsets.symmetric(horizontal:10.0 ),
                                    padding:const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color: customFadedColor.withOpacity(0.1)
                                    ),
                                    child:const Text('Picked location',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold)),
                                  ),
                                ]
                              ),
               
                              )
                            ),
                   ],
                 ),
                duration:const Duration(milliseconds: 700),curve: Curves.easeInOut,
               ),
                 
                 

            // Continue button for sending new Parcel 
             AnimatedPositioned(
            bottom:  _widgetFlag == WidgetsFlags.addParcelLocations || _widgetFlag == WidgetsFlags.previewParcelTransitRoute || _widgetFlag == WidgetsFlags.addReceipientDetails  || _widgetFlag == WidgetsFlags.pickLocationOnMap ? 40.0 : -_h,
            left: 20.0,
            duration:const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            child:  Material(
              elevation: 15.0,
            borderRadius: BorderRadius.circular(15.0),
            child: InkWell(
                onTap: (){


                    //    if(){

                    //  }

                  if(_widgetFlag == WidgetsFlags.addReceipientDetails){

                      setState(() {
                        _widgetFlag = WidgetsFlags.addParcelBasicInfo;
                      });

                     

                    return;
                    // preview the transit of the parcel first
                    previewParcelTransitRoute(
                      polylinesData:[
                        PolylineDataModel(polylineID: 'pick_up_to_main_station_location', polylineStartLatLng:const LatLng(5.7125136018003735, -0.19713230431079865), polylineEndLatLng:const LatLng(5.56846105225629, -0.21940503269433972),),
                      
                        ],
                      markersData: [
                          MarkerData(markerStringID: 'pickup_location_marker', markerLatLng: const LatLng(5.7125136018003735, -0.19713230431079865), infoWindowTitle: 'Yussif Muniru', inforWindowDesc: '0241792877', icon: pinLocationIcon!),

                          MarkerData(markerStringID: 'destination_location_marker', markerLatLng: const LatLng(5.56846105225629, -0.21940503269433972), infoWindowTitle: 'Branch Office Location', inforWindowDesc: '0241792877', icon: parcelMarkerIcon!),

                       
                          
                        ],
                        markerLabelsData: [

                           MarkerLabelData(markerLabelTitle:'Me',markerLabelDesc: 'Maglo Mini Mart'),
                           MarkerLabelData(markerLabelTitle:'Vipex Accra Branch Office',markerLabelDesc: 'Kwame Nkrumah Circle'),
                          



                        ]
                        );
                     
                    
                      
                
 
                  }


                    if(_widgetFlag == WidgetsFlags.addParcelLocations){
                      setState(() {
                          _widgetFlag = WidgetsFlags.addReceipientDetails;
                      });
                    }

                    if(_widgetFlag == WidgetsFlags.pickLocationOnMap){
                      // handle Picking the location on map
                      handlePickLocationOnMap();
                    }

                    
                
                  
                }
              ,child: Container(width: _w * 0.9,padding:const EdgeInsets.symmetric(vertical: 20.0),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child: Text(continueButtonText(_widgetFlag) ,style: const TextStyle(color: white, fontSize: 12.5, fontWeight: FontWeight.bold)),)),
          ),
            
            ),

            // send Parcel Activity widget
           AnimatedPositioned(
            top:_widgetFlag == WidgetsFlags.sendParcelActivity ? 30.0 : -_h,
            left: 20.0,
            duration:const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            child: InkWell(onTap: (){

           Marker marker    =   locationsMarkers[const MarkerId('pickup_location_marker')]!;
                      
           locationsMarkers[const MarkerId('pickup_location_marker')] = Marker(

          markerId:const MarkerId('pickup_location_marker'),
          zIndex: 30.0,
         // anchor:const Offset(0.5,0.5),
          position:marker.position,
          rotation: 158.00,
          infoWindow: InfoWindow(
            title: _userModel.getUser.fullname,
            snippet: 'rating: 1',
            
          ),
          icon: pinLocationIcon!
        );
        
              setState(() {
                _widgetFlag = WidgetsFlags.showAllActivities;
              });
            },child: Material(elevation: 15.0,shape:const CircleBorder(),child: Container(width: 50,height: 50,decoration:const BoxDecoration(shape: BoxShape.circle,),child:Transform.rotate(angle:3.14 * 0.25,child:const Icon(MaterialCommunityIcons.arrow_bottom_left,size: 23.0))))), 
            ),
           
           
           AnimatedPositioned(
            bottom:_widgetFlag == WidgetsFlags.sendParcelActivity ? 10.0 : -_h,
            duration:const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            child:    Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          const Padding(padding: EdgeInsets.only(left: 20.0),child:    Text('Parcels',style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,color: logoMainColor))),
              Container(
                width: _w,
                height: _h * 0.23,
                color: Colors.transparent,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [

                      const  SizedBox(width: 20.0,),
                      getActivityTypeWidget('New Parcel','Put your destination',()async{
                       

                    _widgetFlag = WidgetsFlags.addParcelLocations;      
        

      
                    setState(() {
                       
                        });

                      },MaterialCommunityIcons.source_commit_start_next_local,isActive: true), 

                      false ? noRecentParcelsWidget() : recentParcelsWidget((){}),
                       recentParcelsWidget((){}),   
                                        
                    
                  ]
                ),
              ),
            ],
          ) 
        
        ),
                
                
             

          // show all activities widget                                  
          AnimatedPositioned(
            bottom:_widgetFlag == WidgetsFlags.showAllActivities ? 10.0 : -_h,
            duration:const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            child:    Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          const Padding(padding: EdgeInsets.only(left: 20.0),child:    Text('Activities',style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,color: logoMainColor))),
              Container(
                width: _w,
                height: _h * 0.23,
                color: Colors.transparent,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [

                      const  SizedBox(width: 20.0,),
                      getActivityTypeWidget('Send Parcel','To any destination',(){
                           Marker marker    =   locationsMarkers[const MarkerId('pickup_location_marker')]!;
                      
           locationsMarkers[const MarkerId('pickup_location_marker')] = Marker(

          markerId:const MarkerId('pickup_location_marker'),
          zIndex: 30.0,
         // anchor:const Offset(0.5,0.5),
          position:marker.position,
          rotation: 158.00,
          infoWindow: InfoWindow(
            title: _userModel.getUser.fullname,
            snippet: 'rating: 1',
            
          ),
          icon: parcelMarkerIcon!
        );
        
                        setState(() {
                         _widgetFlag = WidgetsFlags.sendParcelActivity;    
                        });
                     
                      },MaterialCommunityIcons.source_commit_start_next_local,isActive: true), 
                      getActivityTypeWidget('Ticketing','coming soon',(){},Fontisto.bus_ticket,),
                      getActivityTypeWidget('Trotro','coming soon',(){},MaterialCommunityIcons.bus_stop,),    
                      getActivityTypeWidget('Okada','coming soon',(){},MaterialIcons.sports_motorsports,),  
                    
                  ]
                ),
              ),
            ],
          ) 
        
                                               ),
                
                
                
                
                
          AnimatedPositioned(
                   top: _widgetFlag == WidgetsFlags.showAllActivities ? 0.0 : -_h,
                   duration:const Duration(milliseconds: 700),
               child: Material(
                  elevation: 7.0,
              
                 child: Container(
                        width: _w,
                        height: _h * 0.15,
                        color: customerWhiteColor,
                        padding:const EdgeInsets.only(top: 45.0,left: 20.0,right: 20.0),
                        child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text('Hey John!',style: TextStyle(fontSize: 17.5,fontWeight: FontWeight.bold,)),
                            const  SizedBox(height: 7.0,),
                              Text('What would you like to do today ?',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color:customFadedColor )),
                                                            
                              ],
                              ),
               
                  const Expanded(child: SizedBox(),),
                    Material(
                     elevation: 10.0,
                     borderRadius: BorderRadius.circular(15.0),
                       color: white,
                     child: InkWell(
                       onTap: (){
                       setState(() {
                         openDrawer = true;
                       });
                       },
                       child: Container(
                       width: 35,
                       height:35,
                       padding:const EdgeInsets.only(right:9.0),
                     // alignment: Alignment.center,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15.0),
                           color: white,
                       ),
                                          
                    child:true ? const Icon(MaterialIcons.sort, size: 17) :  Column(
                      
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children:const [
                           SizedBox(width: 5.0,height: 7.0,child: Icon(Entypo.dot_single,size: 17.0)),
                           SizedBox(height: 1.0),
                             SizedBox(height: 7.0,width: 5.0,child: Icon(Entypo.dots_two_horizontal,size: 17.0)), 
                             SizedBox(width:0.0,height: 1.0),
                  SizedBox(width: 5.0,height: 7.0,child: Icon(Entypo.dots_three_horizontal,size: 17.0)),
                       
                    ],
                                                                                        )),
                                                                                       ),),
                                                                                     
                                                                                                     
                                                                
                                                        ]
                                                                                                       ),
                                                                                                ),
               ),
                                                   ),
                                                
                                              //), 
    
                                  
          Positioned(
                                       left: 15.0,
                                       top: 50.0,
                                       child:   Visibility(
                                         visible: false,
                                         child: InkWell(
                                           onTap: (){
                                              setState(() {
                                                openDrawer = !openDrawer;
                                              });
                                           },
                                            child: Container(
                                           width: _w * 0.13,
                                           height: _w * 0.13,
                                           decoration: const BoxDecoration(shape: BoxShape.circle),
                                                                          child:
                                          const Material(
                                             elevation: 15.0,
                                              shape: CircleBorder(),
                                             color:darkColor,child: Icon(MaterialCommunityIcons.dots_vertical,size: 18.0,color: logoMainColor ))),
                                         ),
                                       ),
                           ),
         
         
                            
          Positioned(
                                       right: 15.0,
                                       top: 60,
                                       child:   Visibility(
                                         visible: _widgetFlag == WidgetsFlags.showUserOfflineWidget,
                                         child: InkWell(
                                           onTap: ()async{
                                   setState((){_showBlurredOverlay = true;});
         
    
    
                                     },
                                          child: 
                                           Material(
                                             elevation: 15.0,
                                             borderRadius: BorderRadius.circular(23.0),
                                                                   
                                             color: Colors.white,child: Container(
                                                 width: _w * 0.3,
                                           height: _w * 0.1,
                                           alignment: Alignment.center,
                                           padding:const EdgeInsets.only(left: 10.0),
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(23.0)
                                           ),
                                               child: Row(
                                                
                                                 children: [
                                       
                                                   Container(
                                                     width: 35,
                                                     height:16 ,
                                                     alignment: true ? Alignment.centerLeft : Alignment.centerRight,
                                                   
                                                      margin:const EdgeInsets.only(right:5.0),
                                                     decoration: BoxDecoration(
                                                       color: logoMainColor,
                                                      borderRadius: BorderRadius.circular(15.0),
                                                      ),
                                                     child: Container(
                                                       width:15.0,
                                                       height: 15.0,
                                                       decoration: const BoxDecoration(
                                                       color: white,
                                                         shape: BoxShape.circle
                                                       ),
                                                     ),
                                                     ),
                                                   
                                                   Text(true ? 'Offline' : 'Online',style: const TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold)),
                                                 ],
                                               ))),
                                         ),
                                       ),
                           ),
                            

              
           ],
                       )
                                   
                                   
                                
                      ),
                   
                                                  
                   panelBuilder: (sc) =>
                     Stack(
                       fit: StackFit.loose,
                       clipBehavior: Clip.none,
                       children: [
                      
                      parcelDetailsBackgroundWidget(),
                      firstParcelDetailsStepWidget(),
                      addParcelDetailsContind(),
                    
                      parcelPaymentDetailsStepWidget(),
                      requestDeliveryWidget(),
                      
                       ],
                     ),
                   ),
              
               
               
         Positioned.fill(child:PlayAnimation<double>(
                 tween: Tween(begin: 0.0, end:1.0),
                  builder: (context, child,value) {
                    return Visibility(visible: openDrawer || _showInterCityLearnMoreWidget || _showCourierServiceSearchWidget || _showIntercityDestinationSearchWidget || _showParcelTypeSelectionWidget || _showParcelSizesSelectionWidget, child: InkWell(onTap: (){
                                    setState(() {
                                      openDrawer = false;
                                    });
                                  },child: Container(color: black.withOpacity(0.5 * value))));
                  }
                )),
                        
                        
                                  
         
          Positioned.fill(
                            child: CustomAnimation<double>(
              tween: Tween(begin: 0.0,end: 1.0),
              control: _showBlurredOverlay ? CustomAnimationControl.play : CustomAnimationControl.playReverse,
              duration:const Duration(milliseconds:500),
              builder: (context, child, value) {
                
                return  Visibility(
               visible: !(value < 5.0) ,
               child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: value,
                sigmaY: value,
                
              ),
                          child: Container(
                              color: Colors.white.withOpacity(0.05),
                            ),
               ),);
                                      }
                                    ),
             
           ),
         
          learnMoreWidgetOfIntercityDelivery(),
              
                      
          AnimatedPositioned(
                  duration:const Duration(milliseconds: 700) ,
                  curve: Curves.ease,
                  left:openDrawer ? 0.0 : -_w,
                  top:20.0,
                  child: Container(
       
                    width: _w * 0.8,
                    height: _h,
                    color: white,
       
                    child: 
                       
                           Column(
                            children: [
                              Container(
                                width: _w * 0.8,
                                color: logoMainColor,
                                padding:const EdgeInsets.only(top: 20.0, bottom: 20.0,left: 15.0),
                                child: Row(
                                 
                                  children: [
                                    
                                       Container(
                                        width: _w * 0.2,
                                        height: _w * 0.2,
                                     
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all(width: 2.0, color: white)
                                        ),
                                        margin:const EdgeInsets.only(bottom: 20.0,right: 10.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20.0),
                                          child: Image.asset('assets/images/test_parcel_3.jpg',fit: BoxFit.cover)),
                                                            ),
                                    

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Yussif Muniru',style: TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold,)),
                                      const  SizedBox(height: 7.5,),
                                         Text('+23318293038478',style: TextStyle(color: white.withOpacity(0.6), fontSize: 12.0, fontWeight: FontWeight.bold,)),
                                         const  SizedBox(height: 5.5,),
                                      ]
                                    )
                                  ],
                                ),
                              ),
       
                             
       
                              Container(
                                width: _w,
                                height: _h * 0.7,
                                alignment: Alignment.centerLeft,
                                
                                child: Column(
                                   
                                  children: [
                                    drawerItem(icon: Feather.package,title:'My Parcels',onTap: (){Navigator.pushNamed(context,Constants.DELIVERIES_ROUTE);}, ),
       
                                      drawerItem(icon: MaterialIcons.celebration,title:'Promotion',onTap: (){
                                      Navigator.pushNamed(context,Constants.DIRECTORS_ROUTE);
                                    },),
                                   drawerItem(icon: Feather.star ,title:'My Favorites',onTap: (){Navigator.pushNamed(context,Constants.DELIVERY_PERSONELS_ROUTE);},),
                                    
                                   drawerItem(icon: Octicons.credit_card ,title:'My payment',onTap: (){
                                     Navigator.pushNamed(context,Constants.PARCELS_STATISTICS_ROUTE);
                                   }),
                                    drawerItem(icon: Ionicons.notifications_outline,title:'Notification',onTap: (){
                                      Navigator.pushNamed(context,Constants.USAGE_AND_BILLING_ROUTE);
                                    }),
                                     drawerItem(icon: EvilIcons.comment,title:'Support',onTap: (){
                                       Navigator.pushNamed(context,Constants.ACCOUNT_TOP_UP_ROUTE);
                                     }),


                              const  Expanded(child: SizedBox()),
                                        
                                    
       
                                   drawerItem(icon: AntDesign.poweroff, title: "LogOut", onTap: (){},isLogOut: true),
                                     
       
                                  ],
                                ) ,
                                ),
       
                             
                            ],
                          ),
                     
                  ),  
       
                ),
                               
       
          // first marker label
          AnimatedPositioned(

          duration:const Duration(milliseconds: 700),
         curve: Curves.easeInOut,
         top: _firstMarkerLabelDataObj.markerLabelYCoordinate,
         left: _firstMarkerLabelDataObj.markerLabelXCoordinate,

        child: AnimatedOpacity(
           duration:const Duration(milliseconds: 700),
         curve: Curves.easeInOut,
         opacity: _firstMarkerLabelDataObj.markerLabelXCoordinate != -3000.0 && _firstMarkerLabelDataObj.markerLabelYCoordinate != -3000 ? 1.0 : 1.0, 
         child: Column(
           children: [
             markerLabelWidget(_firstMarkerLabelDataObj,key: _firstMarkerLableKey,),
           ],
         ))),
      
          // second marker label
          AnimatedPositioned(

          duration:const Duration(milliseconds: 700),
         curve: Curves.easeInOut,
         top: _secondMarkerLabelDataObj.markerLabelYCoordinate,
         left: _secondMarkerLabelDataObj.markerLabelXCoordinate,

        child: AnimatedOpacity(
           duration:const Duration(milliseconds: 700),
         curve: Curves.easeInOut,
         opacity: _secondMarkerLabelDataObj.markerLabelXCoordinate != -3000.0 && _secondMarkerLabelDataObj.markerLabelXCoordinate != -3000 ? 1.0 : 1.0, 
         child: Column(
           children: [
             markerLabelWidget(_secondMarkerLabelDataObj,key: _secondMarkerLableKey,),
           ],
         ))),
     
           AnimatedPositioned(

          duration:const Duration(milliseconds: 700),
         curve: Curves.easeInOut,
         top: _thirdMarkerLabel.markerLabelYCoordinate,
         left: _thirdMarkerLabel.markerLabelXCoordinate,

        child: AnimatedOpacity(
           duration:const Duration(milliseconds: 700),
         curve: Curves.easeInOut,
         opacity: _thirdMarkerLabel.markerLabelYCoordinate != -3000.0 && _thirdMarkerLabel.markerLabelXCoordinate != -3000 ? 1.0 : 1.0, 
         child: Column(
           children: [
             markerLabelWidget(_thirdMarkerLabel,key: _thirdMarkerLableKey,),
           ],
         ))),

         courierServiceSearchWidget(),
         intercityDestinationSearchWidget(),
         parcelTypesWidget(),
         selectParcelSizeWidget(),
             
              ],
               ),
    );
  }

   Widget courierServiceSearchWidget(){
    return  
     AnimatedPositioned(
           duration:const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          bottom: _showCourierServiceSearchWidget ? 0.0: -_h,
      child: Material(
            elevation:20.0,
            borderRadius:const  BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
        child: Container(
                      width: _w,
                      height: _h * 0.9,
                      decoration:const BoxDecoration(
                         color: white,
                          borderRadius:  BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                      ),
                     padding:const EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           SizedBox(
                             width: _w,
                             child: PlayAnimation<double>(
                               tween:Tween(begin: 0.5,end: 1.0),
                               duration:const Duration(milliseconds: 700),
                               curve: Curves.easeInOut,
                               builder: (context, child,value) {
                                 return Row(
                                   children: [
                                     Text('Search for Courier Service',style: TextStyle(color:black.withOpacity(0.8),fontSize: 19.0 * value,fontWeight: FontWeight.bold,)),
                                     const Expanded(child: SizedBox()),
                                     InkWell(
                                       onTap: (){
                                         setState(() {
                                         _showCourierServiceSearchWidget = false;
                                         });
                                       },
                                       child: Icon(Feather.x ,color: customFadedColor,size: 25.0))
                                   ],
                                 );
                               }
                             ),
                           ),
                   
                  const SizedBox(height: 35.0),
                         Row(
                           children: [
                             Container(
                               width: _w * 0.73,
                               margin:const EdgeInsets.only(right: 10.0),
                               padding:const EdgeInsets.symmetric(vertical: 11.5, horizontal: 10.0),
                               child: Row(
                                 children: [
                                   Icon(EvilIcons.search,color: customFadedColor.withOpacity(0.5),size: 25),
                                     Container(
                                    margin: const EdgeInsets.only(left: 10.0),
                                    width: _w * 0.5,
                                     padding:const EdgeInsets.only(right: 15.0), child: TextField(
                                     
                                      controller: _courierServiceSearchTextEditingController,
                                    
                                     textAlign: TextAlign.left,
                                      style:const TextStyle(
                                        fontSize: 14.3,
                                        color: warmPrimaryColor,
                                        fontWeight : FontWeight.bold,
                                      ),
                                   
                                      cursorColor: warmPrimaryColor,
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'courier service',
                                        hintStyle: TextStyle(
                                          color: customFadedColor.withOpacity(0.5),
                                         fontSize: 14.3,
                                        ),
                                      ),
                                      onChanged: (String parcel){
          
                                      },
                                    ),
                                  ),
                                    
                                    const Expanded(child: SizedBox()),
                                      InkWell(
                                        onTap: (){
                                          _courierServiceSearchTextEditingController.clear();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(3.5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: customFadedColor.withOpacity(0.1),
                                          ),
                                          child: Icon(Feather.x,color: customFadedColor.withOpacity(0.2),size: 15)),
                                      ),
          
          
          
                                 ]
                               ),
                               decoration: BoxDecoration(
                                 border: Border.all(color: customFadedColor.withOpacity(0.2)),
                                 borderRadius: BorderRadius.circular(10.0),
                               )
                             ),
                             
                               Container(
                                  width: 55.0,
                                  height: 55.0,
                                 
                                  alignment: Alignment.center,
                                  child:const Icon(Fontisto.equalizer,size: 18.0,color: white),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: logoMainColor,
                                  ),
                                                                    
                               ),
                                
                                 
                          
                           ],
                         ),
          
                        Container(margin:const EdgeInsets.symmetric(vertical: 25.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),
          
                     
                           RichText(text: TextSpan(
                               text: 'Results for ',
                               style: TextStyle(color: customFadedColor.withOpacity(0.5),fontSize: 13.5, ),
                               children: [
                                 TextSpan(
                                   text: 'Ups',
                                   style: TextStyle(color: customFadedColor.withOpacity(0.95),fontSize: 14.5, fontWeight: FontWeight.bold),
                                 ),
          
          
                               ]
                             ),) ,   
                          
                        const SizedBox(height: 15.0),
                      SizedBox(
                        width: _w,
                        height: _h * 0.5,
                        child: ListView(
                     
                          children: [
                           
                             Container(
                          width: _w * 0.73,
                          margin:const EdgeInsets.only(right: 10.0,bottom: 20.0),
                          padding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          child: Row(children: [
                               Container(
                                  width: 40.0,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  margin:const EdgeInsets.symmetric(horizontal: 5.0),
                                  child:const Icon(FontAwesome5Brands.ups,color: logoMainColor,size: 18.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: customFadedColor.withOpacity(0.07),
                                  ),
                                                                    
                                  ),
          
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                     Text(
                                       'UPS',
                                       style: TextStyle(color: black.withOpacity(0.9),fontSize: 13.5, fontWeight: FontWeight.bold),
                                     ),
                                    const SizedBox(height: 3.5),
                                      Row(
                                        children: [
                                          Text(
                                     '4.9 ',
                                   style: TextStyle(color: customFadedColor.withOpacity(0.7),fontSize: 11.5, fontWeight: FontWeight.bold,),
                                
                                 ),
          
                                  SmoothStarRating(
                                rating: 4.2,
                                size: 13.5,
                                color:goldColor,
                                borderColor:customFadedColor.withOpacity(0.08),
                                defaultIconData:AntDesign.star ,
                                filledIconData:AntDesign.star, 
                                halfFilledIconData: FontAwesome5.star_half,
                               
                                ),
                                        ],
                                      ),
          
                                ],
                              ),
                          ],), 
                          decoration: BoxDecoration(
                            border: Border.all(color: customFadedColor.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10.0),
                          )
                          ),
                         
                           Container(
                          width: _w * 0.73,
                          margin:const EdgeInsets.only(right: 10.0,bottom: 20.0),
                          padding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          child: Row(children: [
                               Container(
                                  width: 40.0,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  margin:const EdgeInsets.symmetric(horizontal: 5.0),
                                  child:const Icon(FontAwesome5Brands.dhl,color: logoMainColor,size: 18.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: customFadedColor.withOpacity(0.07),
                                  ),
                                                                    
                                  ),
          
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                     Text(
                                       'DHL',
                                       style: TextStyle(color: black.withOpacity(0.9),fontSize: 13.5, fontWeight: FontWeight.bold),
                                     ),
                                    const SizedBox(height: 3.5),
                                      Row(
                                        children: [
                                          Text(
                                     '4.3 ',
                                   style: TextStyle(color: customFadedColor.withOpacity(0.7),fontSize: 11.5, fontWeight: FontWeight.bold,),
                                
                                 ),
          
                                  SmoothStarRating(
                                rating: 4.2,
                                size: 13.5,
                                color:goldColor,
                                borderColor:customFadedColor.withOpacity(0.08),
                                defaultIconData:AntDesign.star ,
                                filledIconData:AntDesign.star, 
                                halfFilledIconData: FontAwesome5.star_half,
                               
                                ),
                                        ],
                                      ),
          
                                ],
                              ),
                          ],), 
                          decoration: BoxDecoration(
                            border: Border.all(color: customFadedColor.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10.0),
                          )
                          ),
                         
                         
                          ]
                        ),
                      ),
                      
          
                        ]
                      ),
                    ),
      ),
    );
         
             
  }
  
   Widget intercityDestinationSearchWidget(){
       List<String> _intercityDestinationsList = ['Wa','Bolgatanga','Tamale','Koforidua','Cape Coast','Ho','Aflao','Bono East',];
    return   AnimatedPositioned(
           duration:const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          bottom: _showIntercityDestinationSearchWidget ? 0.0: -_h,
      child: Material(
            elevation:20.0,
            borderRadius:const  BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
        child: Container(
                      width: _w,
                      height: _h * 0.9,
                      decoration:const BoxDecoration(
                         color: white,
                          borderRadius:  BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                      ),
                     padding:const EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
                   
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         SizedBox(
                           width: _w,
                           child: PlayAnimation<double>(
                             tween:Tween(begin: 0.5,end: 1.0),
                             duration:const Duration(milliseconds: 700),
                             curve: Curves.easeInOut,
                             builder: (context, child,value) {
                               return Row(
                                 children: [
                                   Text('Intercity Destinations Search',style: TextStyle(color:black.withOpacity(0.8),fontSize: 17.0 * value,fontWeight: FontWeight.bold,)),
                                   const Expanded(child: SizedBox()),
                                   InkWell(
                                     onTap: (){
                                       setState(() {
                                       _showIntercityDestinationSearchWidget = false;
                                       });
                                     },
                                     child: Icon(Feather.x ,color: customFadedColor,size: 25.0))
                                 ],
                               );
                             }
                           ),
                         ),
                    const SizedBox(height: 5.0),
                    Text('The previous dropOff location if any will be ignored!',style: TextStyle(color:customFadedColor.withOpacity(0.4),fontSize: 13.5 )),
                 
                const SizedBox(height: 35.0),
                       Row(
                         children: [
                           Container(
                             width: _w * 0.73,
                             margin:const EdgeInsets.only(right: 10.0),
                             padding:const EdgeInsets.symmetric(vertical: 11.5, horizontal: 10.0),
                             child: Row(
                               children: [
                                 Icon(EvilIcons.search,color: customFadedColor.withOpacity(0.5),size: 25),
                                   Container(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  width: _w * 0.5,
                                  
                                   padding:const EdgeInsets.only(right: 15.0), child: TextField(
                                   
                                    controller: _courierServiceSearchTextEditingController,
                                  
                                   textAlign: TextAlign.left,
                                    style:const TextStyle(
                                      fontSize: 14.3,
                                      color: warmPrimaryColor,
                                      fontWeight : FontWeight.bold,
                                    ),
                                 
                                    cursorColor: warmPrimaryColor,
                                    decoration: InputDecoration.collapsed(
                                      hintText: 'intercity destination',
                                      hintStyle: TextStyle(
                                        color: customFadedColor.withOpacity(0.5),
                                       fontSize: 14.3,
                                      ),
                                    ),
                                    onChanged: (String parcel){
    
                                    },
                                  ),
                                ),
                                  
                                  const Expanded(child: SizedBox()),
                                    InkWell(
                                      onTap: (){
                                        _courierServiceSearchTextEditingController.clear();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(3.5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: customFadedColor.withOpacity(0.1),
                                        ),
                                        child: Icon(Feather.x,color: customFadedColor.withOpacity(0.2),size: 15)),
                                    ),
    
    
    
                               ]
                             ),
                             decoration: BoxDecoration(
                               border: Border.all(color: customFadedColor.withOpacity(0.2)),
                               borderRadius: BorderRadius.circular(10.0),
                             )
                           ),
                           
                             Container(
                                width: 55.0,
                                height: 55.0,
                               
                                alignment: Alignment.center,
                                child:const Icon(Fontisto.equalizer,size: 18.0,color: white),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: logoMainColor,
                                ),
                                                                  
                             ),
                              
                               
                        
                         ],
                       ),
    
                      Container(margin:const EdgeInsets.symmetric(vertical: 25.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),
    
                   
                         RichText(text: TextSpan(
                             text: 'Results for ',
                             style: TextStyle(color: customFadedColor.withOpacity(0.5),fontSize: 13.5, ),
                             children: [
                               TextSpan(
                                 text: 'Tamale',
                                 style: TextStyle(color: customFadedColor.withOpacity(0.95),fontSize: 14.5, fontWeight: FontWeight.bold),
                               ),
    
    
                             ]
                           ),) ,   
                        
                      const SizedBox(height: 15.0),
                    SizedBox(
                      width: _w,
                      height: _h * 0.55,
                      child: ListView.builder(
                       itemCount : _intercityDestinationsList.length,
                        itemBuilder: (context,index)=> 
                        InkWell(
                          onTap: (){
                            setState(() {
                              _selectedIntercityDestination = _intercityDestinationsList[index];
                              _showIntercityDestinationSearchWidget = false;
                            });
                          },
                          child: Container(
                          width: _w * 0.73,
                          margin:const EdgeInsets.only(right: 10.0,bottom: 20.0),
                          padding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          child: Row(children: [
                               Container(
                                  width: 40.0,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  margin:const EdgeInsets.symmetric(horizontal: 5.0),
                                  child:const Icon(Ionicons.ios_location,color: logoMainColor,size: 18.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: customFadedColor.withOpacity(0.07),
                                  ),
                                                                    
                                  ),
                            
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                     Text(
                                      _intercityDestinationsList[index],
                                       style: TextStyle(color: black.withOpacity(0.9),fontSize: 13.5, fontWeight: FontWeight.bold),
                                     ),
                                   
                                
                            
                               
                               
                                
                            
                                ],
                              ),
                          ],), 
                          decoration: BoxDecoration(
                            border: Border.all(color: customFadedColor.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10.0),
                          )
                          ),
                        ),
                       
                        
                       
                       
                      )),
                      
                    
                    
    
                      ]
                    ),
                  ),
    ));
         
             
  }
  




  String continueButtonText(flag){

    switch (flag) {
      case  WidgetsFlags.pickLocationOnMap:
        
        return 'Pick Location';
      case WidgetsFlags.previewParcelTransitRoute:
     
       return 'Next';
      case WidgetsFlags.addReceipientDetails:
    
       return 'Confirm and Continue';  
     case WidgetsFlags.addParcelLocations:

       return 'add receipient details';
      default: return 'Continue';
    }


  }

  Widget selectContactFromMultipleContacts(){

    String contactName = '';
    Widget multiplePhoneNumbersWidgets = Container();

    if(_receipientContact != null){
      
        contactName = "${_receipientContact!.name.first} ${_receipientContact!.name.middle} ${_receipientContact!.name.last}";
        multiplePhoneNumbersWidgets =
    SizedBox(
      width: _w,
      height: _h * 0.45,
      child: ListView.builder(itemBuilder: (context,i) =>  InkWell(
        onTap: (){
          setState((){
              _receiverPhoneTextEditingController.text = _receipientContact!.phones[i].toString();
          });
        },
        child: Column(
                  children: [
                    Row(
                                          children: [
                                             Text('${_receipientContact!.phones[i]}. \t\t',style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                                            Container(
                                              width: _w * 0.8,
                                              padding:const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 1.0, color: logoMainColor),
                                                borderRadius: BorderRadius.circular(10.0)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                   Text(_receipientContact!.phones[i].number,style:const TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold)),
                                                const  SizedBox(height: 5.0),
                                                  Text(_receipientContact!.phones[i].normalizedNumber,style: TextStyle(color: customFadedColor,fontSize: 12.5,fontWeight: FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                    const SizedBox(height: 10),
                  ],
                ),
      ),
                      ),
    );
       
    }


    return  AnimatedPositioned(
      duration:const Duration(milliseconds: 700),
      curve: Curves.bounceInOut,

      bottom: _showMultiplePhoneNumbersSelectionWidget ? 0.0 : -_h,
      child: Column(
                      children: [
                        Material(
                          elevation: 30.0,
                          borderRadius:const BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                          child:Container(
                            width: _w ,
                            height:_h * 0.6,
                           
                            padding:const EdgeInsets.only(top: 15.0,bottom: 25.0, left: 15.0,right: 15.0),
                            decoration:const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                            ),
                          
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,height: 3.0,
                                  margin: EdgeInsets.only(bottom:15.0,left: _w * 0.4),
                                  decoration: BoxDecoration(
                                    color: customFadedColor.withOpacity(0.5),
                                    borderRadius:BorderRadius.circular(7.5) )),
                                Container(
                                  width: _w,
                                  alignment:Alignment.center,
                                  child:  Text(contactName,style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold))),
                                 
                               const SizedBox(height: 25.0),
    
                                multiplePhoneNumbersWidgets
                            
                              ]
                            ),
                            )),
                      ],
                    ),
    );
     
  }

  Widget cancelIconWidget(onTap,{bool showFlag = false,double topDistanceWhenShowed = -2000,Widget icon = const Icon(  Feather.x, size: 30.0,)}){

     // Icon(  Feather.x, size: _addRecipientDetails ? 23.0 : 30.0,))
    // MaterialCommunityIcons.arrow_bottom_left 
    //  Transform.rotate(angle: _addRecipientDetails ? 3.14 * 0.25 : 3.14 ,child: Icon(_addRecipientDetails ? MaterialCommunityIcons.arrow_bottom_left  : Feather.x, size: _addRecipientDetails ? 23.0 : 30.0,)))

    return  AnimatedPositioned(
                     duration:const Duration(milliseconds: 700),
                     curve: Curves.easeInOut,
                      top:showFlag ? topDistanceWhenShowed : -_h,
                      left: 10.0,
                      child:  InkWell(
                       
                       onTap:onTap    
                      
                      
                      
                       ,child:icon   ),
                   );



  }
  Widget learnMoreWidgetOfIntercityDelivery(){
  return   AnimatedPositioned(
    duration: const Duration(milliseconds: 700),
    curve: Curves.easeInOut,
    bottom: _showInterCityLearnMoreWidget ? 30.0 : -_h,
    left:35.0,
    child: Column(
            children: [
              Material(
                elevation: 20,
                borderRadius:const BorderRadius.only(bottomRight: Radius.circular(25.0),topLeft: Radius.circular(25.0)),
                child: Container(
                  width: _w * 0.8,
                  height: _h * 0.7,
                  decoration:const BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.0),topRight: Radius.circular(25.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                      
                        height: _h * 0.3,
                        child: Stack(
                          children: [
              
                            Positioned(
                              right: -10,
                              top: -15.0,
                              child: 
                                Container(
                                  width: _w * 0.65 ,
                                  height: _h * 0.3,
                                    decoration:const BoxDecoration(
                                      color: logoMainColor,
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular( 45.0)
                                    )
                                  ),
                                ),
                              
                            ),
                              Positioned(
                                left: 10,
                                top: 80.0, 
                                child: Container(
                                width: _w * 0.6,
                                height: _h * 0.45,
                                  decoration: BoxDecoration(
                                  color: white.withOpacity(0.2),
                                  borderRadius:const BorderRadius.only(topRight: Radius.circular( 45.0)
                                    )
                                ),
                                                      ),
                              ),
                              Positioned(
                                left: 150,
                                top: 25.0, 
                                child: Material(
                                  elevation: 25.0,
                                    shape:const CircleBorder(),
                                  child: Container(
                                  width: _w * 0.23,
                                  height: _w * 0.23,
                                  decoration:const BoxDecoration(
                                      color: white,
                                    shape: BoxShape.circle,
                                  ),
                                                        ),
                                ),
                              ),
                            
                            Positioned(top: 15.0,right: 20.0,child: InkWell(
                                onTap: (){
                                  setState(() {
                                    _showInterCityLearnMoreWidget = false;
                                  });
                                }
                              ,child: Container(width: _w,alignment: Alignment.centerRight,child: Icon(Feather.x,color: white.withOpacity(0.7),)))),
                          ],
                                ),
                              ),
                      
                            Container(
                              margin:const EdgeInsets.only(left: 20,bottom: 20.0),
                              
                              child:const Text('Inter-City Delivery',style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ),
                      
                      
                             Container(
                              margin:const EdgeInsets.only(left: 20,bottom: 30.0 ),
                              
                              child: Text('This setting by far is used for inter-city parcel delivery, where the parcels are sent to the main branch office of the selected courier service for further processing and packaging.\n\n NOTE: This may significantly delay the delivery time of the parcel.The delivery can take up to 24hrs. But also significantly reduce the cost of delivery.Not all courier service companies offer this service.',style: TextStyle(fontSize: 12.5, color: customFadedColor,))
                            ),
                      
                          
                                InkWell(
                                  onTap: (){
                                     setState(() {
                                    _showInterCityLearnMoreWidget = false;
                                  });
                                  }
                                  ,child: Container(width: _w * 0.7,margin:const EdgeInsets.only(left: 15.0),padding:const EdgeInsets.symmetric(vertical: 20.0),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Close' ,style:  TextStyle(color: white, fontSize: 12.5, fontWeight: FontWeight.bold)),)),
                             
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
  );

}



   Widget drawerItem({required IconData icon, required String title,required VoidCallback onTap, bool isLogOut = false,hasTopMargin = false}){
   return InkWell(
        onTap:onTap,
        splashColor:const Color(0xFFb8b8b8) ,
        child: Container(
        
          width: _w ,
          height: 60.0,
          alignment: Alignment.centerRight,
          padding:const EdgeInsets.only(left: 20.0),
          child: Row(
             children: [
              Container(margin:const EdgeInsets.only(right: 15.0) ,child: Icon(icon,size: 18.0,color: logoMainColor ),),
              Text(title,style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color:isLogOut ? black : customFadedColor.withOpacity(0.8) )),
            ],
          ),
        ),
      );
 }


Widget recentParcelsWidget(onTap){
  return   InkWell(
    onTap: onTap,
    child: Row(
        children: [
          Material(
            borderRadius: BorderRadius.circular(15.0),
            elevation: 15,
            color: white,
            child: Container(
              width: _w * 0.95,
              height: _w * 0.42,
              padding: const EdgeInsets.only(left: 10.0,top: 10.0,),
              decoration: BoxDecoration(
                  color: white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child:  Row(
                children: [

                      InkWell(
                        onDoubleTap: (){
                          setState(() {
                            _addedToFavorites = !_addedToFavorites;
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                width: _w * 0.2,
                                height: _w * 0.15,
              
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(width: 2.0, color: white)
                                ),
                                margin:const EdgeInsets.only(bottom: 20.0,right: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.asset('assets/images/parcel_size_1.png',fit: BoxFit.cover)),
                              ),
                      
                          Positioned(
                            top: 10.0,
                            child: Column(
                            children: [
                              Icon(_addedToFavorites ? MaterialIcons.favorite  : MaterialIcons.favorite_border,color: black,size: 15.0),
          
                              SizedBox(height: 5.0),
                            Text('Double Tap',style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold,color: black)),
          
                            ],
                          ))
                          ],
                        ),
                      ),

                     Container(width: .5,height:_h * 0.15,margin:const EdgeInsets.only(right: 15.0,bottom: 10),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.5), color:false ? black : customFadedColor.withOpacity(0.4)), ),         

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text('Ibrahim Tanko',style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.0),
                         Text('Spintex Road | Batsonaa Total filling Station',style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: customFadedColor.withOpacity(0.5))),
                         const SizedBox(height: 5.0),
                           Row(
                             children: [
                               SmoothStarRating(
                                  rating: 4.3,
                                  size: 13.0,
                                  color:const Color(0xFFffdf00),
                                  borderColor: const Color(0xFFffdf00),
                                  defaultIconData: Feather.star,
                                    ),
                              Text(' 4.3',style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: customFadedColor.withOpacity(0.5))),
                             ],
                           ),

                           SizedBox(height: 5.0,),
                           Text('${Constants.CEDI_SYMBOL} 34.00',style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5.0,),
                          Text('Parcel Size 3 - 1 Matellic Artefac',style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: customFadedColor.withOpacity(0.5))),
                         const Expanded(child: SizedBox()),
   SizedBox(
     width: _w * 0.665,
     child: Row(
       children: [
         SizedBox(),
         const Expanded(child: SizedBox()),
         Container(width: 75.0,height: 20.0,alignment:Alignment.center ,decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(8.5),bottomRight: Radius.circular(10)),color:true ? logoMainColor :  black ) ,child: Text('16/Nov/2021',style: TextStyle(color: white,fontSize: 11.5))),
       ],
     ),
   ),                                         

                    ],),

                   

                ],
                )
                  
                       
                        ),
                      ),
                   
                  const SizedBox(width: 10)
                    ],
                  ),
  );

  
}


Widget noRecentParcelsWidget(){

    return  Row(
      children: [
        Material(
                borderRadius: BorderRadius.circular(15.0),
                elevation: 15,
                color: white,
                child: Container(
                  width: _w * 0.95,
                  height: _w * 0.39,
                  margin:const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.only(left: 10.0,top: 15.0,bottom: 15.0),
                  decoration: BoxDecoration(
                      color: white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                       children: [
  
            
                  PlayAnimation<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, child,value) {
                      return 
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Material(
                              elevation: 30.0,
                              
                            ),
                            Container(
                                        width: 65,
                                        height: 65,
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [customFadedColor.withOpacity(0.7),customFadedColor ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops:const [0.3, 1]),
                                          shape: BoxShape.circle,
                                        ),
                                        child:const Icon(

                                        FontAwesome5Solid.box_open ,
                                        color: white,
                                        size: 30

                                        ),
                                      ),
                          ],
                        );
                       
                      
                    }
                  ),


  
                   const   Expanded(child: SizedBox()),
                   //const SizedBox(height: 10.0),
                          Text("It's quite in here",style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, )),
                       const   SizedBox(height: 3.5),
                      Text('No Parcels yet',style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold,color: customFadedColor )) ,
                      const SizedBox(width: 10)
          
  ],
),
            
             
   ),
                            ),
     
     const SizedBox(width: 10.0),
     
      ],
    );

  

}


Widget getActivityTypeWidget(String title, String desc,VoidCallback onTap,IconData icon,{isActive = false}){
  return InkWell(
    onTap: onTap,
    child: Row(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(15.0),
                        elevation: 30,
                        color: white,
                        child: Container(
                          width: _w * 0.33,
                          height: _w * 0.42,
                          padding: const EdgeInsets.only(right: 10.0,left: 10.0,top: 15.0,bottom:15.0 ),
                          decoration: BoxDecoration(
                             color: white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: 
                          Column(
                            children: [
                            true ? Stack(
              children: [
              
                    
                          PlayAnimation<double>(
                           tween: Tween(begin: 0.0, end: 1.0),
                            builder: (context, child,value) {
                              return true ? 
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Material(
                                      elevation: 30.0,
                                      
                                    ),
                                    Container(
                                                width: 65,
                                                height: 65,
                                                padding: const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors:isActive ? [Colors.black.withOpacity(0.7),Colors.black ] : [customFadedColor.withOpacity(0.4),customFadedColor.withOpacity(0.7) ],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      stops:const [0.3, 1]),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
  
                                                icon,
                                               color: white,
                                               size: 30
  
                                                ),
                                              ),
                                  ],
                                )
                               :
                              //  Material(
                              //   elevation:  0.5 * value,
                              //   color: logoBackgroundColor,
                              //   shape:const CircleBorder(),
                              //   child: 
                                Container(
                                  margin: EdgeInsets.only(left: 100.0,top: 300.0),
                                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                                  decoration: BoxDecoration(
                                   // color:true ? logoMainColor : logoBackgroundColor,
                                    gradient: LinearGradient(
                                      colors: [black.withOpacity(0.8),black],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops:const [0.1,.9]
  
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 0.75, color:false ? logoBackgroundColor :  Colors.grey.withOpacity(0.4)) ,
                                  ),
                                  child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                 
                                              });
                                             
                                            },
                                            child: Container(
                                              child: Icon(AntDesign.filter,size: 18,color: logoMainColor)
                                            ),
                                          ),
                                   
                                  
                                )
                             
                              //)
                              ;
                            }
                          ),
  
  
              
                 
                  
              ],
            )
          :    
          
           Material(
               
                        elevation: 30,
                        color: black,
                        shadowColor: black.withOpacity(0.1),
                        shape:const CircleBorder(),
                        child: Container(
                          width: 65,
                          height: 65,
                          padding: const EdgeInsets.only(right: 10.0,left: 10.0,top: 15.0,bottom:15.0 ),
                          decoration:const BoxDecoration(
                            shape: BoxShape.circle,
                            color: black
                          ),
                          child:const Icon(
                           MaterialCommunityIcons.source_commit_start_next_local,
                            color: white,
                            size: 30 ),
                        ),
                      ),
  
  
               const   Expanded(child: SizedBox()),
               
                      Text(title,style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold,color: logoMainColor )),
                   const   SizedBox(height: 3.5),
               isActive ?   Text(desc,style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold,color: customFadedColor )) : MirrorAnimation<double>(builder: (context, child,value) => Transform.scale(scale: 1.3 * value,child: Text(desc,style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold,color: customFadedColor ))),curve: Curves.easeInOut,duration:const Duration(milliseconds: 700), tween: Tween(begin: 0.8,end: 1.0) ),
  
                            ]
                          ),
                        ),
                      ),
                   
                  const SizedBox(width: 10)
                    ],
                  ),
  );
          
}

Widget markerLabelWidget(MarkerLabelData markerLabelData, {required GlobalKey<State<StatefulWidget>> key}){

  
    return  InkWell(
      onTap:(){

      },
      child: Stack(
              key:key,
              clipBehavior: Clip.none,
              children: [
                Material(
                  elevation: 30.0,
                borderRadius: BorderRadius.circular(10.0),
                child: Container(width: _w * 0.5,padding:const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),alignment: Alignment.center,decoration: BoxDecoration(color: white,  borderRadius: BorderRadius.circular(10.0),), child:Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 'Rex House' '769 Isadore isle Suite'
                           Text(markerLabelData.markerLabelTitle,style:const  TextStyle( fontSize: 12.5, fontWeight: FontWeight.bold)),
                        const  SizedBox(height: 2.5),
                          Text(markerLabelData.markerLabelDesc,style:  TextStyle(color: customFadedColor.withOpacity(0.45),fontSize: 10.5, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Icon(SimpleLineIcons.arrow_right,color: customFadedColor,size: 12.0 ),
                  ],
                ),),
          ),
    
    
            
    
              Positioned(
                bottom: -5.0,
                left: 20.0,
                child: Transform.rotate(
                  angle: 3.14 * 0.2,
                  child: Material(
                      borderRadius: BorderRadius.circular(3.5),
                      color: white,
                      child:SizedBox(width: 15.0,height: 15.0),
                      ),
                ),
              )
            
              ],
                         ),
    );


  }

List<Widget> searchingLocationsIndicators() {
      return 
     List.generate(10, (index) => Container(width: 250.0,padding: EdgeInsets.symmetric(vertical: 15.0),child: Row(
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
                width: _w * 0.6,
                height: 10.0,
                  
              decoration: BoxDecoration(
                  color: Color(0xFFC0C0C0).withOpacity(0.5) ,
              borderRadius: BorderRadius.circular(3.5))),
                 Container(
                   margin: EdgeInsets.only(top: 10.0),
                width: _w * 0.45,
                height: 10.0,
                  
              decoration: BoxDecoration(
                 color: Color(0xFFC0C0C0).withOpacity(0.5),
              borderRadius: BorderRadius.circular(5.0))),
              ]),
              
              
            ]))
      );
      
      }

        
                      
Widget placeWidget({name = '', city = '',required  Function() onTap}){
     return  InkWell(
            onTap: onTap,
            child: Row(
            children: [
            
                  Container(
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


  // search for courier service
  void handleCourierServiceSearch(String searchString)async {

        if(searchString.isEmpty){
                                                  
              setState((){
                
                _showPlacesParentWidget = false;
              });
              return;
              }
              setState(() { 
            
                locationsWidget = searchingLocationsIndicators();
              _showPlacesParentWidget = true;
              });

                List<PlacesSearchResult> locationRes =    (await  _googleMapsPlaces.searchByText(searchString,radius: 50000)).results;
                

                  if(locationRes.isNotEmpty){
                      locationRes.forEach((PlacesSearchResult place) {
                  
                locationsWidget.add(placeWidget(name: place.name , city: place.formattedAddress , onTap: ()async{
                          setState(() {
                            
                            isAcquiringLocation = true;
                            _showPlacesParentWidget = false;

                          });

                          _pickupLocationFocusNode.unfocus();

                        // await chooseLocationWithLatLng(place.geometry!.location.lat, place.geometry!.location.lng);

                          setState((){
                            isAcquiringLocation = false;
                          });

                        //  goToLocation(place.geometry!.location.lat, place.geometry!.location.lng);
                                    
                              }
                                  
                ));
              print(place.name);
              print(place.vicinity);
              print(place.scope);
              print(place.placeId);
              print(place.formattedAddress);
                  });
                  
                                      
            
                  }
              
                
              
                if(locationRes.isEmpty){
              
                locationsWidget = [ Column(
            
                  children: [
                    Container(
                      margin:const EdgeInsets.only(top: 70.0),
                      width:40.0,
                      height: 40.0,child:Image.asset(Constants.GRAY_SEARCH_ICON,fit: BoxFit.cover) ),
                    Container(
                      margin:const EdgeInsets.only(bottom: 10.0),
                      child:const Text('Not courier service found.',style: TextStyle(color: warmPrimaryColor,fontSize: 17.0, fontWeight: FontWeight.bold)),
                    ),
                    const Text('Please check the courier service name and try again.',style: TextStyle(color: fadedHeadingsColor,fontSize: 12.0)
                    ),
                  ],
                )];
                
                }
    
                setState(() { });
                    
                                    
                              
                                    

    }



  // search for places
  void handlePlacesSearch(String searchString)async {

        if(searchString.isEmpty){
                                                  
              setState((){
                
                _showPlacesParentWidget = false;
              });
              return;
              }
              setState(() { 
            
                locationsWidget = searchingLocationsIndicators();
              _showPlacesParentWidget = true;
              });

                List<PlacesSearchResult> locationRes =    (await  _googleMapsPlaces.searchByText(searchString,radius: 50000)).results;
                

                  if(locationRes.isNotEmpty){
                      locationRes.forEach((PlacesSearchResult place) {
                  
                locationsWidget.add(placeWidget(name: place.name , city: place.formattedAddress , onTap: ()async{
                          setState(() {
                            
                            isAcquiringLocation = true;
                            _showPlacesParentWidget = false;

                          });

                          _pickupLocationFocusNode.unfocus();

                        // await chooseLocationWithLatLng(place.geometry!.location.lat, place.geometry!.location.lng);

                          setState((){
                            isAcquiringLocation = false;
                          });

                        //  goToLocation(place.geometry!.location.lat, place.geometry!.location.lng);
                                    
                              }
                                  
                ));
              print(place.name);
              print(place.vicinity);
              print(place.scope);
              print(place.placeId);
              print(place.formattedAddress);
                  });
                  
                                      
            
                  }
              
                
              
                if(locationRes.isEmpty){
              
                locationsWidget = [ Column(
            
                  children: [
                    Container(
                      margin:const EdgeInsets.only(top: 70.0),
                      width:40.0,
                      height: 40.0,child:Image.asset(Constants.GRAY_SEARCH_ICON,fit: BoxFit.cover) ),
                    Container(
                      margin:const EdgeInsets.only(bottom: 10.0),
                      child:const Text('Oops!!! No Locations found',style: TextStyle(color: warmPrimaryColor,fontSize: 17.0, fontWeight: FontWeight.bold)),
                    ),
                    const Text('Please check the location name and try again.',style: TextStyle(color: fadedHeadingsColor,fontSize: 12.0)
                    ),
                  ],
                )];
                
                }
    
                setState(() { });
                    
                                    
                              
                                    

    }






void previewParcelTransitRoute({List<PolylineDataModel> polylinesData = const [],List<MarkerData> markersData = const [],List<MarkerLabelData> markerLabelsData = const []})async{
       GoogleMapController _controller =  await _googleMapController.future;
    for (var i = 0; i < markersData.length; i++) {
      MarkerData markerData = markersData[i];

     locationsMarkers[ MarkerId(markerData.markerStringID)] = Marker(

          markerId: MarkerId(markerData.markerStringID),
          //anchor:const Offset(0.5,0.5),
          position:markerData.markerLatLng,
          infoWindow:  InfoWindow(
            title:  markerData.infoWindowTitle,
            snippet: markerData.inforWindowDesc ,
            
          ),
          icon: markerData.icon
        );  

        if(i == 0){
           RenderObject? renderObj = _firstMarkerLableKey.currentContext!.findRenderObject();
          
          double _height = renderObj!.paintBounds.size.height;

           ScreenCoordinate _screenCoordinate = await _controller.getScreenCoordinate(markerData.markerLatLng);

           double devicePixelRatio =   MediaQuery.of(context).devicePixelRatio;
          _firstMarkerLabelDataObj =   MarkerLabelData(markerLabelXCoordinate:(_screenCoordinate.x / devicePixelRatio) - 25,markerLabelYCoordinate: (_screenCoordinate.y / devicePixelRatio) - (_height + 15),markerLabelTitle:markerLabelsData.first.markerLabelTitle,markerLabelDesc: markerLabelsData.first.markerLabelDesc);
           
        }else if(i == 1){

           RenderObject? renderObj = _secondMarkerLableKey.currentContext!.findRenderObject();
          
          double _height = renderObj!.paintBounds.size.height;

          
          ScreenCoordinate _screenCoordinate = await _controller.getScreenCoordinate(markerData.markerLatLng);

           double devicePixelRatio =   MediaQuery.of(context).devicePixelRatio;
         _secondMarkerLabelDataObj =   MarkerLabelData(markerLabelXCoordinate:(_screenCoordinate.x / devicePixelRatio) - 25,markerLabelYCoordinate: (_screenCoordinate.y / devicePixelRatio) - (_height + 15),markerLabelTitle:markerLabelsData.first.markerLabelTitle,markerLabelDesc: markerLabelsData.first.markerLabelDesc);


        }else {
           RenderObject? renderObj = _thirdMarkerLableKey.currentContext!.findRenderObject();
          
          double _height = renderObj!.paintBounds.size.height;

         
          ScreenCoordinate _screenCoordinate = await _controller.getScreenCoordinate(markerData.markerLatLng);

           double devicePixelRatio =   MediaQuery.of(context).devicePixelRatio;
          _thirdMarkerLabel =   MarkerLabelData(markerLabelXCoordinate:(_screenCoordinate.x / devicePixelRatio) - 25,markerLabelYCoordinate: (_screenCoordinate.y / devicePixelRatio) - (_height + 15),markerLabelTitle:markerLabelsData.first.markerLabelTitle,markerLabelDesc: markerLabelsData.first.markerLabelDesc);

        


    }
  


    //offerLatLng and currentLatLng are custom

    final LatLng currentLatLng = polylinesData.first.polylineStartLatLng;
    final LatLng offerLatLng =  polylinesData.last.polylineEndLatLng;

    LatLngBounds bound;
    if (offerLatLng.latitude > currentLatLng.latitude &&
        offerLatLng.longitude > currentLatLng.longitude) {
      bound = LatLngBounds(southwest: currentLatLng, northeast: offerLatLng);
    } else if (offerLatLng.longitude > currentLatLng.longitude) {
      bound = LatLngBounds(
          southwest: LatLng(offerLatLng.latitude, currentLatLng.longitude),
          northeast: LatLng(currentLatLng.latitude, offerLatLng.longitude));
    } else if (offerLatLng.latitude > currentLatLng.latitude) {
      bound = LatLngBounds(
          southwest: LatLng(currentLatLng.latitude, offerLatLng.longitude),
          northeast: LatLng(offerLatLng.latitude, currentLatLng.longitude));
    } else {
      bound = LatLngBounds(southwest: offerLatLng, northeast: currentLatLng);
    }

   
  CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 100);
    _controller.animateCamera(u2).then((void v){
      check(u2,_controller);
    });
      




  // 2. draw the polylines
  addPolylines(polylinesData: polylinesData);


 _widgetFlag = WidgetsFlags.previewParcelTransitRoute;
  
  setState(() {
    
  });
    
    }

}


void check(CameraUpdate u, GoogleMapController c) async {
   
    c.animateCamera(u);
    LatLngBounds l1= await c.getVisibleRegion() ;
    LatLngBounds l2= await c.getVisibleRegion() ;
  
    if(l1.southwest.latitude==-90 ||l2.southwest.latitude==-90){
       check(u, c);
    }
      
     

  }





void addPolylines({List<PolylineDataModel> polylinesData = const []}){

   polylinesData.forEach((polylineData){ 
          polylines[PolylineId(polylineData.polylineID)] = Polyline(
            polylineId: PolylineId(polylineData.polylineID),
            visible: true,
            width: 5,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            patterns: polylineData.polylineParternItems,
            points: MapsCurvedLines.getPointsOnCurve(polylineData.polylineStartLatLng, polylineData.polylineEndLatLng), // Invoke lib to get curved line points
            color: logoMainColor,
        );
   

         

      });


}


Future<Map<String,dynamic>> getUserContact()async{

  try{
 
    bool permission = await FlutterContacts.requestPermission();


      // Request contact permission
    if (permission) {
     


       // Open external contact app to pick contacts.
        Contact?  contact =  await FlutterContacts.openExternalPick();
        return {'result': true, 'data': contact};
    }

    return {'result': false,'desc': 'Contacts permission denied,please go to settings to update your contacts permissions.'};
    }catch(e){
    myPrint(e);
     return {'result': false,'desc': 'Unexpected error while reading contacts.'};
    }

}


  void removeMarkerLabels() {
      _firstMarkerLabelDataObj = MarkerLabelData();
      _secondMarkerLabelDataObj = MarkerLabelData();
      setState(() {
        
      });

  }

  void gotoLocation({required LatLng latLng, double bearing  = 158.0, String markerID = 'default_marker_id',bool showAnimatedCamera = true, markerIcon })async{
      
          
            if(showAnimatedCamera){
              GoogleMapController _controller =  await _googleMapController.future;
            _controller.animateCamera(CameraUpdate.newCameraPosition( CameraPosition(
            bearing: bearing,
            target:latLng,
            tilt: 45.0,
            zoom: 13.595899200439453)));
            }
       

         setState(() {
             locationsMarkers[ MarkerId(markerID)] = Marker(

                    markerId: MarkerId(markerID),
                    zIndex: 30.0,
                    position:latLng,
                    rotation:bearing,
                    infoWindow: InfoWindow(
                      title: _userModel.getUser.fullname,
                      snippet: 'rating:1',
                      
                    ),
                    icon: markerIcon ?? parcelMarkerIcon! 
                  );

       
         });


  }

 
  void clearDestinationMarker() {

          locationsMarkers[const MarkerId('destination_location_marker')] = Marker(

            markerId:const MarkerId('destination_location_marker'),
            
            position:const LatLng(Constants.XTRMXY,Constants.XTRMXX),
            icon: pickupLocationIcon!
          );

              setState(() {
                
              });

    
  }

  void handlePickLocationOnMap() {}



  Widget requestDeliveryWidget(){
    return   AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom:_widgetFlag == WidgetsFlags.selectDeliveryBikeType ? 0.0 : -_h,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child:

                           
                        Container(
                          width: _w,
                          height: _h * 0.7,
                          padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                          child: 
                         Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children:const [
                                Text('Choose Dispatch',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                               
                               
                 
                              ]
                            ),
                          ),

                          SizedBox(
                            width: _w,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               

                                Column(
                                 children: [
                                  Container(
                              width: 80,
                              height: 80.0,
                              margin:const EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: LinearGradient(
                                  colors: [logoMainColor.withOpacity(0.9),logoMainColor],
                                  stops:const [0.3,1],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Image.asset('assets/images/delivery_bike.png',fit:BoxFit.cover)),
                                  Text('Nearest',style: TextStyle(color: black,fontWeight: FontWeight.bold,fontSize: 13.5)),
                                
                                 ],),


                              Column(
                                       children: [
                                           Container(
                                    width: 80,
                                    height: 80.0,
                                    margin:const EdgeInsets.only(bottom: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      gradient: LinearGradient(
                                        colors: [customFadedColor.withOpacity(0.5),customFadedColor.withOpacity(0.2)],
                                        stops:const [0.3,1],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                            ),
                                            child: Image.asset('assets/images/delivery_bike.png',fit:BoxFit.cover)),
                                        Text('Standard',style: TextStyle(color: customFadedColor.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 13.5)),
                                      
                                       ],),
                                 

                               
                                  Column(
                                 children: [
                                     Container(
                              width: 80,
                              height: 80.0,
                              margin:const EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: LinearGradient(
                                  colors: [customFadedColor.withOpacity(0.5),customFadedColor.withOpacity(0.2)],
                                  stops:const [0.3,1],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Image.asset('assets/images/delivery_bike.png',fit:BoxFit.cover)),
                                  Text('Custom Courier',style: TextStyle(color: customFadedColor.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 13.5)),
                                
                                 ],),

                             

                             ]
                           ),
                          ),


                      Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),

                           SizedBox(
                             width: _w,
                             child: Row(
                               children: [
                                 Icon(FontAwesome.map_marker,color:customFadedColor,size: 15.0),
                                
                               const  Text(' 21 km',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(Feather.clock,color:customFadedColor,size: 12.0),
                                
                               const  Text(' 8 mins',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(MaterialIcons.payments,color:customFadedColor,size: 18.0),
                                
                               const  Text( ' ${Constants.CEDI_SYMBOL} 25',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               

                               ],
                             ),
                           ),


                        Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),




                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const SizedBox(height: 15.0),
                    
                         Row(children: [
                             
                 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              
                 
                             
                           Row(children: [
                            Column(
                              children: [
                                Container(decoration: BoxDecoration(color: white,shape: BoxShape.circle,border: Border.all(width: 6.0, color: logoMainColor), ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                 Container(width:1.5,height:_w * 0.15,decoration: BoxDecoration(color: black.withOpacity(0.5),borderRadius: BorderRadius.circular(4.0)),),
                                 Container(decoration: BoxDecoration(shape: BoxShape.circle,color: white,border: Border.all(width: 6.0, color: black) ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                              ],
                            ),
                 
                          const  SizedBox(width: 10.0,),
                 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pickup',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                            const    SizedBox(height: 7.5),
                            const   Text('Neon Cafe, 23/A Park Avenue',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                 
                            Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.67,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),
                 
                             Text('Drop Off',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                            const    SizedBox(height: 7.5),
                            const   Text('Rex House, 769 Isadore',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),       
                 
                            ],),
                 
                        
                 
                          ],),
                 
                         ],),
                 
                            const  SizedBox(width: 20.0),
                            Container(margin:const EdgeInsets.only(bottom: 15.0),padding:const EdgeInsets.all(4.0),decoration: BoxDecoration(shape: BoxShape.circle, color:  customFadedColor.withOpacity(0.05)),child:
                              
                              Transform.rotate(angle: 3.14 * 0.2,child: const Icon(AntDesign.swap , color: Color(0xFF0091FF),size: 15.0))),
                            
                 
                 
                            ],),
                 
                     
                     ]
                      ),
                      
                      const Expanded(child: SizedBox(),),

                  Row(
                    children: [
                           InkWell(
                             onTap:(){
                               setState(() {
                                 _widgetFlag = WidgetsFlags.addParcelPaymentInfo;
                               });
                             },
                              child: Container(width: _w * 0.2,padding:const EdgeInsets.symmetric(vertical: 16.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(10.0),), child:Transform.rotate(angle: 3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left ,color: white, size:  30.0,)),),),

                                 InkWell(
                                   onTap:(){},
                                   child: Container(width: _w * 0.65,padding:const EdgeInsets.symmetric(vertical: 23.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: logoMainColor,  borderRadius: BorderRadius.circular(10.0),), child:const Text('Request a Delivery' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),)),

                    ]
                  ),
                    

                      ]   
                          ),
                   
                   
                          )
                        )



           );
     
     
  }


  Widget customerBadgeWiningWidget(){
    return         AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child:

                           
                        Container(
                          width: _w,
                          height: _h * 0.55,
                          padding:const EdgeInsets.only(top: 35.0,left:15.0,right: 15.0),
                          child: 
                          Column(
                          
                            children: [

                              SizedBox(
                              width: 120,
                              height: 120.0,
                              child: Image.asset('assets/images/best_gold_badge.png',fit:BoxFit.cover)),
                         
                         const SizedBox(height: 40.0),
                                 
                            const Text('New Badge Earned!',style:  TextStyle(color:black, fontSize: 15.5, fontWeight: FontWeight.bold)),
                            const   SizedBox(height: 7.5,),
                            Text('Congratulations! You have earned a new badge with 25 deliveries.',textAlign: TextAlign.center,style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                           const SizedBox(height: 45.0),
                       

                      
                            
                            

                            const Expanded(child: SizedBox()),
                             
                                  

                                 Container(width: _w * 0.9,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: logoMainColor,  borderRadius: BorderRadius.circular(10.0),), child:const Text('Take a new ride' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),),

                           

                        const SizedBox(height: 20.0),


                            ]
                                )
                                    
                                    
                                              ),
                   
                   
                          )
                        );


  }


  Widget tipDispatchRiderWidget(){
    return   
    
     AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child:Stack(
                      clipBehavior: Clip.none,
                      children: [
                          Positioned(
                            top: -35.0,
                            
                            child: Container(
                              width:_w,
                              alignment: Alignment.center,
                              child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: SizedBox(
                              width: 60,
                              height: 60.0,
                              child: Image.asset(Constants.AVATAR_USER_ICON,fit:BoxFit.cover)),
                                                    ),
                            ),
                          ),   

                           
                        Container(
                          width: _w,
                          height: _h * 0.55,
                          padding:const EdgeInsets.only(top: 35.0,left:15.0,right: 15.0),
                          child: 
                          Column(
                          
                            children: [
                             
                            const Text('Zhan Huo',style:  TextStyle(color:black, fontSize: 15.5, fontWeight: FontWeight.bold)),
                            const   SizedBox(height: 5.0,),
                            Text('Toyota (BFD823-434)',style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                         const SizedBox(height: 40.0),
                                 
                            const Text('Wow 5 start!',style:  TextStyle(color:black, fontSize: 15.5, fontWeight: FontWeight.bold)),
                            const   SizedBox(height: 7.5,),
                            Text('Any additional tip for Zhan Huo?',textAlign: TextAlign.center,style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                           const SizedBox(height: 45.0),
                       

                      
                                 SizedBox(
                                   width: _w,
                                
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                          Container(
                              width: 75.0,
                              height: 75.0,
                              alignment: Alignment.center,
                            
                              child:  Text('${Constants.CEDI_SYMBOL}15.0' ,style:  TextStyle(color: customFadedColor, fontSize: 13.5, fontWeight: FontWeight.bold)),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                  
                              ),  
                            
                                         Container(width: 65.0,
                                        height: 65.0,
                                        margin:const EdgeInsets.symmetric(horizontal: 25.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('${Constants.CEDI_SYMBOL}10.0' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),),

                                            Container(
                              width: 55.0,
                              height: 55.0,
                              alignment: Alignment.center,
                            
                              child:  Text('${Constants.CEDI_SYMBOL}2.0' ,style:  TextStyle(color: customFadedColor, fontSize: 13.5, fontWeight: FontWeight.bold)),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                  
                              ),  
                            

                                     ]
                                   ),
                                 ), 

                                      
                             
                           
                            

                            const Expanded(child: SizedBox()),
                             
                                  

                                 Container(width: _w * 0.9,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Tip' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),),

                           

                        const SizedBox(height: 20.0),


                            ]
                                )
                                    
                                    
                                              ),
                   
                   
                      ],
                    )
                          )
                        );

       
  }

  Widget rateDeliveryExperienceWidget(){
    return     AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child:Stack(
                      clipBehavior: Clip.none,
                      children: [
                          Positioned(
                            top: -35.0,
                            
                            child: Container(
                              width:_w,
                              alignment: Alignment.center,
                              child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: SizedBox(
                              width: 60,
                              height: 60.0,
                              child: Image.asset(Constants.AVATAR_USER_ICON,fit:BoxFit.cover)),
                                                    ),
                            ),
                          ),   

                           
                        Container(
                          width: _w,
                          height: _h * 0.70,
                          padding:const EdgeInsets.only(top: 35.0,left:15.0,right: 15.0),
                          child: 
                          Column(
                          
                            children: [
                             
                            const Text('Zhan Huo',style:  TextStyle(color:black, fontSize: 15.5, fontWeight: FontWeight.bold)),
                            const   SizedBox(height: 5.0,),
                            Text('Toyota (BFD823-434)',style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                         const SizedBox(height: 40.0),
                                 
                            const Text('How was your delivery?',style:  TextStyle(color:black, fontSize: 14.5, fontWeight: FontWeight.bold)),
                            const   SizedBox(height: 7.5,),
                            Text('Your feedback will help improve parcel delivery experience',textAlign: TextAlign.center,style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                            SizedBox(height: 45.0),
                       

                         SmoothStarRating(
                            rating: 4,
                            size: 30.0,
                            color:goldColor,
                            borderColor:customFadedColor.withOpacity(0.08),
                            defaultIconData:AntDesign.star ,
                            filledIconData:AntDesign.star, 
                           
                            ),


                           Container(
                             width: _w * 0.9,
                             height: _h * 0.2,
                             margin:const EdgeInsets.only(top: 25.0),
                             padding:const EdgeInsets.only(top: 10.0,left: 10.0),
                            child: Text('Additional comments...',style: TextStyle(color: customFadedColor.withOpacity(0.2),fontWeight:FontWeight.bold,fontSize: 12.5)),
                             decoration: BoxDecoration(
                               color: customFadedColor.withOpacity(0.08),
                               borderRadius: BorderRadius.circular(15.0),

                             )
                           ),


                                
                                  

                                      
                             
                           
                            

                            const Expanded(child: SizedBox()),
                             
                                  

                                 Container(width: _w * 0.9,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Submit Feedback' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),),

                           

                        const SizedBox(height: 20.0),


                            ]
                                )
                                    
                                    
                                              ),
                   
                   
                      ],
                    )
                          )
                        );

       

  }


  Widget trackRiderToPickupLocation(){
    return    AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child:Container(
                      width: _w,
                      height: _h * 0.83,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: _w,
                            child: Column(
                              children: [
                                Container(
                                  width: 45.0,
                                  height: 4.5,
                                  decoration: BoxDecoration(
                                    color: customFadedColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ],
                            ),
                          ),



                          Container(
                            width: _w,
                            height: 25.0,
                            margin:const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children:const [
                                  Text('ARRIVES IN 7 MIN',style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                              ],
                            )),

                             Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),
                            
                         
                         SizedBox(
                           width: _w,
                         //  height: _h * 0.1,
                           child: Row(
                             children: [
                               ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                 child: SizedBox(
                                   width: 60,
                                   height: 60.0,
                                   child: Image.asset(Constants.AVATAR_USER_ICON,fit:BoxFit.cover)),
                               ),
                               const SizedBox(width: 10.0),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                      const Text('Zhan Huo',style:  TextStyle(color:black, fontSize: 14.5, fontWeight: FontWeight.bold)),
                                   const   SizedBox(height: 5.0,),
                                      Text('Toyota (BFD823-434)',style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                                 ]
                               ),

                               const Expanded(child: SizedBox()),

                               Container(
                                 padding:const EdgeInsets.symmetric(vertical: 3.5,horizontal: 7.5),
                                 decoration: BoxDecoration(
                                   color: customFadedColor.withOpacity(0.07),
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),
                                 child: Row(
                                   children:const [
                                     Icon(Fontisto.star,color:goldColor,size: 11.0),
                                    
                                     Text('4.9',style:  TextStyle(color:black, fontSize: 11.5, fontWeight: FontWeight.bold)),
                                   ]
                                 ),
                               ),
                             ],
                           ),
                         ),

                           Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),

                           SizedBox(
                             width: _w,
                             child: Row(
                               children: [
                                 Icon(FontAwesome.map_marker,color:customFadedColor,size: 15.0),
                                
                               const  Text(' 21 km',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(Feather.clock,color:customFadedColor,size: 12.0),
                                
                               const  Text(' 8 m',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(MaterialIcons.payments,color:customFadedColor,size: 18.0),
                                
                               const  Text( ' ${Constants.CEDI_SYMBOL} 25',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               

                               ],
                             ),
                           ),


                        Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),
                     

                         Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                                Icon(Fontisto.map_marker_alt,color:customFadedColor,size: 15.0),

                                const  Text( ' Pickup Point',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5)),
                                const Expanded(child: SizedBox()),
                              const  Text('CHANGE',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                 
                              ]
                            ),
                          ),



                        
                            Container(
                              width: _w,
                              height: _h * 0.25,
                              margin:const EdgeInsets.only(bottom: 25.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                child: GoogleMap(
                                          
                                          onMapCreated: (controller){},
                                          myLocationEnabled: true,
                                                        
                                          myLocationButtonEnabled: false,
                                          mapType: MapType.normal ,
                                        
                                          onCameraIdle: ()async{
                                   
                                               },
                                          onTap: (LatLng latLng){
                                                   },
                                      compassEnabled: false,
                                      zoomControlsEnabled: false,
                                      initialCameraPosition:const CameraPosition(
                                          target: LatLng(5.6778757, -0.0174085),
                                          bearing: 120.0,
                                          zoom:15.0,
                                      ),
                                                                                        
                                                                                      ),
                              ),
                                        
                            ),
                          

                        const Expanded(child: SizedBox()),
                                
                             Row(
                          children:[

                           Container(
                              width: 55.0,
                              height: 55.0,
                              alignment: Alignment.center,
                            
                              child:  const Icon( Foundation.telephone, size:  30.0,),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),  
                              

                             Container(width: _w * 0.72,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Cancel Request' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),)

                          ]
                        ),

                    const SizedBox(height: 20.0),


                        ]
                            )
                                
                                
                                          )
                          )
                        );

       
  }

  Widget parcelRequestConfirmedWidget(){
    return    AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                         SizedBox(
                           width: _w,
                         //  height: _h * 0.1,
                           child: Row(
                             children: [
                               ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                 child: SizedBox(
                                   width: 60,
                                   height: 60.0,
                                   child: Image.asset(Constants.AVATAR_USER_ICON,fit:BoxFit.cover)),
                               ),
                               const SizedBox(width: 10.0),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                      const Text('Zhan Huo',style:  TextStyle(color:black, fontSize: 14.5, fontWeight: FontWeight.bold)),
                                   const   SizedBox(height: 5.0,),
                                      Text('Toyota (BFD823-434)',style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                                 ]
                               ),

                               const Expanded(child: SizedBox()),

                               Container(
                                 padding:const EdgeInsets.symmetric(vertical: 3.5,horizontal: 7.5),
                                 decoration: BoxDecoration(
                                   color: customFadedColor.withOpacity(0.07),
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),
                                 child: Row(
                                   children:const [
                                     Icon(Fontisto.star,color:goldColor,size: 11.0),
                                    
                                     Text('4.9',style:  TextStyle(color:black, fontSize: 11.5, fontWeight: FontWeight.bold)),
                                   ]
                                 ),
                               ),
                             ],
                           ),
                         ),

                           Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),

                           SizedBox(
                             width: _w,
                             child: Row(
                               children: [
                                 Icon(FontAwesome.map_marker,color:customFadedColor,size: 15.0),
                                
                               const  Text(' 21 km',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(Feather.clock,color:customFadedColor,size: 12.0),
                                
                               const  Text(' 8 m',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(MaterialIcons.payments,color:customFadedColor,size: 18.0),
                                
                               const  Text( ' ${Constants.CEDI_SYMBOL} 25',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               

                               ],
                             ),
                           ),


                        Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),
                     

                         Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                                Icon(Fontisto.map_marker_alt,color:customFadedColor,size: 15.0),

                                const  Text( ' Pickup Point',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5)),
                                const Expanded(child: SizedBox()),
                              const  Text('CHANGE',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                 
                              ]
                            ),
                          ),



                        
                            Container(
                              width: _w,
                              height: _h * 0.25,
                              margin:const EdgeInsets.only(bottom: 25.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                child: GoogleMap(
                                          
                                          onMapCreated: (controller){},
                                          myLocationEnabled: true,
                                                        
                                          myLocationButtonEnabled: false,
                                          mapType: MapType.normal ,
                                        
                                          onCameraIdle: ()async{
                                   
                                               },
                                          onTap: (LatLng latLng){
                                                   },
                                      compassEnabled: false,
                                      zoomControlsEnabled: false,
                                      initialCameraPosition:const CameraPosition(
                                          target: LatLng(5.6778757, -0.0174085),
                                          bearing: 120.0,
                                          zoom:15.0,
                                      ),
                                                                                        
                                                                                      ),
                              ),
                                        
                            ),
                          

                        const Expanded(child: SizedBox()),
                                
                             Row(
                          children:[

                           Container(
                              width: 55.0,
                              height: 55.0,
                              alignment: Alignment.center,
                            
                              child:  const Icon( Foundation.telephone, size:  30.0,),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),  
                              

                             Container(width: _w * 0.72,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Cancel Request' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),)

                          ]
                        ),

                    const SizedBox(height: 20.0),


                        ]
                            )
                                
                                
                                          )
                          )
                        );

       
  }

  Widget parcelPaymentDetailsStepWidget(){
    return     AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom:_widgetFlag == WidgetsFlags.addParcelPaymentInfo ? 0.0 : -_h,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 25.0),
                            child: Row(
                              children:const [
                                Text('Select Payment',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                 Expanded(child: SizedBox()),
                                Text('ADD NEW',style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                 
                              ]
                            ),
                          ),

                          Container(
                            padding:const EdgeInsets.symmetric(vertical: 15.0,horizontal:15),
                            margin: EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                                Material(
                                  elevation: 0,
                                  color: logoMainColor,
                                  borderRadius: BorderRadius.circular(15.0),
                                  child:Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child:const Icon(MaterialIcons.payments,color: white,size: 25.0)
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Cash Payment',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                  const  SizedBox(height: 7.5),
                                    Text('Default method',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color: customFadedColor.withOpacity(0.45))),


                                  ]
                                ),

                                const Expanded(child: SizedBox()),
                             const   Icon(MaterialIcons.check_circle,color: black,size: 20),
                              ]
                            ),
                            decoration: BoxDecoration(
                              color: customFadedColor.withOpacity(0.1),
                              borderRadius:BorderRadius.circular(12.5),
                            ),
                          ),
                           Container(
                            padding:const EdgeInsets.symmetric(vertical: 15.0,horizontal:15),
                            margin: EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                             
                                  Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child:Image.asset(Constants.MTN_MOMO_LOGO,fit:BoxFit.cover)
                                  ),
                                
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Mtn Momo',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                  const  SizedBox(height: 7.5),
                                    Text('*** **** ***',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color: customFadedColor.withOpacity(0.45))),


                                  ]
                                ),

                                const Expanded(child: SizedBox()),
                                Icon(MaterialIcons.check_circle,color: false ?  black : customFadedColor.withOpacity(0.5),size: 20),
                              ]
                            ),
                            decoration: BoxDecoration(
                              color: customFadedColor.withOpacity(0.1),
                              borderRadius:BorderRadius.circular(12.5),
                            ),
                          ),

                            SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("Payer",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Text('Me',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              ),
                            Container(
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              padding:const EdgeInsets.all(10.0),
                              child:const Text('receipient',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                       

                        Container(margin:const EdgeInsets.symmetric(vertical: 15.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),


                       const   Text('Promo Code',style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20.0),

                      Container(
                             width: _w * 0.9,
                            padding:const EdgeInsets.symmetric(vertical: 25.0,horizontal:15),
                            margin:const EdgeInsets.only(bottom: 15.0),
                            alignment: Alignment.center,
                            child: const Text('ADD PROMO CODE',style: TextStyle(fontSize: 12.5,color: Color(0xFF0091FF),fontWeight: FontWeight.bold)),
                         decoration: BoxDecoration(
                              border:Border.all(width: 1.0,color: customFadedColor.withOpacity(0.15)),
                              color: customFadedColor.withOpacity(0.07),
                              borderRadius:BorderRadius.circular(12.5),
                            ),
                      ),

                    const Expanded(child: SizedBox()),

                               Row(
                          children:[

                           InkWell(
                             onTap: (){
                               setState(() {
                                // _widgetFlag = WidgetsFlags.addParcelSizeInfo;
                               });
                             },
                             child:
                              Container(
                                width: 55.0,
                                height: 55.0,
                                alignment: Alignment.center,
                              
                                child: Transform.rotate(angle: 3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left , size:  30.0,)),
                                decoration: BoxDecoration(
                                  border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                  borderRadius: BorderRadius.circular(13),
                                  color: customFadedColor.withOpacity(0.07),
                                ),
                                                                  
                                ),
                           ),  
                              

                             InkWell(
                               
                                onTap: (){
                                  setState(() {
                                    _widgetFlag = WidgetsFlags.selectDeliveryBikeType;
                                  });
                                },
                               child: Container(width: _w * 0.72,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Request Parcel Delivery' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),))

                          ]
                        ),




                       const Expanded(child: SizedBox()),

                        ]
                            )
                                          )
                          )
                        );

       
  }

  Widget parcelSizeDetailsWidget(){
    return  
      AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35)),
                    child:Container(
                      width: _w,
                      height: _h * 0.9,
                      decoration:const BoxDecoration(
                           borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35)),
                      ),
                      padding:const EdgeInsets.only(left:15.0,right: 15.0),
                      child: 
                      ListView(
                       padding:const EdgeInsets.all(0.0),
                        children: [
                          Column(
                            
                            children: [
                             

                              SizedBox(
                                width: _w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                       const Expanded(child: SizedBox(),),
                                    Container(width: 35.0, height: 4.5,margin: EdgeInsets.only(bottom: 20.0,top: 10.0,right: _w * 0.35),decoration: BoxDecoration(color: customFadedColor.withOpacity(0.2), borderRadius: BorderRadius.circular(5.0))),
                                 
                                  const   Icon(Feather.x, size: 25.0)
                                  ],
                                ),
                              ),

                            ],
                          ),

                         Container(width: _w * 0.9, height: _h * 0.3,margin:const EdgeInsets.only(bottom: 20.0,top: 10.0),decoration: BoxDecoration(color: customFadedColor.withOpacity(0.05), borderRadius: BorderRadius.circular(25.0)),child:  Image.asset('assets/images/parcel_size_1.png',fit: BoxFit.cover)),

                          Container(
                             
                              child:const  Text('PARCEL SIZE 1',style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold)),
                              ),

                               Container(
                                 width:_w,
                                  margin:const EdgeInsets.symmetric(vertical: 30.0),
                              child:  Row(
                                children: [
                                  Text('Max Weight',style: TextStyle(fontSize: 13.5,color: customFadedColor.withOpacity(0.6))),
                                const  Expanded(child: SizedBox()),
                                    Text('1.5kg',style: TextStyle(fontSize: 13.5,color: customFadedColor.withOpacity(0.6))),
                                ],
                              ),
                              ),
                        RichText(
                          text: TextSpan(
                            text: 'This parcel is from the small group of parcels. It has the averagely the same size as a ',
                                style: TextStyle(fontSize: 11.5,color: customFadedColor.withOpacity(0.6)),
                              children: [
                            const TextSpan(
                              text: 'small to medium size mobile phone box.',
                              style: TextStyle(fontSize: 12,fontWeight:  FontWeight.bold,color: black)
                            ),
                              TextSpan(
                              text: '\n\nWhether it has being parceled rounded,cylindrical or any other shape, so far as it can fit into a ',
                              style: TextStyle(fontSize: 11.5,color: customFadedColor.withOpacity(0.6)),
                            ),
                            const  TextSpan(
                              text: 'small to medium size mobile phone box,',
                              style: TextStyle(fontSize: 12,fontWeight:  FontWeight.bold,color: black,)
                            ),
                            TextSpan(
                              text: 'it should be considered as a parcel size 1.',
                              style: TextStyle(fontSize: 11,color: customFadedColor.withOpacity(0.6)),
                              )
                          ]
                          )
                        
                        ),
                        Container(margin:const EdgeInsets.symmetric(vertical: 30.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),

                        SizedBox(
                          width: _w,
                          height: 35.0,
                          child: Row(
                            children: [
                              const Icon(Foundation.lightbulb,color:Color(0xFF0091FF),size:18 ),
                           const SizedBox(width: 7.0),
                              Text('Reference Object',style:TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold, color: customFadedColor.withOpacity(0.3))),
                              const Expanded(child: SizedBox()),
                            const  Text('Phone Box',style:TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold,color:  black )),

                            

                              
                            ]
                          ),
                        ),
                       
                        Container(width: _w * 0.9,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(top: 17.0,left: 10.0),alignment: Alignment.center,decoration: BoxDecoration(color: logoMainColor,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Close' ,style:  TextStyle(color: white, fontSize: 12.5, fontWeight: FontWeight.bold)),),
             

                     
                   
                
              ]
                             )
                          )
                        )
                 );
        
  }

  Widget chooseParcelTypeWidget(){
    return  AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 20.0),
                            child:const  Text('I am sending ?',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                          ),
                 
                  //  SizedBox(
                  //    width: _w,
                  //    height: _h * 0.6,
                  //    child: ListView(
                  //    shrinkWrap: true,
                  //    children:  parcelTypesWidget()

                  //  ),),

                     
                   
                
              ]
                             )
                          )
                        )
                 );
       
  }


   Widget parcelTypesWidget(){

     List<ParcelTypeObj> parcelTypes = [
       ParcelTypeObj(name: 'Envelope',iconData:Ionicons.mail,weightedValue: 1.3),
       ParcelTypeObj(name: 'Books',iconData:Entypo.book,weightedValue: 1.3),
       ParcelTypeObj(name: 'Medical',iconData:MaterialCommunityIcons.medical_bag,weightedValue: 1.2),ParcelTypeObj(name: 'Jewellery',iconData:MaterialCommunityIcons.language_ruby,weightedValue: 2.5),
      ParcelTypeObj(name: 'Television',iconData:FontAwesome.television,weightedValue: 1.8),
      ParcelTypeObj(name: 'Sound Systems',iconData:Fontisto.soundcloud,weightedValue: 1.8),
      ParcelTypeObj(name: 'Mobile Phone',iconData:FontAwesome.mobile,weightedValue: 1.8),
      ParcelTypeObj(name: 'Other electronic gadgets',iconData:Entypo.power_plug,weightedValue: 1.5),
      ParcelTypeObj(name:'Metallic Artifacts',iconData:SimpleLineIcons.anchor,weightedValue: 1.6),
      ParcelTypeObj(name:'Glass Artifacts',iconData:MaterialCommunityIcons.glass_tulip,weightedValue: 2.5),
      ];
      return     AnimatedPositioned(
           duration:const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          bottom: _showParcelTypeSelectionWidget ? 0.0: -_h,
      child: Material(
            elevation:20.0,
            borderRadius:const  BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
        child: Container(
                      width: _w,
                      height: _h * 0.9,
                      decoration:const BoxDecoration(
                         color: white,
                          borderRadius:  BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                      ),
                     padding:const EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           SizedBox(
                             width: _w,
                             child: PlayAnimation<double>(
                               tween:Tween(begin: 0.5,end: 1.0),
                               duration:const Duration(milliseconds: 700),
                               curve: Curves.easeInOut,
                               builder: (context, child,value) {
                                 return Row(
                                   children: [
                                     Text('I am sending ?',style: TextStyle(color:black.withOpacity(0.8),fontSize: 19.0 * value,fontWeight: FontWeight.bold,)),
                                     const Expanded(child: SizedBox()),
                                     InkWell(
                                       onTap: (){
                                         setState(() {
                                         _showParcelTypeSelectionWidget = false;
                                         });
                                       },
                                       child: Icon(Feather.x ,color: customFadedColor,size: 25.0))
                                   ],
                                 );
                               }
                             ),
                           ),
                   
                    
                       
                        Container(margin:const EdgeInsets.symmetric(vertical: 15.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),
          
                     

                      
                      SizedBox(
                        width: _w,
                        height: _h * 0.78,
                        child: ListView.builder(
                          itemCount: parcelTypes.length,
                          itemBuilder: (context,index) =>  InkWell(
                          onTap: (){
                            setState(() {
                              _selectedParcelType = parcelTypes[index];
                              _showParcelTypeSelectionWidget = false;
                            });
                          },
                          child: Container(
                          width: _w * 0.73,
                          margin:const EdgeInsets.only(right: 10.0,bottom: 20.0),
                          padding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          child: Row(children: [
                               Container(
                                  width: 40.0,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  margin:const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Icon( parcelTypes[index].iconData,color: logoMainColor,size: 18.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: customFadedColor.withOpacity(0.07),
                                  ),
                                                                    
                                  ),
                            
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                     Text(
                                      parcelTypes[index].name,
                                       style: TextStyle(color: black.withOpacity(0.9),fontSize: 13.5, fontWeight: FontWeight.bold),
                                     ),

                                     Row(
                                       children: [
                                         Text(
                                          'weighted value',
                                           style: TextStyle(color: customFadedColor.withOpacity(0.25),fontSize: 13.5, ),
                                         ),
                                          const SizedBox(width: 5.0),
                                         Container(
                                           decoration: BoxDecoration(
                                             shape: BoxShape.circle,
                                             color: customFadedColor.withOpacity(0.3),
                                           )
                                         ),
                                        const SizedBox(width: 5.0),
                                          Text(
                                          parcelTypes[index].weightedValue.toString(),
                                           style: TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold),
                                         ),
                                       ],
                                     ),
                                   
                                
                            
                               
                               
                                
                            
                                ],
                              ),
                          ],), 
                          decoration: BoxDecoration(
                            border: Border.all(color: customFadedColor.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10.0),
                          )
                          ),
                        ),
                       
                        
                     
                        ),
                      ),
                      
          
                        ]
                      ),
                    ),
      ),
    );
     
    }

  Widget parcelSizeWidget(CorrugatedBoxParcelSizeObj boxParcelSizeObj){


    return  
            InkWell(
              onTap: (){

              },
              child: PlayAnimation<double>(
               tween: Tween(begin: 0.5,end: 1.0),
               duration:const Duration(milliseconds: 700),
               curve: Curves.easeInOut,
                builder: (context, child,value) {
                  return Opacity(
                    opacity: value,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                      
                         Positioned(
                              bottom: _h * 0.1,
                              
                              child: Container(
                                width: _w * 0.42,
                                height: _h * 0.17,
                                alignment: Alignment.bottomCenter,
                                padding:const EdgeInsets.only(bottom: 10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1.0, color: black.withOpacity(0.3) ),
                                  borderRadius: BorderRadius.circular(13.0)
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Min. Parcel Price',style: TextStyle(color: customFadedColor.withOpacity(0.2),fontSize: 10.0,fontWeight: FontWeight.bold)),
                            
                                      Text('${Constants.CEDI_SYMBOL} ${boxParcelSizeObj.parcelMinPrice}',style: TextStyle(color:  black.withOpacity(0.9),fontSize: 24.0,fontWeight: FontWeight.w400)),
                            
                                    ],
                                ),
                              ),
                            ),
                      
                           
                        Material(
                          elevation: 35.0 * value ,
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            width: _w * 0.425,
                            height: _h * 0.37,
                            padding:const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15.0),
                               color: logoMainColor 
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(boxParcelSizeObj.parcelSizeSubCategory,style:const TextStyle(color: white,fontSize: 13.0,fontWeight: FontWeight.bold)),
                                Text(boxParcelSizeObj.parcelSizeReferenceString,style: TextStyle(color: white.withOpacity(0.35),fontSize: 11.5,fontWeight: FontWeight.bold)),
                      
                      
                               const  Expanded(child: SizedBox()),
                                SizedBox(
                                  width: 135,
                                  height: 135,
                                  child: Image.asset('assets/images/parcel_size_${boxParcelSizeObj.parcelSize}.png',fit: BoxFit.cover),
                                ),
                      
                      
                             const   Expanded(flex: 2,child: SizedBox()),
                      
                                 Container(width: _w * 0.425,alignment: Alignment.centerRight,child: Text('Max. Weight/Length: ',style: TextStyle(color: white.withOpacity(0.3),fontSize: 11.0,fontWeight: FontWeight.bold))),
                                Container(width: _w * 0.425,alignment: Alignment.centerRight,child: Text('${boxParcelSizeObj.parcelMaxWeight}kg | ${boxParcelSizeObj.parcelMaxLength}cm',style:const TextStyle(color: white,fontSize: 11.5,fontWeight: FontWeight.bold))),
                               
                      
                      
                              ],
                            ),
                          ),
                        ),
                    
                        Positioned(
                          bottom: _h * 0.17,
                          left: 65.0,
                          child:const Icon(Ionicons.checkmark_circle,color: logoMainColor,size: 22.0))
                    
                      ],
                    ),
                  );
                }
              ),
            ) ;
  
  }

  Widget polyBagParcelSizeWidget(PolytheneBagParcelSizeObj polyBagParcelObj){


    return  
            InkWell(
              onTap: (){

              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                
                   Positioned(
                        bottom: _h * 0.1,
                        
                        child: Container(
                          width: _w * 0.42,
                          height: _h * 0.15,
                          alignment: Alignment.bottomCenter,
                          padding:const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: black.withOpacity(0.3) ),
                            borderRadius: BorderRadius.circular(13.0)
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Min. Parcel Price',style: TextStyle(color: customFadedColor.withOpacity(0.07),fontSize: 10.0,fontWeight: FontWeight.bold)),
                      
                                Text('${Constants.CEDI_SYMBOL} ${polyBagParcelObj.parcelMinPrice}',style: TextStyle(color:  black.withOpacity(0.9),fontSize: 24.0,fontWeight: FontWeight.w400)),
                      
                              ],
                          ),
                        ),
                      ),
                
                     
                  Material(
                    elevation: 35.0 ,
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      width: _w * 0.425,
                      height: _h * 0.37,
                      padding:const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15.0),
                         color: logoMainColor 
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(polyBagParcelObj.bagSizeSubCategory ,style:const TextStyle(color: white,fontSize: 11.0,fontWeight: FontWeight.bold)),
                          Text(polyBagParcelObj.parcelSizeReferenceString,style: TextStyle(color: white.withOpacity(0.35),fontSize: 11.5,fontWeight: FontWeight.bold)),
                
                
                         const  Expanded(child: SizedBox()),
                          SizedBox(
                            width: 135,
                            height: 135,
                            child: Image.asset('assets/images/polybag_${polyBagParcelObj.bagSize}.png',fit: BoxFit.cover),
                          ),
                
                
                        const  Expanded(flex: 2,child: SizedBox()),
                
                           Container(width: _w * 0.425,alignment: Alignment.centerRight,child: Text('Max. Weight/Length: ',style: TextStyle(color: white.withOpacity(0.3),fontSize: 11.0,fontWeight: FontWeight.bold))),
                          Container(width: _w * 0.425,alignment: Alignment.centerRight,child: Text('${polyBagParcelObj.parcelMaxWeight}kg | ${polyBagParcelObj.parcelMaxLength}cm',style:const TextStyle(color: white,fontSize: 11.0,fontWeight: FontWeight.bold))),
                         
                
                
                        ],
                      ),
                    ),
                  ),
              
                  Positioned(
                    bottom: _h * 0.17,
                    left: 65.0,
                    child:const Icon(Ionicons.checkmark_circle,color: logoMainColor,size: 22.0))
              
                ],
              ),
            ) ;
  
  }




 Widget parcelTypeWidget (title, {bool isSelected = false}){
    return  Container(
                  height: _w * 0.1,
                  padding: EdgeInsets.only(top: 8.5,right: 25.0,left: 25.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: isSelected ?logoMainColor : white)
                    ,borderRadius: BorderRadius.circular(16.5),color:isSelected ? white : Color(0xFFbf022b)),
                  child: Text(title,style: TextStyle(color:isSelected ? logoMainColor: white, fontSize: 12.5,fontWeight: FontWeight.bold)),
                );
              
              
  } 


  Widget parcelDetailsBackgroundWidget (){
    return    AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: _widgetFlag == WidgetsFlags.addParcelBasicInfo  ||
                     _widgetFlag == WidgetsFlags.addParcelPaymentInfo ||
                     _widgetFlag == WidgetsFlags.selectDeliveryBikeType || _widgetFlag == WidgetsFlags.addParcelDetailsContind
                      ? 0.0 : -_h,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    color: black,
                    child:Container(
                      width: _w,
                      height: _h * 0.9,
                        padding:const EdgeInsets.only(top: 25.0,right: 17.0,left: 17.0),
                      child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                   Container(
                                     width:_w ,
                                   
                                     margin:const EdgeInsets.only(bottom: 20.0),
                                     child: Row(
                                       children: const [
                          
                                         Text('Send Parcel',style: TextStyle(color: white, fontSize: 15.0,fontWeight: FontWeight.bold)),
                                         Expanded(child: SizedBox()),
                                         Icon(Feather.x,color: white,size: 25.0),
                                         
                                       ],
                                     ),
                                   ),
                               
                                  Row(
                                    children: [
                                  parcelDetailsBreadcrumbsWidget(1,currentlyActive: _widgetFlag == WidgetsFlags.addParcelBasicInfo || _widgetFlag == WidgetsFlags.addParcelDetailsContind || _widgetFlag == WidgetsFlags.addParcelPaymentInfo  ),
                                  parcelDetailsBreadcrumbsWidget(2,currentlyActive: _widgetFlag == WidgetsFlags.addParcelDetailsContind || _widgetFlag == WidgetsFlags.addParcelPaymentInfo),
                                  parcelDetailsBreadcrumbsWidget(3,currentlyActive: _widgetFlag == WidgetsFlags.addParcelPaymentInfo  || _widgetFlag == WidgetsFlags.addParcelDetailsContind ||  _widgetFlag == WidgetsFlags.addParcelBasicInfo),
                                  parcelDetailsBreadcrumbsWidget(4,showDottedLines: false,currentlyActive: _widgetFlag == WidgetsFlags.selectDeliveryBikeType || _widgetFlag == WidgetsFlags.addParcelPaymentInfo  || _widgetFlag == WidgetsFlags.addParcelDetailsContind ||  _widgetFlag == WidgetsFlags.addParcelBasicInfo)
                                    ],
                                  ),
                                 
                                  
                           
                              ],
                            ),
                          
                        
                   )
        
                  ),
    );

           
  }

  Widget firstParcelDetailsStepWidget(){
    return  
                     AnimatedPositioned(
                    curve:Curves.easeInOut,
                    
                    duration:const Duration(seconds: 1),
                    bottom:_widgetFlag == WidgetsFlags.addParcelBasicInfo ?  0.0 : -_h,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children:const [
                                Text('Parcel',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                 Expanded(child: SizedBox()),
                                //Text('Change',style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                 
                              ]
                            ),
                          ),
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const SizedBox(height: 15.0),

                    

                        const   Text('Courier Service / Destination Type',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),

                      const SizedBox(height: 25.0),

                       SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("Courier Service",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 60.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Text('Nearest',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              ),
                                InkWell(
                                   splashColor: _quantityOfParcels > 1 ? null : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: (){
                                    setState(() {
                                      _showCourierServiceSearchWidget =  true;
                                    });
                                  },
                                  child:_selectedCourierService.isNotEmpty ?
                                    Container(
                                      width: 100,
                                   height: 40.0,
                                  alignment: Alignment.center,
                                  margin:const EdgeInsets.symmetric(horizontal: 5.0),
                                  padding:const EdgeInsets.all(5.0),
                                  child: Text(_selectedCourierService,overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: customFadedColor.withOpacity(0.07),
                                             ),
                                                                  
                                     )
                                    :  
                                    Container(
                                   height: 40.0,
                                  alignment: Alignment.center,
                                  margin:const EdgeInsets.symmetric(horizontal: 5.0),
                                  padding:const EdgeInsets.all(5.0),
                                  child:const Text('Custom',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: customFadedColor.withOpacity(0.07),
                                                              ),
                                                                  
                                                              ),
                                ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                  

                      const SizedBox(height: 25.0),

                        SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: logoMainColor
                                ),
                              ),

                             const   Text("It's Inter-city delivery",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      _showIntercityDestinationSearchWidget = true;
                                    });
                                  },
                                  child:   
                            _selectedIntercityDestination.isNotEmpty ?    Container(
                              width: 80.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child: Text(_selectedIntercityDestination,overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              )   :
                                   Container(
                                  width: 40.0,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  child:const Text('Yes',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: customFadedColor.withOpacity(0.07),
                                   ),
                                                                  
                                                              ),
                                ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Text('No',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                 color: _selectedIntercityDestination.isNotEmpty ? customFadedColor.withOpacity(0.07) :   black,
                              ),
                                                                
                              ),

                              
                              ],
                            ),
                                    
                                                                 


                            ],),
                        ),
                 



                    Visibility(
                      visible: false,
                      child: Row(children: [
                               
                                     
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                
                                     
                               
                             Row(children: [
                              Column(
                                children: [
                                  Container(decoration: BoxDecoration(color: white,shape: BoxShape.circle,border: Border.all(width: 6.0, color: logoMainColor), ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                   Container(width:1.5,height:_w * 0.15,decoration: BoxDecoration(color: black.withOpacity(0.8),borderRadius: BorderRadius.circular(4.0)),),
                                   Container(decoration: BoxDecoration(shape: BoxShape.circle,color: white,border: Border.all(width: 6.0, color: black) ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                ],
                              ),
                                     
                            const  SizedBox(width: 10.0,),
                                     
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pickup',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                              const    SizedBox(height: 7.5),
                              const   Text('Neon Cafe, 23/A Park Avenue',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                                     
                              Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.67,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),
                                     
                               Text('Drop Off',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                              const    SizedBox(height: 7.5),
                              const   Text('Rex House, 769 Isadore',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),       
                                     
                              ],),
                                     
                          
                                     
                            ],),
                                     
                           ],),
                                     
                              const  SizedBox(width: 20.0),
                              Container(margin:const EdgeInsets.only(bottom: 15.0),padding:const EdgeInsets.all(4.0),decoration: BoxDecoration(shape: BoxShape.circle, color:  customFadedColor.withOpacity(0.05)),child:
                                
                                Transform.rotate(angle: 3.14 * 0.2,child: const Icon(AntDesign.swap , color: Color(0xFF0091FF),size: 15.0))),
                              
                                     
                                     
                              ],),
                    ),
                 
                     ]
                      ),
                             
                      Container(margin:const EdgeInsets.symmetric(vertical: 30.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),   


                        const   Text('Quantity and Parcel Type',style: TextStyle(color: logoMainColor, fontSize: 14.5,fontWeight: FontWeight.bold)),

                      const SizedBox(height: 25.0),

                       SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("Parcel Type",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                               InkWell(
                                 onTap: (){
                                    setState(() {
                                      _showParcelTypeSelectionWidget = true;
                                    });
                                 },
                                 child: Container(
                                height: 40.0,
                                alignment: Alignment.center,
                                padding:const EdgeInsets.all(10.0),
                                child: Text(_selectedParcelType.name.isNotEmpty ? 
                              _selectedParcelType.name  : 'Tap to select',style:const TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: black,
                                                             ),
                                                                  
                                                             ),
                               ),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    alignment: Alignment.center,
                                    margin:const EdgeInsets.symmetric(horizontal: 5.0),
                                    child:const Text('No',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                                    decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: customFadedColor.withOpacity(0.07),
                                                              ),
                                                                  
                                                              ),
                                ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                  

                      const SizedBox(height: 25.0),

                        SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin: EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: logoMainColor
                                ),
                              ),

                             const   Text('Quantity',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                InkWell(
                                  splashColor: _quantityOfParcels > 1 ? null : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: (){
                                    setState(() {
                                      if(_quantityOfParcels > 1){
                                        _quantityOfParcels = _quantityOfParcels - 1;
                                      }
                                      
                                    });
                                  },
                                  child: AnimatedOpacity(
                                    duration:const Duration(milliseconds: 700),
                                    curve: Curves.easeInOut,
                                    opacity: _quantityOfParcels == 1 ? 0.5 : 1.0,
                                    child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        alignment: Alignment.center,
                                        child:const Icon(AntDesign.minus,size: 18),
                                        decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: customFadedColor.withOpacity(0.07),
                                                                ),
                                                                    
                                                                ),
                                  ),
                                ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 7.5),
                              child: Text(_quantityOfParcels.toString(),style:const TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color:white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: black,
                              ),
                                                                
                              ),

                                InkWell(
                                   splashColor: _quantityOfParcels > 1 ? null : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: (){
                                    setState(() {
                                      if(_quantityOfParcels < 100){
                                        _quantityOfParcels = _quantityOfParcels + 1;
                                      }else{
                                        UtilityWidgets.getToast("Please you can't send more than 100 parcels at a time.",duration: '2');
                                      }
                                      
                                    });
                                  },
                                  child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  child:const Icon(MaterialIcons.add,size: 18),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: customFadedColor.withOpacity(0.07),
                                                              ),
                                                                  
                                            ),
                                ),
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),
                 

                        const Expanded(child: SizedBox()),

                    
                     
                       continueWithBackButton(continueButtonTap: (){
                         setState(() {
                           _widgetFlag = WidgetsFlags.addParcelDetailsContind;
                         });
                       },backButtonTap: (){
                           setState(() {
                           _widgetFlag = WidgetsFlags.addReceipientDetails;
                         });
                       },),
                       
                       
                        const SizedBox(height: 15.0),
                             
                        ],
                      ),
                    ),
                     ),
                 );
 
 
  }
  
   Widget addParcelDetailsContind(){
    return  
                     AnimatedPositioned(
                    curve:Curves.easeInOut,
                    
                    duration:const Duration(seconds: 1),
                    bottom:_widgetFlag == WidgetsFlags.addParcelDetailsContind ?  0.0 : -_h,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children:const [
                                Text('Parcel Size and Payment',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                 Expanded(child: SizedBox()),
                                //Text('Change',style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                 
                              ]
                            ),
                          ),
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const SizedBox(height: 15.0),

                    

                        const   Text('ParcelSize Approximation',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),

                      const SizedBox(height: 25.0),

                       SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("Parcel Size",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      _showParcelSizesSelectionWidget = true;
                                    });
                                  },
                                  child: Container(
                                                            
                                                              height: 40.0,
                                                              alignment: Alignment.center,
                                                              child:const Text('Tap to select',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                                                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: black,
                                                              ),
                                                                  
                                                              ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: InkWell(
                                     splashColor: _quantityOfParcels > 1 ? null : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: (){
                                      setState(() {
                                        _showCourierServiceSearchWidget =  true;
                                      });
                                    },
                                    child:_selectedCourierService.isNotEmpty ?
                                      Container(
                                        width: 100,
                                     height: 40.0,
                                    alignment: Alignment.center,
                                    margin:const EdgeInsets.symmetric(horizontal: 5.0),
                                    padding:const EdgeInsets.all(5.0),
                                    child: Text(_selectedCourierService,overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: customFadedColor.withOpacity(0.07),
                                               ),
                                                                    
                                       )
                                      :  
                                      Container(
                                     height: 40.0,
                                    alignment: Alignment.center,
                                    margin:const EdgeInsets.symmetric(horizontal: 5.0),
                                    padding:const EdgeInsets.all(5.0),
                                    child:const Text('Custom',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: customFadedColor.withOpacity(0.07),
                                                                ),
                                                                    
                                                                ),
                                  ),
                                ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                  

                      const SizedBox(height: 25.0),

                        SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: logoMainColor
                                ),
                              ),

                             const   Text("It's Inter-city delivery",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      _showIntercityDestinationSearchWidget = true;
                                    });
                                  },
                                  child:   
                            _selectedIntercityDestination.isNotEmpty ?    Container(
                              width: 80.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child: Text(_selectedIntercityDestination,overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              )   :
                                   Container(
                                  width: 40.0,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  child:const Text('Yes',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: customFadedColor.withOpacity(0.07),
                                   ),
                                                                  
                                                              ),
                                ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Text('No',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                 color: _selectedIntercityDestination.isNotEmpty ? customFadedColor.withOpacity(0.07) :   black,
                              ),
                                                                
                              ),

                              
                              ],
                            ),
                                    
                                                                 


                            ],),
                        ),
                 



                    Visibility(
                      visible: false,
                      child: Row(children: [
                               
                                     
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                
                                     
                               
                             Row(children: [
                              Column(
                                children: [
                                  Container(decoration: BoxDecoration(color: white,shape: BoxShape.circle,border: Border.all(width: 6.0, color: logoMainColor), ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                   Container(width:1.5,height:_w * 0.15,decoration: BoxDecoration(color: black.withOpacity(0.8),borderRadius: BorderRadius.circular(4.0)),),
                                   Container(decoration: BoxDecoration(shape: BoxShape.circle,color: white,border: Border.all(width: 6.0, color: black) ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                ],
                              ),
                                     
                            const  SizedBox(width: 10.0,),
                                     
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pickup',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                              const    SizedBox(height: 7.5),
                              const   Text('Neon Cafe, 23/A Park Avenue',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                                     
                              Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.67,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),
                                     
                               Text('Drop Off',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                              const    SizedBox(height: 7.5),
                              const   Text('Rex House, 769 Isadore',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),       
                                     
                              ],),
                                     
                          
                                     
                            ],),
                                     
                           ],),
                                     
                              const  SizedBox(width: 20.0),
                              Container(margin:const EdgeInsets.only(bottom: 15.0),padding:const EdgeInsets.all(4.0),decoration: BoxDecoration(shape: BoxShape.circle, color:  customFadedColor.withOpacity(0.05)),child:
                                
                                Transform.rotate(angle: 3.14 * 0.2,child: const Icon(AntDesign.swap , color: Color(0xFF0091FF),size: 15.0))),
                              
                                     
                                     
                              ],),
                    ),
                 
                     ]
                      ),
                             
                      Container(margin:const EdgeInsets.symmetric(vertical: 30.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),   


                        const   Text('Quantity and Parcel Type',style: TextStyle(color: logoMainColor, fontSize: 14.5,fontWeight: FontWeight.bold)),

                      const SizedBox(height: 25.0),

                       SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("Parcel Type",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                               InkWell(
                                 onTap: (){
                                    setState(() {
                                      _showParcelTypeSelectionWidget = true;
                                    });
                                 },
                                 child: Container(
                                height: 40.0,
                                alignment: Alignment.center,
                                padding:const EdgeInsets.all(10.0),
                                child: Text(_selectedParcelType.name.isNotEmpty ? 
                              _selectedParcelType.name  : 'Tap to select',style:const TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: black,
                                                             ),
                                                                  
                                                             ),
                               ),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    alignment: Alignment.center,
                                    margin:const EdgeInsets.symmetric(horizontal: 5.0),
                                    child:const Text('No',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                                    decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: customFadedColor.withOpacity(0.07),
                                                              ),
                                                                  
                                                              ),
                                ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                  

                      const SizedBox(height: 25.0),

                        SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin: EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: logoMainColor
                                ),
                              ),

                             const   Text('Quantity',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                InkWell(
                                  splashColor: _quantityOfParcels > 1 ? null : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: (){
                                    setState(() {
                                      if(_quantityOfParcels > 1){
                                        _quantityOfParcels = _quantityOfParcels - 1;
                                      }
                                      
                                    });
                                  },
                                  child: AnimatedOpacity(
                                    duration:const Duration(milliseconds: 700),
                                    curve: Curves.easeInOut,
                                    opacity: _quantityOfParcels == 1 ? 0.5 : 1.0,
                                    child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        alignment: Alignment.center,
                                        child:const Icon(AntDesign.minus,size: 18),
                                        decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: customFadedColor.withOpacity(0.07),
                                                                ),
                                                                    
                                                                ),
                                  ),
                                ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 7.5),
                              child: Text(_quantityOfParcels.toString(),style:const TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color:white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: black,
                              ),
                                                                
                              ),

                                InkWell(
                                   splashColor: _quantityOfParcels > 1 ? null : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: (){
                                    setState(() {
                                      if(_quantityOfParcels < 100){
                                        _quantityOfParcels = _quantityOfParcels + 1;
                                      }else{
                                        UtilityWidgets.getToast("Please you can't send more than 100 parcels at a time.",duration: '2');
                                      }
                                      
                                    });
                                  },
                                  child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  alignment: Alignment.center,
                                  child:const Icon(MaterialIcons.add,size: 18),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: customFadedColor.withOpacity(0.07),
                                                              ),
                                                                  
                                            ),
                                ),
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),
                 

                        const Expanded(child: SizedBox()),

                    
                     
                       continueWithBackButton(continueButtonTap: (){
                         setState(() {
                        //   _widgetFlag = WidgetsFlags.addParcelSizeInfo;
                         });
                       },backButtonTap: (){
                           setState(() {
                           _widgetFlag = WidgetsFlags.addReceipientDetails;
                         });
                       },),
                       
                       
                        const SizedBox(height: 15.0),
                             
                        ],
                      ),
                    ),
                     ),
                 );
 
 
  }
 





  Widget uneditedFirstParcelDetailsStepWidget(){
    return   AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children:const [
                                Text('Parcel',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                 Expanded(child: SizedBox()),
                                Text('Change',style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                 
                              ]
                            ),
                          ),
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const SizedBox(height: 15.0),

                    

                        const   Text('Quantity and Destination',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),

                      const SizedBox(height: 25.0),

                       SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("It's Inter-city",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Text('Yes',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Text('No',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                  

                      const SizedBox(height: 25.0),

                        SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin: EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: logoMainColor
                                ),
                              ),

                             const   Text('Quantity',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Icon(AntDesign.minus,size: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Text('2',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color:white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: black,
                              ),
                                                                
                              ),

                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Icon(MaterialIcons.add,size: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                                          ),
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),
                 



                    Visibility(
                      visible: false,
                      child: Row(children: [
                               
                                     
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                
                                     
                               
                             Row(children: [
                              Column(
                                children: [
                                  Container(decoration: BoxDecoration(color: white,shape: BoxShape.circle,border: Border.all(width: 6.0, color: logoMainColor), ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                   Container(width:1.5,height:_w * 0.15,decoration: BoxDecoration(color: black.withOpacity(0.8),borderRadius: BorderRadius.circular(4.0)),),
                                   Container(decoration: BoxDecoration(shape: BoxShape.circle,color: white,border: Border.all(width: 6.0, color: black) ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                ],
                              ),
                                     
                            const  SizedBox(width: 10.0,),
                                     
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pickup',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                              const    SizedBox(height: 7.5),
                              const   Text('Neon Cafe, 23/A Park Avenue',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                                     
                              Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.67,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),
                                     
                               Text('Drop Off',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                              const    SizedBox(height: 7.5),
                              const   Text('Rex House, 769 Isadore',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),       
                                     
                              ],),
                                     
                          
                                     
                            ],),
                                     
                           ],),
                                     
                              const  SizedBox(width: 20.0),
                              Container(margin:const EdgeInsets.only(bottom: 15.0),padding:const EdgeInsets.all(4.0),decoration: BoxDecoration(shape: BoxShape.circle, color:  customFadedColor.withOpacity(0.05)),child:
                                
                                Transform.rotate(angle: 3.14 * 0.2,child: const Icon(AntDesign.swap , color: Color(0xFF0091FF),size: 15.0))),
                              
                                     
                                     
                              ],),
                    ),
                 
                     ]
                      ),
                             
                      Container(margin:const EdgeInsets.symmetric(vertical: 30.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),   


                        const   Text('Quantity and Destination',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),

                      const SizedBox(height: 25.0),

                       SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("It's Inter-city",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Text('Yes',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Text('No',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                  

                      const SizedBox(height: 25.0),

                        SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin: EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: logoMainColor
                                ),
                              ),

                             const   Text('Quantity',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Icon(AntDesign.minus,size: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Text('2',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color:white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: black,
                              ),
                                                                
                              ),

                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Icon(MaterialIcons.add,size: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                                          ),
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),
                 

                        const Expanded(child: SizedBox()),

                    
                        Row(
                          children:[

                           Container(
                              width: 55.0,
                              height: 55.0,
                              alignment: Alignment.center,
                            
                              child: Transform.rotate(angle: 3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left , size:  30.0,)),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),  
                              

                             Container(width: _w * 0.7,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Continue' ,style:  TextStyle(color: white, fontSize: 12.5, fontWeight: FontWeight.bold)),)

                          ]
                        ),


                       
                       
                       
                        const SizedBox(height: 15.0),
                             
                        ],
                      ),
                    ),
                     ),
                 );
 
 
  }
  
  Widget selectParcelSizeWidget(){
    return   AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: _showParcelSizesSelectionWidget ? 0.0 : -_h,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.9,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 40.0),
                            child:Row(
                              children: [
                                 const  Text('Parcel Size Reference',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                  const Expanded(child: SizedBox()),
                                 Container(width: 1.0,height: 17.0,color: customFadedColor.withOpacity(0.2), ),
                                 const Expanded(child: SizedBox()),

                                   InkWell(
                                     onTap: (){
                                       setState(() {
                                        if(_boxParcelSizeApproximation){
                                         _boxParcelSizeApproximation  = false;
                                        }  
                                       });
                                       
                                     },
                                     child: Row(
                                   
                                       children: [
                                         const  Text('Bag',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold)),
                                       
                                     Container(
                                    margin:const EdgeInsets.only(left:5,right: 25.0),
                                    width: 15.0,height: 15.0,
                                    padding:const EdgeInsets.all(2.5),
                                    child: Container(width: 11.0, height: 11.0,decoration: BoxDecoration(
                                      color: !_boxParcelSizeApproximation ? logoMainColor : white,
                                      shape: BoxShape.circle)),
                                      decoration: BoxDecoration(
                                      border: Border.all(width: 2.0,color: logoMainColor),
                                      shape: BoxShape.circle,
                                                 ) ),
                                       
                                       ],
                                     ),
                                   ),
                            
                             
             


                                  InkWell(
                                    onTap:(){
                                      setState(() {
                                        if(!_boxParcelSizeApproximation){
                                         _boxParcelSizeApproximation  = true;
                                        }  
                                       });
                                    },
                                    child: Row(
                                      children: [
                                        const  Text('Box',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold)),
                                     
                                         Container(
                                    margin:const EdgeInsets.only(left:5,right: 10.0 ),
                                    width: 20.0,height: 20.0,
                                    padding:const EdgeInsets.all(2.5),
                                    child: Container(width: 15.0, height: 15.0,decoration: BoxDecoration(
                                      color: _boxParcelSizeApproximation ? logoMainColor : white,
                                      shape: BoxShape.circle)),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2.0,color: logoMainColor),
                                      shape: BoxShape.circle,
                                                              ) ),
                                  
                                  
                                     
                                      ],
                                    ),
                                  ),
                                 
                              ],
                            ),
                          ),
                 
                
                   CarouselSlider(
                carouselController:_carouselController ,
        options: CarouselOptions(
                height:450.0,
                enlargeCenterPage: true,
                viewportFraction: 0.6,
                onPageChanged: (i,reason){
                    myPrint('On Page Changed Called');
                },
                onScrolled: (i){
                        myPrint('On Scrolled Called');
                },
                ),
                
        items:_boxParcelSizeApproximation ? 

           _corrugatedBoxParcelSizeObjList.map((i) {
                return Builder(
                    builder: (BuildContext context) {
                      return parcelSizeWidget(i);
                    },
                );
        }).toList()
        
        :   _polytheneBagParcelSizeObjList.map((i) {
                return Builder(
                    builder: (BuildContext context) {
                      return polyBagParcelSizeWidget(i);
                    },
                );
        }).toList(),
      ),



          const Expanded(child: SizedBox()),
           PlayAnimation<double>(
            tween: Tween(begin: 0.4,end: 1.0),
            duration: Duration(milliseconds: 700),
            curve: Curves.easeInOut,
             builder: (context, child,value) {
               return Opaicty(
                 opacity: value,
                 child: Wrap(
                      runSpacing: 10.0,
                      spacing: 10.0,
                      runAlignment: WrapAlignment.start,
                      children: [
                        parcelTypeWidget('1/4',isSelected: _selectedParcelSizeBagReference == 0.25),
                        parcelTypeWidget('2/3',isSelected: _selectedParcelSizeBagReference == 0.6666),
                        parcelTypeWidget('1/2' isSelected: _selectedParcelSizeBagReference == 0.5),
                        parcelTypeWidget('3/4' isSelected: _selectedParcelSizeBagReference == 0.75),
                        parcelTypeWidget('FULL'isSelected: _selectedParcelSizeBagReference == 1),
                        
                        ],
                      ),
               );
             }
           ),
                  const Expanded(child: SizedBox()),
                 


            SizedBox(
                          width: _w * 0.89,
                          child:
                                 Row(
                          children:[

                           InkWell(
                             onTap: (){
                               setState(() {
                                   _widgetFlag = WidgetsFlags.addParcelBasicInfo;
                               });
                             },
                             child: Container(
                                width: 55.0,
                                height: 55.0,
                                alignment: Alignment.center,
                              
                                child: Transform.rotate(angle: 3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left , size:  30.0,)),
                                decoration: BoxDecoration(
                                  border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                  borderRadius: BorderRadius.circular(13),
                                  color: customFadedColor.withOpacity(0.07),
                                ),
                                                                  
                                ),
                           ),  
                              

                             InkWell(
                               onTap: (){
                                 setState(() {
                                   _widgetFlag = WidgetsFlags.addParcelPaymentInfo;
                                 });
                               },child: Container(width: _w * 0.7,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Next' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),))

                          ]
                        ),



                       
                        )
                 

                
              ]
                             )
                          )
                        )
                 );
       
       
  }
 
 
  Widget parcelDetailsBreadcrumbsWidget(int step,{bool showDottedLines = true,currentlyActive = false}){
   return  Row(
                               
                        children: [
                          
                          PlayAnimation<double>(
                          tween: Tween(begin: 0.0,end: 1.0),
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                            builder: (context, child,value) {
                              return Opacity(
                                opacity: value,
                                child: Material(
                                  elevation:currentlyActive ? 10.0  * value : 7.5 * value,
                                  borderRadius: BorderRadius.circular(10),
                                  color:currentlyActive ? white : white.withOpacity(0.1),
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    alignment: Alignment.center,
                                    child: Text('$step',style: TextStyle(color:currentlyActive ? black :  white,fontSize: 13.5,fontWeight: FontWeight.bold)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                       color:currentlyActive ? white : white.withOpacity(0.1),
                                    ),
                                                        
                                  ),
                                ),
                              );
                            }
                          ),
                          
                            Visibility(
                              visible: showDottedLines,
                              child: Row(
                              children: dottedLine(),
                                                      ),
                            ),
                      
                        ],
                      );
                         
 }


 List<Widget> dottedLine(){
   Widget dot =  Container(margin:const EdgeInsets.only(right: 3.0),color: white.withOpacity(0.15),width: 4.9,height: 1);
   return  List.generate(7, (index) => dot) ;
 }
 

  Widget selectionOptionWidget(title){

    return  Container(
                 
      height: _w * 0.1,
    
      padding:const EdgeInsets.only(top: 8.5,right: 25.0,left: 25.0),
      decoration: BoxDecoration(
        border: Border.all(width: 0.1, color: logoMainColor )
        ,borderRadius: BorderRadius.circular(16.5),color: white ),
      child: Text(title,style: TextStyle(color: logoMainColor, fontSize: 12.5,fontWeight: FontWeight.bold)),
                );
              
              
  


  }

  Widget continueWithBackButton({required VoidCallback continueButtonTap,required VoidCallback backButtonTap,String continueText = 'Continue'}){
   
    return    Row(
                          children:[

                           InkWell(
                             onTap: backButtonTap,
                             child: Container(
                                width: 55.0,
                                height: 55.0,
                                alignment: Alignment.center,
                              
                                child: Transform.rotate(angle: 3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left , size:  30.0,)),
                                decoration: BoxDecoration(
                                  border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                  borderRadius: BorderRadius.circular(13),
                                  color: customFadedColor.withOpacity(0.07),
                                ),
                                                                  
                                ),
                           ),  
                              

                             InkWell(onTap: continueButtonTap,child: Container(width: _w * 0.7,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0),alignment: Alignment.center,decoration: BoxDecoration(color: logoMainColor,  borderRadius: BorderRadius.circular(15.0),), child: Text(continueText,style:const  TextStyle(color: white, fontSize: 12.5, fontWeight: FontWeight.bold)),))

                          ]
                        );


  }



  Widget formatParcelSizeDescriptionString(String description){


     // declare a variable to hold the children of the first textspan 
    List<TextSpan> firstTextSpanChildren = [];

  
    // split the description based on the bold tag
    List<String> splittedDescription = description.split('<b>');
    

    // if there are no bolded tags return the decription as is 
      if(splittedDescription.isEmpty){
        return Text(description, style: TextStyle(fontSize: 11.5,color: customFadedColor.withOpacity(0.6)),);
      }


    // if there are, add them to the children of the inner textspan
    // based on whether they are to be bolded or not
    for(int x = 0; x < splittedDescription.length; x++){
      
      // add the bold TextSpans
      if(x % 2 != 0){

      firstTextSpanChildren.add(TextSpan(
      text: splittedDescription[x],
      style:const TextStyle(fontSize: 12,fontWeight:  FontWeight.bold,color: black)
                            ));
      }else{
        // add the non-bolded TextSpans
          firstTextSpanChildren.add(TextSpan(
      text: splittedDescription[x],
      style: TextStyle(fontSize: 11.5,color: customFadedColor.withOpacity(0.6))),);

      }
     
    }

    // return the formatted parcel description string
    return RichText( text: TextSpan(text: ' ', children:firstTextSpanChildren));
}

  
}
  



    enum WidgetsFlags {showBookDeliveries,showUserOfflineWidget,showAllActivities,sendParcelActivity,sendNewParcel ,previewParcelTransitRoute,addParcelLocations,addReceipientDetails,pickLocationOnMap,addParcelFirstDetails,addParcelBasicInfo,addParcelSizeInfo,addParcelPaymentInfo,selectDeliveryBikeType,requestParcelDelivery,addParcelDetailsContind}



  
class ParcelTypeObj {

  final String name;
  final IconData iconData;
  final double weightedValue;


  ParcelTypeObj({required this.name ,required this.iconData, this.weightedValue = 1});
}



  class CorrugatedBoxParcelSizeObj {

  final int parcelSize;
  final String parcelSizeSubCategory;
  final String parcelReferenceObj;
  final double parcelMaxWeight;
  final double parcelMaxLength; 
  final double parcelMaxWidth;
  final double parcelMaxHeight;
  final double parcelMinPrice;
  final String parcelSizeReferenceString;
  final String parcelSizeDescriptionString;


  CorrugatedBoxParcelSizeObj({ this.parcelSize = 0 , this.parcelSizeSubCategory = '', this.parcelReferenceObj = '',this.parcelMaxWeight = 0.0,this.parcelMaxLength = 0.0,this.parcelMinPrice = 0.0,this.parcelMaxWidth = 0.0, this.parcelMaxHeight = 0.0,this.parcelSizeReferenceString = '',this.parcelSizeDescriptionString = ''});

}



  class PolytheneBagParcelSizeObj {

  final int bagSize;
  final String bagSizeSubCategory;
  final String bagStandardPrice;
  final String bagImagePath;
  final double parcelMaxWeight;
  final double parcelMaxLength; 
  final double parcelMaxWidth;
  final double parcelMaxHeight;
  final double parcelMinPrice;
  final String parcelSizeReferenceString;
  final String parcelSizeDescriptionString;


  PolytheneBagParcelSizeObj({ this.bagSize = 0 , this.bagSizeSubCategory = '', this.bagStandardPrice = '',this.bagImagePath = '',this.parcelMaxWeight = 0.0,this.parcelMaxLength = 0.0,this.parcelMinPrice = 0.0,this.parcelMaxWidth = 0.0, this.parcelMaxHeight = 0.0,this.parcelSizeReferenceString = '',this.parcelSizeDescriptionString = ''});

}




class MarkerLabelData {

  final double markerLabelXCoordinate;
  final double markerLabelYCoordinate;
  final String markerLabelTitle ;
  final String markerLabelDesc;


  MarkerLabelData({ this.markerLabelXCoordinate = -300.0, this.markerLabelYCoordinate = -1000, this.markerLabelTitle = '', this.markerLabelDesc  = ''});
}      



class MarkerData {

  final String markerStringID;
  final LatLng markerLatLng;
  final String infoWindowTitle ;
  final String inforWindowDesc;
  final BitmapDescriptor icon;

  MarkerData({required this.markerStringID,required this.markerLatLng,required this.infoWindowTitle,required this.inforWindowDesc,required this.icon});
}



class PolylineDataModel {

  final String polylineID;
  final LatLng polylineStartLatLng;
  final LatLng polylineEndLatLng;
  final List<PatternItem> polylineParternItems;

  PolylineDataModel({required this.polylineID,required this.polylineStartLatLng,required this.polylineEndLatLng, this.polylineParternItems = const []});
}



 

