

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class 
Constants{
 // APP DETAILS
 static const APP_NAME = "DoorsteP Business";
 static const APP_VERSION = "1.0.0";





// ROUTE CONSTANTS
 static const String SETTINGS_ROUTE = "/settings_route"; 
 static const String LOGIN_ROUTE = '/login_route';
 static const String RESET_PASSWORD_ROUTE = '/reset_password_route';
 static const String SET_NEW_PASSWORD_ROUTE = '/set_new_password_route';
 static const String BASE_ROUTE = '/base_route';
 static const String HOME_ROUTE = '/home_route';
 static const String ALL_BRANCHES_ROUTE = '/all_branches_route';
 static const String SUCCESSFULLY_ADDED_COURIER_BUSINESS_ROUTE = "/successfully_added_business_route";
 static const String  ADD_COURIER_AGENTS_ROUTE = "/add_courier_agents_route";
 static const String CONFIRM_COURIER_AGENT_DETAILS = "/confirm_courier_agent_detials";
 static const String SUCCESSFULLY_ADDED_COURIER_AGENT_ROUTE = "/success_courier_agent_route";
 static const String PREVIEW_IMAGE_ROUTE = "/preview_image_route";
 static const String ALL_SERVICES_ROUTE = "/all_services_route";
 static const String ADD_SUPERMARKET_ROUTE = "/add_supermarket_route";
 static const String ADD_SUPERMARKET_DETAILS_ROUTE = "/add_supermarket_details_route";
 static const String REGISTRATION_ROUTE = "/registration_route";
 static const String OTP_VERIFICATION_ROUTE = "/otp_verification_route";
 static const String CREATE_PASSWORD_ROUTE = "/create_password_route";
 static const String PERSONAL_INFORMATION_ROUTE = "/personal_information_route";
 static const String LOGIN_WITH_CREDENTIAL_ROUTE = "/login_with_credential_route";
 static const String COURIER_POSITIONS_ROUTE = "/courier_positions_route";
 static const String CONFIRM_PASSWORD_ROUTE = "/settings_route";
 static const String PARCELS_ROUTE = "/parcels_route";
 static const String PARCEL_DETAILS_ROUTE = "/parcels_details_route";
 static const String CONFIRM_PARCEL_DETAILS_ROUTE  = "/confirm_parcel_details_route";
 static const String ENTER_COURIER_SERVICE_INFO_ROUTE = "/enter_courier_service_info_route";
 static const String CONFIRM_COURIER_SERVICE_INFO_ROUTE = "/confirm_courier_service_info_route";
 static const String SUCCESSFUL_PARCEL_SENT_ROUTE = "/successful_parcel_sent_route"; 
 static const String CONFIRM_PARCEL_PICKUP_ROUTE = "/confirm_parcel_pickup_route";
 static const String SCAN_PARCEL_CODE_ROUTE = "/scan_parcel_code_route";
 static const String RECEIVING_OFFICER_HOME_ROUTE = "/receiving_officer_home_route";
 static const String COURIER_MANAGER_HOME_ROUTE = "/courier_manager_home_route"; 
 static const String SENDING_AGENTS_ROUTE = '/sending_agents_route';
 static const String RECEIVING_AGENTS_ROUTE = '/receiving_agents_route';
 static const String DELIVERED_PARCELS_ROUTE = '/delivered_parcels_route';
 static const String RECEIVED_PARCELS_ROUTE = '/received_parcels_route';
 static const String SENT_PARCELS_ROUTE = '/sent_parcels_route';
 static const String ALL_PARCELS_ROUTE = '/all_parcels_route';
 static const String DELIVERY_AGENTS_ROUTE  = '/delivery_agents_route';
 static const String SENDING_OFFICER_HOME_ROUTE = "/sending_officer_home_route"; 
 static const String SENDING_OFFICER_SETTINGS_ROUTE = "/sending_officer_settings_route";
 static const String ADD_courier_COMPANY_BRANCH_ROUTE = '/add_courier_company_branches_route';
 static const String WELCOME_ROUTE = '/welcome_route';
 static const String ADDITIONAL_VERIFICATION_ROUTE = 'additional_verificaiton_route';
 static const String ADDING_COMPANY_ROUTE = '/adding_company_route';
 static const String RECEIVING_OFFICER_SETTINGS_ROUTE = "/receiving_officer_settings_route";
 static const String  ADD_COMPANY_BRANCH_DESTINATIONS_ROUTE = 'add_company_branch_destinations_route';
 static const String ONGOING_ACTIVITIES_ROUTE = 'ongoing_activities_route';
 static const String COURIER_MANAGER_SETTINGS_ROUTE = "/courier_manager_settings_route";
 static const String SUCCESSFUL_PARCEL_PICK_UP_ROUTE = "/successful_parcel_pick_up_route";
 static const String PARCELS_FILTER_ROUTE = "/parcels_filter_route";
   static const String ADD_COMPANY_BRANCH_ROUTE = '/add_company_branch_route';
 static const String COURIER_SERVICE_BRANCH_MANAGER_HOME_ROUTE = '/branch_manager_home_route';
 static const String COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_HOME_ROUTE = '/branch_office_personel_home_route';
 static const String ADD_BRANCH_MANAGER_ROUTE = '/add_branch_manager_route';

 static const String SELECTED_LOCATION_ROUTE = '/selected_location_route';
 static const String SIGNUP_SUCCESS_ROUTE = '/signup_success_route';
 static const String TERMS_AND_CONDITIONS_ROUTE = '/terms_and_conditions_route';
 static const String PRIVACY_POLICY_ROUTE = '/privacy_policy_route';
 static const String FORGOT_PASSWORD_ROUTE = '/forgot_password_route';
 static const String PASSWORD_UPDATED_SUCCESSFULLY_ROUTE = '/password_update_successfully_route';
 static const String PARCEL_SENDING_OFFICERS_ROUTE = '/parcel_sending_officers_route';
 static const  String PARCEL_RECEIVING_OFFICERS_ROUTE = '/parcel_receiving_officers_route';
 static const  String PARCEL_DELIVERY_OFFICERS_ROUTE = '/parcel_delivery_officers_route';
   static const String WAITING_DIRECTOR_AUTHORIZATION_ROUTE = '/waiting_director_authorization_route';
 static const String APP_INFO_ROUTE = "/app_info_route";

 


  // NETWORK REQUESTS FLAG
  static const String SEND_OTP_NETWORK_REQUEST_FLAG = '1';
  static const String VERIFY_OTP_NETWORK_REQUEST_FLAG = '2';
  static const String FETCH_USER_PASSWORD_NETWORK_REQUEST_FLAG = '5';
  static const String DELETE_COMPANY_STAFF_NETWORK_REQUEST_FLAG = '9';
  static const String ADD_COMPANY_BRANCH_MANAGER_NETWORK_REQUEST_FLAG = '8';
  static String ADD_COMPANY_BRANCH_OFFICE_PERSONEL_NETWORK_REQUEST_FLAG = '10';
   static String ADD_COMPANY_BRANCH_DELVIERY_PERSONEL_NETWORK_REQUEST_FLAG = '14';
    static String DELETE_COMPANY_BRANCH_DELIVERY_PERSONEL_NETWORK_REQUEST_FLAG = '15';
  static const String DELETE_COMPANY_BRANCH_OFFICE_PERSONEL_NETWORK_REQUEST_FLAG = '11';
    static const String UPDATE_PRIVILEDGE_NETWORK_REQUEST_FLAG = '30';

  //FIREBASE STORAGE DIRECTORIES
    static const String USER_AVATARS_FIREBASE_STORAGE_DIRECTORY = 'user_avatars';


 //ASSETS SUBDIRECTORIES
 static const String IMAGES               = "assets/images/";
 static const String DATA                 = "assets/data/";


static const String YELLOW_PARCEL_ICON = "${IMAGES}parcel_2.png";
static const String EMPTY_GREYED_PARCEL_BOX = '${IMAGES}greyed_empty_parcel_box.png';
static const String LOGO = "${IMAGES}logo.png";
static const String PARCEL_ICON = '${IMAGES}parcel_icon.png';
static const String CROPPED_PARCEL_ICON = '${IMAGES}parcel_icon.png';
static const String COURIER_MANAGER_ICON = "${IMAGES}user.png";
static const String COURIER_SENDING_AGENT_ICON = "${IMAGES}user.png";
static const String COURIER_RECEIVING_AGENT_ICON = "${IMAGES}user.png";
static const List<String>  PARCEL_ICONS = ["${IMAGES}parcel_first_color.png", "${IMAGES}parcel_second_color.png", "${IMAGES}parcel_3_color.png", "${IMAGES}parcel_4_color.png", "${IMAGES}parcel_5_color.png", "${IMAGES}parcel_6_color.png","${IMAGES}parcel_7_color.png"];
static const String LOADING_SPINNER = '${IMAGES}loader-2.gif';
static const String YELLOW_PARCEL_ICON_PATH = '${IMAGES}yellow_parcel_icon.png';
static const String OPENED_ENVELOP_ICON = '${IMAGES}opened_envelop.png';
static const String DELIVERY_TRUCK_ICON = '${IMAGES}envelop.png';
static const String PARCEL_SIZE_7 ='${IMAGES}parcel_size_7.png';
static const String NO_BRANCH_ADDED_ICON ='${IMAGES}no_branch_added.png';
static const String DELIVERY_BIKE_ICON = '${IMAGES}delivery_bike_icon.png';
static const String DOORSTEP_LOGO_PATH = '${IMAGES}doorstep_logo.png';



  // Delivery Personel Constants
  static const String DELIVERY_PERSONEL_STATUS_IDLE = 'idle';


  // Parcel Delivery constants
  static const String PARCEL_DELIVERY_STATUS_EN_ROUTE = 'en route';





// API CONSTANTS

    static const String GOOGLE_WEB_SERVICES_MAPS_API_KEY = 'AIzaSyC9g8BWnukRKL7-iKThr_55FMa4VS3ljNY';
    static const String CUSTOM_MAP_STYLE_FILE_PATH = 'assets/data/maps_style.json';
    
// Extras
static const String UNIQUE_STRING = "jfalkkakfjaklsfj";


// allowed towns and cities
static const List<String> ALLOWED_TOWN_OR_CITIES = ['Accra','Kumasi','Tamale','Techiman','Sunyani','Goaso','Cape Coast','Accra','Tamale','Damongo','Nalerigu','Bolgatanga','Wa','Ho','Dambai','Takoradi','Wiawso'];

  static const String BUSINESS_STATS = '${IMAGES}business_stats.png';

  static const String DOCUMENT_WITH_PENCIL_ICON = '${IMAGES}document.png';

  static const String MAGNIFYING_GLASS_ICON = '${IMAGES}search.png';

  static const String STATEMENT_ICON = '${IMAGES}statement.png';

  static const String SECURED_TRANSACTIONS_ICON = '${IMAGES}secured_transactions_icon.png';

  static const String WALLET_AND_CARD_ILLUSTRATION = '${IMAGES}statement.png';


  static const String KITE_WITH_PHONE_ICON = '${IMAGES}phone_with_kite_illustration.jpg';

  static const String SIGNUP_ROUTE = '/signup_route';

  static const String EMAIL_VERIFICATION_ROUTE = '/email_verification_route';

  static const String ADD_COMPANY_BASIC_INFO_ROUTE ='add_company_basic_info_route';

  static const String USER_ICON = '${IMAGES}user_icon.png';

  static const String SELECT_LOCATION_MARKER = '${IMAGES}select_location_marker.png';

  static const String GENDER_MALE = 'Male';

  static const String GENDER_FEMALE = 'Female';

  static const String PHONE_WITH_WALLET_ICON = '${IMAGES}mobile_wallet.png';

  static const String GRAY_SEARCH_ICON = '${IMAGES}gray_search.png';

  static const String PARCEL_SIZE_1 = '${IMAGES}parcel_size_1.png';

  static const String DELIVERY_VEHICLE_TYPE_BIKE = '${IMAGES}scooter.png';

  static const String DELIVERY_VEHICLE_TYPE_CAR = '${IMAGES}delivery_car.png';

  static const String ADD_COMPANY_BASIC_INFO_CONTIND_ROUTE = '${IMAGES}add_company_basic_info_contind_route';

  static const String POLYLINE_JOINING_MARKERS = '${IMAGES}polyline_joining_markers.png';
  
  // phone verification types
  static const String IS_CUSTOMER_PHONE_VERIFICATION = '0';
  static const String IS_DIRECTOR_PHONE_VERIFICATION = '1';
  static const String IS_COMPANY_PHONE_VERIFICATION  = '2';
  static const String IS_COURIER_STAFF_PHONE_VERIFICATION = '3';
  


  // firestore constants
  static const String ROOT_APP_COLLECTION_NAME = 'public/';
  static const String COURIER_SERVICE_ROOT_DOC_PATH = '${ROOT_APP_COLLECTION_NAME}courier_service/';
  static const String ALL_COURIER_COMPANIES_COLLECTION_NAME = "companies";
  static const String COURIER_SERVICE_BRANCHES_COLLECTION_NAME = 'branches';
  static const String ALL_COURIER_SERVICE_DIRECTORS_COLLECTION_NAME= 'directors';
  static const String ALL_COURIER_SERVICE_COMPANIES_COLLECTION_NAME = 'companies';
  static const String COURIER_SERVICE_BRANCH_DESTINATIONS_COL = '${COURIER_SERVICE_ROOT_DOC_PATH}all_destinations/';
  static const String PARCELS_COLLECTION_NAME = 'parcels';
  static const String PARCELS_STATS_DOC_NAME = 'stats';
  static const String COURIER_SERVICE_PARCELS_COLLECTION_NAME = 'parcels';
  static const String  COURIER_SERVICE_DIRECTORS_COLLECTION_NAME = 'directors';
  static const String COURIER_SERVICE_BRANCH_MANAGERS_COLLECTION_NAME = 'branch_managers';
  static const String COURIER_SERVICE_OFFICE_PERSONEL_COLLECTION_NAME = 'office_personel';
  static const String COURIER_SERVICE_DELIVERY_COLLECTION_NAME = 'delivery_personel';
  static const String CUSTOMERS_COLLECTION_PATH = '${ROOT_APP_COLLECTION_NAME}customers/customers_profiles';
  static const  String COURIER_STAFF_COLLECTION_NAME = 'staffs_profiles';
  static const String COURIER_SERVICE_BRANCH_OFFICERS_COLLECTION_NAME = 'branch_officers';
  static const String COURIER_SERVICE_BRANCH_DESTINATIONS_COLLECTION_NAME = 'branch_destinations';

  static const  String ADD_COMPANY_BRANCH = '6';


  static const String RE_AUTH_ROUTE = '/re_auth_route';
  static const String COMPANY_ADDITION_SUCCESS_ROUTE = 'company_addition_success_route';
  static const String SELECT_LOCATION_ON_MAP_ROUTE = '/select_location_on_map_route';
  static const String COMPANY_LOGO_FILES_DIR = 'company_logo_files_dir';


    // CUSTOMER ROLE
  static const String CUSTOMER_ROLE = 'customer';

  static const String COURIER_SERVICE_DIRECTOR_ROLE = 'Courier Company Director';

  static const String COURIER_SERVICE_BRANCH_MANAGER_ROLE = 'Courier Company Branch Manager';

  static const String DELIVERIES_ROUTE = '/deliveries_route';
  static const String COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_ROLE = 'Courier Company Officer';

  static const String HOUR_GLASS_ICON = '${IMAGES}hour_glass.png';

  static const String COURIER_DIRECTOR_HOME_ROUTE = '/courier_director_home_route';

  static const String COMPANY_BRANCH_MANAGER_ROUTE = '/company_branch_manager_route';

  static const String COMPANY_OFFICER_ROUTE = '/company_officer_route';
  static const String ADD_COURIER_SERVICE_BRANCH_ROUTE ='/add_courier_company_branch_route';
  static const String ALL_MANAGERS_ROUTE = '/all_managers_route';
  static const String ALL_OFFICE_STAFFS_ROUTE = '/all_office_staffs_route';
  static const String ALL_DELIVERY_STAFFS_ROUTE = 'all_delivery_staffs_route';
  static const String BILL_DETAILS_CONFIRMATION_ROUTE = '/bill_details_confirmation_route';
  static const String ACCOUNT_TOP_UP_SUCCESS_ROUTE = '/account_top_up_success_route';
  static const String DIRECTOR_PROFILE_ROUTE = '/director_profile_route';


  static const String COMPANY_BRANCHES_ROUTE = '/company_branches_route';
  
  static const String UNKNOWN_ROUTE = '/unknown_route';
  static const String ACCOUNT_TOP_UP_ROUTE = '/account_top_up_route';
  static const String BILL_PAYMENT_SUCCESS = '/bill_payment_success';

  static const String REQUEST_TYPE_SEND_OTP_CODE = '1';

  static const  String REQUEST_TYPE_VERIFY_OTP_CODE = '2';
  static const String STORE_NEW_USER_DATA ='3';
  static const String REQUEST_TYPE_ADD_COMPANY = '4';

  static const String COMPANY_FIRESTORE_ROOT_DOC_PATH = 'public/parcels/companies/';
  static const String COMPANY_ADMIN_FIRESTORE_ROOT_DOC_PATH = 'admin/parcels/companies/';

  static const String LOCATION_LOADING_DOTS = '.......';

  static const  String TICK_ICON = '${IMAGES}tick.png';
  static const  String TRADEMARK_SYMBOL = '™';
  static const  String COPYRIGHT_SYMBOL = '©'; 
  static const  String RESPECT_SYMBOL   = '®'; 
   
  static const String COMPANY_CREATION_SUCCESS_ROUTE = '/company_creation_success_route';

  static const String ROOT_PARCELS_COL_ID = 'public/courier_service/';

  static const String COMPANIES_COL_ID = 'companies';

  static const String DIRECTORS_COL_ID = 'directors';

  static const String PARCELS_COL_ID = 'parcels';
  
    static const String OVERALL_COMPANY_STAFF_STATS = 'stats/company_staff_stats';
  static const String DAILY_PARCELS_STATS_COLLECTION_NAME = '__daily_parcels_stats';

  static const String DELIVERY_PERSONELS_ROUTE = '/delivery_personels_route';

  static const String PARCEL_DELIVERY_REQUESTS_ROUTE = '/parcel_delivery_requests_route';

  static const String PARCELS_STATISTICS_ROUTE = '/parcels_statistics_route';

  static const String USAGE_AND_BILLING_ROUTE           = '/usage_and_billing_route';

  static const String REVIEWS_ROUTE           = '/reviews_route';

  static const String INVITE_A_FRIEND          = '/invite_a_friend';

  static const String CEDI_SYMBOL = '₵';
  static const String ARROW_RIGHT = '→';

  static const String DIRECTORS_ROUTE = '/directors_route';

    static const double XTRMYY = 90.000000;

  static const double XTRMYX = 0.0000000;

  static const double XTRMXY = 6.6795069;
  static const double XTRMXX = 177.7955052;

  static const LatLng DEFAULT_LATLNG =  LatLng(5.708696077300338,-0.2004465088248253);
  static const double IDEAL_MAPS_ZOOM_FOR_NAVIGATION = 18.85194969177246;
  static const String CURRENT_LOCATION_ICON = '${IMAGES}current_location_icon.png';

  static const String MTN_MOMO_LOGO = '${IMAGES}mtn_momo_logo.png';

  static const String AVATAR_USER_ICON = '${IMAGES}avatar_user.jpg';
  static const String LARGE_SIZED_POLYTHENE_BAG_IMAGE_PATH = '${IMAGES}large_polythene_bag.png';
  static const String MEDIUM_SIZED_POLYTHENE_BAG_IMAGE_PATH = '${IMAGES}medium_polythene_bag.png';






  
 


 




  

  
 









  












 

  

  

  
 

  

  



  










  



  











  







  





  

 


  


 

 

  

 

 



 

  







 








 





  








}




// "®© ƒ∂ßç∫˜˙∆µ≤¬≤≥¬˚ˆ¨¥†®≈œå∑®†¥¨ˆøππ“‘«≠–ºª•¶§§∞¢££™¡`œ∑åß∂ƒ©"'
