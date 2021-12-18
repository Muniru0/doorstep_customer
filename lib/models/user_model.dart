

import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/model_registry.dart';
import 'package:doorstep_customer/models/base_model.dart';
import 'package:doorstep_customer/services/data_models/user_data_model.dart';
import 'package:doorstep_customer/services/user_service.dart';
import 'package:doorstep_customer/ui/utils/helper_functions.dart/functions.dart';

class UserModel extends BaseModel {

  UserService _userService = UserService();


  MyUser _user = MyUser();
  MyUser get getUser => _user;
  
 
  Future<Map<String, dynamic>> init() async {
    try {


      // initialize the user info
      Map<String,dynamic> res = await _userService.initializeUser();
      
    

        return res;
    } catch (e) {
      print("$e user model line 37");
      return {"result": false, "desc": "ERROR"};
    }
  }


 void refreshUserModel({MyUser? user}) {
  
    if (user != null) {
      
      _user = user;

    }else{
  
      _user = getUser;
    }

    notifyListeners();
  }

  Future<Map> uploadImage(
      ) async {
    try {
     

      Map uploadImageRes = await _userService.uploadImage(
          imageSource: '', remoteDir: '');
      if (uploadImageRes["desc"] == null) return uploadImageRes;

      if (uploadImageRes["result"]) {
        var splittedRes = uploadImageRes["desc"].split(Constants.UNIQUE_STRING);
      
        return {"result": true, "desc": "success"};
      }

      return uploadImageRes;
    } catch (e) {
      print(e);
      return {
        "result": false,
        "desc": "An unexcepted error occured. Please try again later."
      };
    }
  }

  Future<Map> updateUserInfo(
      {
      String fullname = "",
      String email = "",
      String firebaseUid = "",
      bool phoneVerification = false,
      String phoneNumber = "",
      String address = "",
      int lastSignInTime = 0,
      bool blocked = false,
      String gender = ""}) async {
    try {
    
     var res;

        if (fullname.isNotEmpty) {
          getUser.fullname = fullname;
       res = await _userService.updateUserInfo(fullname: fullname);
        }

        if (email.isNotEmpty) {
          getUser.email = email;
           res = await _userService.updateUserInfo(email: email);
        }
        if (phoneNumber.isNotEmpty) {
          getUser.phoneNumber = phoneNumber;
           res = await _userService.updateUserInfo(phoneNumber: phoneNumber);
        }
        if (firebaseUid.isNotEmpty) {
          getUser.firebaseUid = firebaseUid;
           res = await _userService.updateUserInfo(firebaseUid: firebaseUid);
        }
        
        
        if (phoneVerification) {
          getUser.phoneVerification = phoneVerification;
          
          res = await _userService.updateUserInfo(customerPhoneVerification: phoneVerification);
        }

        refreshUserModel();
        return res;
    } catch (e) {
      print("$e printed in updateUserinfo userModel.");
      return {"result": false, "desc": "Sorry, Error saving data"};
    }
  }

 
  Future<Map> findUserBy(value, {phone = false,fullname = false,email =  false})async {

    var res;
      if(phone){
       res  = await _userService.findUserBy(value,phone:true);
      }else if(fullname){
       res  = await _userService.findUserBy(value,fullname:true);
      }else{
         res  = await _userService.findUserBy(value,email:true);
      }
     if(res['result']){
        // refresh the model with a new user if one is found
        refreshUserModel(user:MyUser.fromMap(res['desc']));

     }
    return res;

  }

  Future<Map<String,dynamic>> fetchUserByEmail({String email = ''}) async{

    return await _userService.fetchUserByEmail(email: email);
  }

  
  


}
