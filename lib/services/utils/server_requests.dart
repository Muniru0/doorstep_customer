import 'dart:convert';
import 'package:http/http.dart' as http;

class ServerRequests {
  
  // SERVER CONSTANTS
static const  String  INITIALIZE_SERVER = '0';
static const  String  SEND_OTP_CODE = '1';
static const  String  VERIFY_OTP_CODE = '2';
static const  String  STORE_NEW_USER_DATA = '3';
static const  String  ADD_COURIER_BUSINESS = '4';

  static http.Client httpClient = http.Client();

  static Future<Map<String,dynamic>> sendNetworkRequest(String requestType,
      {required Map params}) async {
    try {

      
      String queryString = customServerUrlEncode(params);
     
      String url =
          'https://us-central1-doorsteppay-50730.cloudfunctions.net/main?type=$requestType&$queryString';
      print(Uri.encodeFull(url));
 

      // http://localhost:5001/doorsteppay-50730/us-central1/myMain?type=8&fullName=Yussif%20Muniru&my_ticket_doc_id=%20&destination=KUMASI&phone_number=0241792877&ticket_payment=0&bus_operator=2M%20EXPRESS&user_docID=4Z4IAlsORIeOfMIGkI0q&drop=ejura&boarding=circle&notification=false&busn_number=k&location=ACCRA&estimated_ticket_fare=12

      var res = jsonDecode((await httpClient.post(Uri.parse(url))).body);

      print(res);
      return res;
    } catch (e) {
      print(e);
      return {
        'result': false,
        'desc': "Sorry,but device couldn't handle the server request."
      };
    }
  }

  static Future<Map> initServer() async {
    try {
      return {'result': true, 'desc': 'success'};
      var res = await sendNetworkRequest(INITIALIZE_SERVER,params: {});
      print('Server initialized: $res');
      return {'result': true, 'desc': res['desc']};
    } catch (e) {
      print(e);
      return {'result': false, 'desc': 'Error initializing functions.'};
    }
  }

  static Future<Map> sendOTPCodeRequest(String phoneNumber,firebaseUid) async {

    try {
      var res = await sendNetworkRequest(SEND_OTP_CODE,
         params: {'phone_number': phoneNumber,'firebase_uid': firebaseUid});
          print(res);
      return res;
    } catch (e) {
      return {
        'result': false,
        'desc': 'Sorry,device could not handle network request.'
      };
    }
  }

  static Future<Map> verifyOTPRequest(String phoneNumber, String code,firebaseUid,verificationType) async {
    if (phoneNumber.isEmpty)
      return {
        'result': false,
        'desc': 'Sorry, please re-enter the phone number.'
      };
    if (code.isEmpty) return {'result': false, 'desc': 'OTP Code is emtpy.'};

    try {
      return await sendNetworkRequest(VERIFY_OTP_CODE,
          params:{'phone_number': phoneNumber,'code':code,'firebase_uid':firebaseUid,'verification_type': verificationType});
    } catch (e) {
      return {
        'result': false,
        'desc': "Sorry,but device couldn't handle network request."
      };
    }
  }

  

 static String customServerUrlEncode(Map mapString){
   if(mapString.isEmpty){
     return '';
   }
    String queryString = '';
  mapString.forEach((key,element){
          queryString += '$key=$element&';
  });
  
 return queryString.substring(0,queryString.length-1);
 
 }
}

