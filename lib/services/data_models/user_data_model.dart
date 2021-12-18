
import 'dart:convert';

class MyUserDataModel {
  static const String FIREBASE_UID = 'firebase_uid';
  static const String AVATAR_URL = 'avatar_url';
  static const String PASSWORD = 'password';
  static const String USER_ROLE = 'user_role';
  static const String FULLNAME = 'fullname';
  static const String GENDER = 'gender';
  static const String ADDRESS = 'address';
  static const String DATE_OF_BIRTH = 'date_of_birth';
  static const String PHONE_NUMBER = 'phone_number';
  static const String TOWN_OR_CITY = 'town_or_city';
  static const String EMAIL = 'email';
  static const String DATE_JOINED = 'date_joined';
  static const String LAST_SIGN_IN_TIME = 'last_signin_time';
  static const String BLOCKED = 'blocked';
  static const String PHONE_VERIFICATION = 'phone_verification';
 

  


}

class MyUser {
  String firebaseUid;
  String userRole; 
  String avatarUrl;
  String email;
  String password;
  String? fullname;
  String phoneNumber;
  String dateOfBirth;
  String gender;
  String address;
  String townOrCity;
  bool phoneVerification;

  int dateJoined ;
  int lastSigninTime ;
  bool blocked;
  MyUser({
    this.firebaseUid = '',
    this.userRole = '',
    this.avatarUrl = '',
    this.fullname = '',
    this.email = '',
    this.password = '',
    this.dateOfBirth = '',
    this.gender = '',
    this.address = '',
    this.townOrCity= '',
    this.phoneNumber = '',
    this.dateJoined = 0,
    this.lastSigninTime = 0,
    this.phoneVerification = false,
    this.blocked = false,
  });

  factory MyUser.fromMap(Map<String, dynamic> json) => MyUser(
      firebaseUid: json[MyUserDataModel.FIREBASE_UID],
      userRole: json[MyUserDataModel.USER_ROLE],
      avatarUrl: json[MyUserDataModel.AVATAR_URL],
      fullname: json[MyUserDataModel.FULLNAME],
      email: json[MyUserDataModel.EMAIL],
      password: json[MyUserDataModel.PASSWORD],
      phoneNumber: json[MyUserDataModel.PHONE_NUMBER],
      address: json[MyUserDataModel.ADDRESS],
      townOrCity: json[MyUserDataModel.TOWN_OR_CITY],
      dateJoined: json[MyUserDataModel.DATE_JOINED],
      lastSigninTime: json[MyUserDataModel.LAST_SIGN_IN_TIME],
      phoneVerification: toBool(json[MyUserDataModel.PHONE_VERIFICATION]),
      blocked: toBool(json[MyUserDataModel.BLOCKED]),
      );

  Map<String, dynamic> toMap() => {
        MyUserDataModel.FIREBASE_UID: firebaseUid,
        MyUserDataModel.USER_ROLE : userRole,
         MyUserDataModel.AVATAR_URL : avatarUrl,
        MyUserDataModel.FULLNAME: fullname,
        MyUserDataModel.PHONE_NUMBER: phoneNumber,
        MyUserDataModel.EMAIL: email,
        MyUserDataModel.PASSWORD: password,
        MyUserDataModel.DATE_OF_BIRTH: dateOfBirth,
        MyUserDataModel.GENDER: gender,
        MyUserDataModel.ADDRESS: address,
        MyUserDataModel.TOWN_OR_CITY: townOrCity,
        MyUserDataModel.DATE_JOINED: dateJoined,
        MyUserDataModel.LAST_SIGN_IN_TIME: lastSigninTime,
        MyUserDataModel.PHONE_VERIFICATION: phoneVerification.toString(),
        MyUserDataModel.BLOCKED: blocked.toString(),

      };

  MyUser userFromJson(String str) {
    final jsonData = json.decode(str);
    return MyUser.fromMap(jsonData);
  }

  String userToJson(MyUser data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

  static bool toBool(input, {type = ''}) {
    return input == 1;
  }
}
