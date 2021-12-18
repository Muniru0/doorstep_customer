
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/services/data_models/settings_data_model.dart';
import 'package:doorstep_customer/services/data_models/user_data_model.dart';
import 'package:doorstep_customer/services/utils/secure_store.dart';
import 'package:doorstep_customer/services/utils/shared_prefs.dart';
import 'package:doorstep_customer/ui/utils/helper_functions.dart/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';


class UserService {



  // firestore instance
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  Future<Map<String, dynamic>> initializeUser() async {
    try {
   
      return await SharedPref.initializeUser();
     
    } catch (e) {
      print('$e user service line 29');

      return {
        'result': false,
        'desc': 'Error initializing system.The app may not function properly.'
      };
    }
  }

 


  Future<Map> updateUserInfo(
      {
      String fullname = '',
      String email = '',
      String firebaseUid = '',
      String firestoreDocID = '',
      String phoneNumber = '',
      String gender = '',
      int lastSignInTime = 0,
      bool customerPhoneVerification = false,
      bool customerEmailVerification = false,
      bool directorPhoneVerification = false,
      bool directorEmailVerification = false,
      bool companyPhoneVerification = false,
      bool companyEmailVerification = false,
      bool blocked = false,
      String address = ''}) async {
   

    try {
      

      Map<String, dynamic> updateQueryString = {};

      if (fullname.isNotEmpty) {
         await SharedPref.updateSettings({SessionDataModel.FULLNAME: fullname});
          updateQueryString.putIfAbsent(MyUserDataModel.FULLNAME, () => fullname);
      }

      if (email.isNotEmpty) {
         await SharedPref.updateSettings({SessionDataModel.EMAIL: email});
          updateQueryString.putIfAbsent(MyUserDataModel.EMAIL, () => email);
      }
      if (phoneNumber.isNotEmpty) {
         await SharedPref.updateSettings(
            {SessionDataModel.PHONE_NUMBER : phoneNumber});
             updateQueryString.putIfAbsent(MyUserDataModel.PHONE_NUMBER, () => phoneNumber);
      }
      
      if (address.isNotEmpty) {
        updateQueryString.putIfAbsent(MyUserDataModel.ADDRESS, () => address);
 
      }
    
      if (gender.isNotEmpty) {
         updateQueryString.putIfAbsent(MyUserDataModel.GENDER, () => gender);
        
      }
      
      if (customerPhoneVerification) {
       
        await SharedPref.updateSettings({SessionDataModel.PHONE_VERIFICATION: customerPhoneVerification});

         updateQueryString.putIfAbsent(MyUserDataModel.PHONE_VERIFICATION, () => customerPhoneVerification);
      }

      if (lastSignInTime == 0) {
        updateQueryString.putIfAbsent(MyUserDataModel.LAST_SIGN_IN_TIME, () => lastSignInTime);
      }
      if (blocked != null) {
         await SharedPref.updateSettings({SessionDataModel.BLOCKED: blocked});
         updateQueryString.putIfAbsent(MyUserDataModel.BLOCKED, () => blocked);
      }

 var docID = await SharedPref.getValue(SessionDataModel.FIREBASE_UID);
    
      if(docID['result']){
      
   await _firebaseFirestore
          .doc('${Constants.CUSTOMERS_COLLECTION_PATH}/${docID['desc']}')
          .update(updateQueryString);
     print('stored data successfully @ $firestoreDocID as the firestore docID');
      return {'result': true, 'desc': ''};
   }else{
     print("Couldn't update the user info");
     return {'result': false, 'desc': 'Please for security reason logout and log in to update info.'};
   }

   

    } catch (e) {
      print(e);
      print('printed here too user 197 user Service');
      return {'result': false, 'desc': 'Sorry, updating info.'};
    }
  }



  Future<Map> isPasswordValid({password}) async {
    try {
      return await SecureStorage.confirmUserPassword(password);
    } catch (e) {
      print(e);
      return {'result': false, 'desc': 'Error confirming password.'};
    }
  }

  Future<Map<String,dynamic>> fetchUserByEmail({String email = ''}) async {
    try {
      myPrint(email,heading: 'User email');
      List<DocumentSnapshot> docs = (await _firebaseFirestore
              .collection(Constants.CUSTOMERS_COLLECTION_PATH)
              .where(MyUserDataModel.EMAIL, isEqualTo: email)
              .get())
              .docs;
              myPrint(docs.length);
      if (docs.length < 1) return {'result': true, 'data': null};
      myPrint(docs.first.data(),heading: 'User url');
      return {'result': true, 'data': MyUser.fromMap(docs.first.data() as Map<String,dynamic>)};
    } catch (e) {
      print(e);
      return {'result': false, 'desc': 'An unexpected error occured.'};
    }
  }

  Future<Map> confirmUserPassword({password = ''}) async {
    try {
      return await SecureStorage.confirmUserPassword(password);
    } catch (e) {
      return {
        'result': false,
        'desc': 'Unexpected Error validating user password.'
      };
    }
  }



  uploadImage({imageSource, remoteDir}) {}

  Future<Map> findUserBy(value,{phone = false, fullname = false, email = false}) async{

    try{
      var field;
        if(phone){
          field = MyUserDataModel.PHONE_NUMBER;
        }else if(fullname){
          field = MyUserDataModel.FULLNAME;
        }else{
          field = MyUserDataModel.EMAIL;
        }

      List<QueryDocumentSnapshot> docs =  (await _firebaseFirestore.collection(Constants.CUSTOMERS_COLLECTION_PATH)
        .where(field,isEqualTo:value ).get()).docs;

      if(docs.length > 0){
        return {"result": true, 'desc': docs.first.data()};
      }

      return {'result': false, 'desc': 'User Not found.'};

    }catch(e){
        print(e);
        return {'result': false, 'desc': "Unexpected error,please try again."};
    }
  }


}

