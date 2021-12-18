import 'dart:convert';




class SessionDataModel {
  static const String  FIREBASE_UID = 'firebase_uid';
  static const String FULLNAME = "fullname";
  static const String IS_SESSION_VALID = "is_session_valid";
  static const String BLOCKED = "blocked";
  static const String ADDRESS = "ADDRESS";
  static const String LAST_SIGN_IN_TIME = 'last_sign_in_time';
  static const String COMPANY_FIRESTORE_DOC_ID = 'company_firestore_doc_id';
  static const String  ROLE = 'user_role';
  static const String PHONE_NUMBER = "phone_number";
  static const String PHONE_VERIFICATION = 'phone_verification';
  static const String EMAIL_VERIFICATION = 'email_verification';
  static const String EMAIL = "email";
  static const String DIRECTOR_PHONE = 'director_phone';
  static const String DIRECTOR_PHONE_VERIFICATION = 'director_phone_verification';
  static const String DIRECTOR_EMAIL = 'director_email';
  static const String DIRECTOR_EMAIL_VERIFICATION = 'director_email_verification';
  static const String COMPANY_PHONE = 'company_phone';
  static const String COMPANY_PHONE_VERIFICATION = 'company_phone_verification';
  static const String COMPANY_EMAIL = 'company_email';
  static const String COMPANY_EMAIL_VERIFICATION = 'company_email_verification';
  static const String TOWN_OR_CITY = 'town_or_city';
  

  
 
 
}

class Session {
  String firebaseUid;
  String firestoreDocID;
  String fullname;
  String townOrCity;

  String phoneNumber;
  bool phoneVerification;

  String email;
  bool emailVerification;

  String directorPhone;
  bool directorPhoneVerification;
  
  String directorEmail;
  bool directorEmailVerification;

  String companyPhone;
  bool companyPhoneVerification;

  String companyEmail;
  bool companyEmailVerification;
  
  
  bool isSessionValid;
  String dateJoined ;
  String lastSigninTime;
  bool blocked;
  String address;
  
 


  Session(
      {
      this.firestoreDocID = '',
      this.firebaseUid = '',
      this.fullname = "",
      this.townOrCity = '',

      this.phoneNumber = "",
      this.email = '',
      this.phoneVerification = false,
      this.emailVerification = false,

      this.directorPhone = '',
      this.directorPhoneVerification = false,
      this.directorEmail = '',
      this.directorEmailVerification = false,

      this.companyPhone = '',
      this.companyPhoneVerification = false,
      this.companyEmail = '',
      this.companyEmailVerification = false,
  
      this.isSessionValid = false,
      this.address = '',
      this.blocked = false,
      this.dateJoined = '',
      this.lastSigninTime = ''
      });

  factory Session.fromMap(Map<String, dynamic> json) => Session(
      firebaseUid:  json[SessionDataModel.FIREBASE_UID],
      fullname: json[SessionDataModel.FULLNAME],
      townOrCity: json[SessionDataModel.TOWN_OR_CITY],

      phoneNumber: json[SessionDataModel.PHONE_NUMBER],
      phoneVerification: toBool(json[SessionDataModel.PHONE_VERIFICATION]),

      email:json[SessionDataModel.EMAIL],      
      emailVerification: toBool(json[SessionDataModel.EMAIL_VERIFICATION]),

      directorPhone: json[SessionDataModel.DIRECTOR_PHONE ],
      directorPhoneVerification: json[SessionDataModel.DIRECTOR_PHONE_VERIFICATION],

      directorEmail: json[SessionDataModel.DIRECTOR_EMAIL ],
      directorEmailVerification: json[SessionDataModel.DIRECTOR_EMAIL_VERIFICATION],

      companyPhone: json[SessionDataModel.COMPANY_PHONE],
      companyPhoneVerification: toBool(json[SessionDataModel.COMPANY_PHONE_VERIFICATION]),

      companyEmail: json[SessionDataModel.EMAIL_VERIFICATION],
      companyEmailVerification: toBool(json[SessionDataModel.EMAIL_VERIFICATION]),

      isSessionValid: toBool(json[SessionDataModel.IS_SESSION_VALID]),
      address: json[SessionDataModel.ADDRESS],
      blocked: toBool(json[SessionDataModel.BLOCKED]));

  Map<String, dynamic> toMap() => {
        SessionDataModel.FIREBASE_UID : firebaseUid,
        SessionDataModel.FULLNAME: fullname,
        SessionDataModel.TOWN_OR_CITY: townOrCity,
        SessionDataModel.PHONE_NUMBER: phoneNumber,
        SessionDataModel.PHONE_VERIFICATION: phoneVerification.toString(), 

        SessionDataModel.EMAIL: email,   
        SessionDataModel.EMAIL_VERIFICATION: emailVerification.toString(),  
       
        SessionDataModel.DIRECTOR_PHONE : directorPhone,
        SessionDataModel.DIRECTOR_PHONE_VERIFICATION: directorPhoneVerification.toString(),  

        SessionDataModel.DIRECTOR_EMAIL : directorEmail,
        SessionDataModel.DIRECTOR_EMAIL_VERIFICATION : directorEmailVerification.toString(),

        SessionDataModel.COMPANY_EMAIL : companyEmail,
        SessionDataModel.COMPANY_EMAIL_VERIFICATION : companyEmailVerification.toString(),
        SessionDataModel.IS_SESSION_VALID: isSessionValid.toString(),
        SessionDataModel.ADDRESS : address,
        SessionDataModel.BLOCKED: blocked.toString(),
      };

  static bool toBool(input, {type = ""}) {
    return input == 1;
  }
}

