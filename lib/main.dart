import 'package:doorstep_customer/model_registry.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/services/data_models/user_data_model.dart';
import 'package:doorstep_customer/ui/routes/app_init_error_route.dart';
import 'package:doorstep_customer/ui/routes/blocked_route.dart';
import 'package:doorstep_customer/ui/routes/book_rides_screen.dart';
import 'package:doorstep_customer/ui/routes/customer_folder/choose_delivery_type_route.dart';
import 'package:doorstep_customer/ui/routes/customer_folder/customer_parcels_home_route.dart';
import 'package:doorstep_customer/ui/routes/customer_folder/home_route.dart';
import 'package:doorstep_customer/ui/routes/customer_folder/parcel_tracking_route.dart';
import 'package:doorstep_customer/ui/routes/customer_folder/ride_sharing/customer_welcome_route.dart';
import 'package:doorstep_customer/ui/routes/is_loading_route.dart';
import 'package:doorstep_customer/ui/routes/login_route.dart';
import 'package:doorstep_customer/ui/routes/onboarding_route.dart';
import 'package:doorstep_customer/ui/routes/re_authentication_route.dart';
import 'package:doorstep_customer/ui/routes/test_route.dart';
import 'package:doorstep_customer/ui/routes/unknown_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:doorstep_customer/_routing/router.dart' as routes;

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  
 await Firebase.initializeApp();
  setupRegister();


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

    statusBarColor:warmPrimaryColor.withOpacity(0.23),// status bar color
  ));
 //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
      title: 'Doorstep Business',
      theme: buildTheme(context),
      debugShowCheckedModeBanner: false,
      onUnknownRoute: (settings) {
          return CupertinoPageRoute(builder: (_) => UnknownRoute());
        },
       home:  FutureBuilder(
         future: register<UserModel>().init(),
         builder: (context, snapshot) {

    
          
        
            if (snapshot.hasError) {
          return AppInitErrorRoute();
        }
          
          if(snapshot.connectionState == ConnectionState.waiting){
          
            return IsLoadingRoute();
          }



          return const BookRidesScreen();
        return  TestRoute();
        //   return ChooseDeliveryTypeRoute();
        //   return CustomerWelcomeRoute();
        //   //  return ParcelSizesRoute();
        //  // return ParcelDetailsRoute();
        //   return ParcelTrackingRoute();
        //   return ParcelsHomeRoute();
        //  return HomeRoute();
        //  return SelectLocationOnMapRoute();
          //  return MyTestRoute();
        
          // return DailyParcelsStatisticsRoute();
          // return StatisticsRoute();
          // return DeliveryPersonelsRoute();
        //  return DeliveriesRoute();
        // return ReferAFriendRoute();
        // return AccountTopUpSuccessRoute();
        // return AccountTopUpRoute();
        // return BillPaymentSuccessRoute();
        // return BillDetailsConfirmationRoute();
        // return UsageAndBillingRoute();
          // return FleetDirectorHomeRoute();
        //  return  AddCompanyBranchDestinationsRoute(CompanyBranch(
            
        //    companyBranchID: 'Nsezq46UQMYmBYGsemZ0sNcp6m72',
        //    companyBranchName: 'Accra Circle Branch',
        //    companyBranchManagerName: 'Yussif Muniru'
        //     ),);

       //   return BranchOfficePersonelRoute(companyBranch: CompanyBranch(companyBranchID: 'Nsezq46UQMYmBYGsemZ0sNcp6m72'));

        // return AddManagerRoute(branchObj: CompanyBranch(companyBranchID: 'Nsezq46UQMYmBYGsemZ0sNcp6m72'));
       //   return BranchDetailsRoute(companyBranch: CompanyBranch(),);

        //  return BranchManagersRoute(companyBranch: CompanyBranch.fromMap({'total_number_of_parcels_sent': 0, 'number_of_destinations': 0, 
        //  'branch_manager_id':'Nsezq46UQMYmBYGsemZ0sNcp6m72',
        //  'company_branch_manager_email': 'branchmanager@gmail.com', 'total_amount_of_parcels_received': 0, 'company_branch_manager_phone': '0243333333', 'total_number_of_parcels_received': 0, 'total_amount_of_parcels_delivered': 0, 'company_branch_manager_gender': 'Male', 'company_branch_city_or_town': 'Accra', 'total_amount_of_parcels_sent': 0, 'company_branch_id': 'Nsezq46UQMYmBYGsemZ0sNcp6m72', 'company_branch_manager_name':' Branch Manager', 'company_branch_name': 'Accra Circle Branch', 'company_branch_address': 'Spintex', 'company_firestore_id': 'P8PwiVFGfGQpvtJGu6QQrUJND1L2', 'total_number_of_parcels_delivered': 0, 'timestamp': 1633210931444}));
            
        //  // return SelectLocationOnMapRoute();
       //   return DirectorHomeRoute();
       // return AddCourierCompanyBranchRoute();
          // return   WaitingCompanyAuthorizationRoute() ;
            // register<UserModel>().updateUserInfo(phoneNumber: "0241792877",fullname: 'Yussif Muniru');
           
         // return ReAuthRoute();
         // return SelectLocationOnMapRoute();
         // register<CompanyModel>().refreshCompanyModel(company: Company.fromMap({"company_firestore_id": "pUAYhe4tVOgyc542vQ7y7kT76UJ2", "director_firebase_uid": "Vipex Parcels", "company_name": "Vipex Parcels", "company_email": "yussifmunirium@gmail.com,", "company_tel": "0241792877", "company_tin_number": null, "city_of_operation": "Accra", "street_of_operation": "Spintex", "director_name": "Yussif Muniru", "company_logo_url": "https://firebasestorage.googleapis.com/v0/b/doorsteppay-50730.appspot.com/o/company_logo_files_dir%2Fimage_picker2145730666714369538.jpg??alt=media", "director_email": "yussifmunirium@gmail.com", "director_tel": "yussifmunirium@gmail.com", "director_phone_verification": false, "company_phone_verification": false, "company_head_office_location_name": "Asongman", "company_head_office_lat": "5.71261", "company_head_office_lng": "-0.2044712", "ghana_post_gps": "HG123-675", "bike_delivery_type": true, "car_delivery_type": true, "door_to_door_delivery": true, "inter_city_delivery": true, "bulk_inter_city_delivery": true, "inter_country_delivery": true, "total_number_of_branches": 1, "date_joined": 1631518780043})) ;

      ///    return BranchDetailsRoute(companyBranch:CompanyBranch());
     //  return BranchDetailsRoute(companyBranch: CompanyBranch(),);
         // Once complete, show your application
         if (snapshot.connectionState == ConnectionState.done) {
                    Map? snapshotData = snapshot.data! as Map<String,dynamic>;
                    if (!snapshot.hasData || !snapshotData['result']) {
                    
                        return OnboardingRoute();
                    }
                   
                    Map? res = snapshot.data! as Map<String, dynamic>;
                    print(res);
                    MyUser _user = res['user_data']; 
                   
                  
                  
                    // if the user is blocked the
                    if (_user.blocked) {
                      return BlockedRoute();
                    }

                    if(res['show_onboarding']){
                        return OnboardingRoute();
                    }

                    if(res['firebase_user'] != null && _user.firebaseUid.isNotEmpty){
                     
                       return ReAuthRoute();
                    }

            }

            return LoginRoute();
         }

         
       ),
      onGenerateRoute: routes.generateRoute,
      
    );
  
  }


   ThemeData buildTheme(context) {
    return ThemeData(fontFamily:true ? 'sfPro' : GoogleFonts.lato().fontFamily, visualDensity: VisualDensity.adaptivePlatformDensity).copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        },
      ),
    );
  }
}
