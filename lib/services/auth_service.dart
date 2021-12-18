import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/services/data_models/settings_data_model.dart';
import 'package:doorstep_customer/services/data_models/user_data_model.dart';
import 'package:doorstep_customer/services/utils/firebase_storage_uploader.dart';
import 'package:doorstep_customer/services/utils/secure_store.dart';
import 'package:doorstep_customer/services/utils/server_requests.dart';
import 'package:doorstep_customer/services/utils/shared_prefs.dart';
import 'package:doorstep_customer/ui/utils/helper_functions.dart/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  

    // send otp 
    Future<Map<String,dynamic>> sendOTP({String phoneNumber = ''}) async {
   
     Map<String,dynamic> _userAuthIdTokenMap = await getAuthIdToken();

      if(!_userAuthIdTokenMap['result']){
        return {'result':false,'desc':'Sorry, app restart required.'};
      }
    return await ServerRequests.sendNetworkRequest(Constants.REQUEST_TYPE_SEND_OTP_CODE,params:{'phone_number': phoneNumber,'id_token': _userAuthIdTokenMap['data']});
    
    
      }



    // verify the otp of the user
    Future<Map> verifyOTP({String phoneNumber = '', String otp = '',firebaseUid = '',flag = Constants.IS_COURIER_STAFF_PHONE_VERIFICATION }) async {
            
              
            if (phoneNumber.isEmpty)
              return {
                "result": false,
                "desc": "Sorry, please re-enter the phone number."
              };
            if (otp.isEmpty) return {"result": false, "desc": "OTP Code is emtpy."};
        
            try {
              
              // get the users id token map
              Map<String,dynamic> _idTokenMap = await getAuthIdToken(); 
              
              // check for errors in getting the id token map
              if(!_idTokenMap['result']){
                return {'result':false,'desc': 'Internal system error, please try again later.'};
              }

              // send the request to the server
              var res = await ServerRequests.sendNetworkRequest(
                  Constants.REQUEST_TYPE_VERIFY_OTP_CODE,
                  params: {"phone_number":phoneNumber, "code":otp,"id_token":_idTokenMap['data'],"phone_verification_type":flag});
        
           // if the operation completed successfully
            if(res['result']){
              

                  if(flag == Constants.IS_CUSTOMER_PHONE_VERIFICATION){
                    SharedPref.updateSettings({'phone_verification': true});
                  }
                  if(flag == Constants.IS_DIRECTOR_PHONE_VERIFICATION){
                    SharedPref.updateSettings({'director_phone_verification': true});
                  }
                  if(flag == Constants.IS_COMPANY_PHONE_VERIFICATION){
                    SharedPref.updateSettings({'company_phone_verification': true});
                  }

                  try{

                 // force refresh the IdToken
                  await getCurrentUser()!.getIdToken(true);

                 var res =   await getUserAuthClaimns();
                 print('-------------AUTH CLAIMS USER SERVICE.dart ------------- the auth claims');
                 print(res);
                   }on FirebaseAuthException catch(e){

                    return {'result':false,'desc': getFirebaseAuthException(e.code)};
                  }
                
            }
        
              return res;
            } catch (e) {
              print(e);
              return {
                "result": false,
                "desc": "Something went wrong,please try again."
              };
            }
          }


     // signup the user with email and password   
    Future<Map<String,dynamic>?> signupUserWithEmailAndPassword({ String email = '',String password = '',String? fullname = '',String phoneNumber = '',dateOfBirth = '',String userRole = '', String gender = '', String townOrCity = '', String address = '',
        File? userAvatarFile}) async {
    
       
        try {
       User? newUser = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    
              
              if(newUser == null){
                   return {'result': false, 'desc': "Something went wrong, please restart the app to continue."};
              }
              
          newUser.updateDisplayName("$fullname");
          
           
       Map<String,dynamic> uploadRes = await  FirebaseFileUploader().uploadFile(userAvatarFile!,remoteDir:Constants.USER_AVATARS_FIREBASE_STORAGE_DIRECTORY);
     
                if(!uploadRes['result']){
                    newUser.delete();
                    myPrint(uploadRes,heading: 'The upload res');
                    return uploadRes;
                }

       

  
            String processedUrl = Uri.encodeComponent((uploadRes['data'].split('%2F').join('dhuhgk')));


            MyUser userObj = MyUser(fullname: fullname,userRole: userRole,email: email,password: password,phoneNumber: phoneNumber,dateOfBirth: dateOfBirth,gender: gender,address: address,townOrCity: townOrCity,);
           
     Map<String,dynamic> userObjMap = userObj.toMap();
        userObjMap['id_token'] =  await newUser.getIdToken();

          Map<String,dynamic> res =  await ServerRequests.sendNetworkRequest(Constants.STORE_NEW_USER_DATA,params:userObjMap);
          

          if(!res['result']){
              await newUser.delete();
              return {'result':false, 'desc': res['desc']};
          }

           await  newUser.getIdToken(true);
        
          
          // store the user's info in persistant storage
          await SharedPref.storeUser(userObj);

          // store not to show the user's onboarding route
          await SharedPref.updateSettings({'show_onboarding': false});
            
           
            // store the user's password locally
           await SecureStorage.storePassword(password);

           // return the final user obj
            return {"result": true, "desc": userObj};
      
        } on FirebaseAuthException catch (e) {
          print(e);
          print('Inside the auth service.dart file line 121');
          if (e.code == 'weak-password') {
            return {"result": false, "desc": "Sorry the password is too weak."};
          } else if (e.code == 'email-already-in-use') {
            return {
              "result": false,
              "desc": "Sorry the email is already in use by another account."
            };
          } else if (e.code == "too-many-requests") {
            return {
              "result": false,
              "desc":
                  "We requests from this device have being temporarily blocked due to unusual activity. Try again after some time"
            };
          } else if (e.code == "operation-not-allowed") {
            return {
              "result": false,
              "desc": "Error, Please contact us for resolution of this.Thank you"
            };
          } else {
            return {
              "result": false,
              "desc": "An unexpected error occured please try again."
            };
          }
        }
      }
    
  
    // get the current user
    User? getCurrentUser() {
        return _firebaseAuth.currentUser;
      }
 

    // sign the firebase user out
    Future<Map<String,dynamic>> signOut() async {
        try {
         
          await _firebaseAuth.signOut();
        return {'result': false,'data': 'success'};
         
        } on FirebaseAuthException catch (e) {
          myPrint(e.code,heading: 'Auth service line 193');
          return {'result': false,'desc': getFirebaseAuthException(e.code)};

        
      }
    }
    

    // check if the user's email is verified
   Future<Map> isEmailVerified()async {
    
        try {
          
          User? user = getCurrentUser();
          
        
            return {
              "result": false,
              "desc": "Your session expired,login to continue."
            };
          
          
          // reload the current user if signed in
          await user?.reload();
    
          // if the email is verified 
          if (user!.emailVerified) {
    
          // get the value of email verification stored locally
            var emailVerificationInSession = await SharedPref.getValue(SessionDataModel.EMAIL_VERIFICATION);
             
          // if it still shows not email not verified 
            if(emailVerificationInSession['result'] && !emailVerificationInSession['desc']){
             
              
              // update it to show verified
             await SharedPref.updateSettings({SessionDataModel.EMAIL_VERIFICATION: true });
            }
            return {"result": true, "desc": 'success'};
          }
    
          return {"result": false, "desc": "Email not verifiied yet."};
        } catch (e) {
          print("$e auth service.");
          
          return {
            "result": false,
            "desc":
                "Error getting verification information. Please try again later."
          };
        }
      }

  
   // send user verifcation email link 
   Future<Map> sendEmailVerificationLink()async {
    
        try {
          
          User? user = getCurrentUser();
       
            if (!user!.emailVerified) {
             await user.sendEmailVerification();
              return {'result': true, 'desc': true};
            }
            return {"result": true, "desc": false};
         
       
        }on FirebaseAuthException catch (e ) {
          print(e.code );
          print(e);
          if (e.code == "too-many-requests") {
            return {
              "result": false,
              "desc":
                  "This account has being temporarily blocked due to unusual activity please try again later."
            };
          }else if (e.code == "too-many-requests") {
            return {
              "result": false,
              "desc":
                  "This account has being temporarily blocked due to unusual activity please try again later."
            };
          }
          return {"result": false, "desc": "Unexpected Error, please try again."};
        }

      }
    

 
  // delete the user's accoutn
  Future<Map> deleteUser() async {
        try {
          User? user = getCurrentUser();
          if (user != null) {
            await user.delete();
            return {"result": true, "desc": ""};
          }
          return {"result": false, "desc": null};
        } catch (e) {
          return {"result": false, "desc": "Error Deleting User"};
        }
      }


   // send an email password reset link     
   Future<Map> sendPasswordResetLink(email) async {
        try {
          
          await _firebaseAuth.sendPasswordResetEmail(email: email);
          return {
            "result": true,
            "desc": "A reset password Link have sent to the email on file."
          };
        } on FirebaseAuthException catch (e) {
          print(e);
          return {
            "result": false,
            "desc": "Unexpected error sending password reset email."
          };
        }
      }
   


  // sign-in the user with email and password
  Future<Map> signInWithEmailAndPassword({String email = '', String password = '', String userRole = ''}) async{


      try{

              

                // store not to show the user's onboarding route
                 await SharedPref.updateSettings({'show_onboarding': false});

                User? _user;
                   
                  // atttempt to signin the user with the provided email and password 
                 UserCredential res = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
                  print(res.user);
                 
                if(res.user == null){
                      return {'result':false, 'desc': 'User credentials not found.'};
                  }

                  _user = res.user;


              // declare and initialize the signIn results map
              Map<String,dynamic> signInResultantMap = {'result': true,'phone_verification': false,'user_obj': null,'company_obj': null,'director_phone_verification': null,'company_phone_verification': null};

             // get the auth claims
             Map<String,dynamic> authClaimsRes = await getUserAuthClaimns();
           
                  if(!authClaimsRes['result']){
                  return {'result':false,'desc':'App restart required.'};
                  }      
                  
                  // update the resultant map with the user's phone verification
                  if(authClaimsRes['phone_verification']){
                    signInResultantMap['phone_verification'] = true;
                  }
                

            try{    
              // fetch the users doc from the collection of user documents
              DocumentSnapshot querySnapshot = await _firestore.doc(Constants.ROOT_APP_COLLECTION_NAME + Constants.CUSTOMERS_COLLECTION_PATH + '/' + _user!.uid).get();

                
                // if the doc doesn't exits, return an error msg
                if(!querySnapshot.exists){
                  
                  return {'result': false, 'desc': "Please try again later. If situation persists contact support."};
                }

                      

              // map the user firestore doc
                Map<String,dynamic>? userDoc = querySnapshot.data() as Map<String,dynamic>;
                    


                     // update the delivery personel role if necessary
                      // update the delivery personel role if necessary
                    if(userDoc[MyUserDataModel.USER_ROLE] == Constants.CUSTOMER_ROLE ){


                      if(userRole.isEmpty){
                        return {'result': true, 'update_user_role': ''};
                      }

                        var res = await getAuthIdToken();

                        if(!res['result']){
                          return res;
                        }

                        res = await ServerRequests.sendNetworkRequest(Constants.UPDATE_PRIVILEDGE_NETWORK_REQUEST_FLAG, params: {'id_token':res['data'],'from':userDoc[MyUserDataModel.USER_ROLE],'to': userRole});

                        if(!res['result']){
                          return res;
                        }
                    
                    }
                      
                    
                    
               
                // remove the password from entry from the users doc
                userDoc[MyUserDataModel.PASSWORD] = '';
              
                // create a userObj from the user doc
                MyUser _myUser = MyUser.fromMap(userDoc);

                // store the user data locally
               await SharedPref.storeUser(_myUser);

                // store the submitted password in secure store
                // because the there is no local data on the system.
                await SecureStorage.storePassword(password);

                
                // add the user obj to the signin results map
                signInResultantMap['user_obj'] = _myUser; 

                
            

              String companyDocID = '';
            
            // if the user is a director fetch the company's data with the director email flag
            if(authClaimsRes['user_role'] == Constants.COURIER_SERVICE_DIRECTOR_ROLE){
                  

           
                
               
                }



               
                 
      }on FirebaseException catch(e){
        myPrint(e.code,heading: 'firebase error code');
        if(e.code == 'unavailable'){
          return {'result': false,'desc': 'Please check your network connection and try again'};
        }
          return  {'result': false, 'desc': 'UnIdentified error, please try again.'};
        
      }
    return signInResultantMap;
      
      
      }on FirebaseAuthException catch(e){
       
        if (e.code == 'user-not-found') {
     return {'result': false, 'desc': 'Email and password mismatch.'};
       } else if (e.code == 'wrong-password') {

    return {'result': false, 'desc': 'Email and password mismatch.'};
       }else if (e.code == 'unknown') {

    return {'result': false, 'desc': 'Please check your internet connection and try again.'};
       }
       else{
     return {'result': false, 'desc': 'Error while authenticating,please try again later.'};
     }
        
       
      }

  }






  // update the user's password
 Future<Map?> updateUserPassword({String email = '',String newPassword = ''}) async{
   User? _user = getCurrentUser();
   try{
   
      User? _user = getCurrentUser();
     if(_user != null){

        await _user.updatePassword(newPassword);
       
        return {'result': true, 'desc':''};
     }

            
   }on FirebaseAuthException catch(e){
      if(e.code == 'requires-recent-login'){

           try{
      var res =  await ServerRequests.sendNetworkRequest(Constants.FETCH_USER_PASSWORD_NETWORK_REQUEST_FLAG,params:{'email':email});
     
        if(!res['result']){
          return res;
        }
          AuthCredential _authCredential = EmailAuthProvider.credential(email: email, password: res['desc']);
        

         
         await _user?.reauthenticateWithCredential(_authCredential);
         await _user?.updatePassword(newPassword);

         return {'result': true, 'desc':'sucess'};
           }on FirebaseAuthException catch(e){
            
             if(e.code == 'user-mismatch'){
               return {'result': false, 'desc': 'User not found.'};
             }else if(e.code == 'user-not-found'){
               return {'result': false,'desc': 'User not found.'};
             }else if(e.code == 'invalid-email'){
               return {'result': false, 'desc': 'Invalid email.'};
             }else if(e.code == 'invalid-credential'){
               return {'result': false, 'desc': 'Invalid credential.'};
             }else{
               return {'result': false, 'desc': 'Unexpected error, please try again later.'};
             }

           }

      }else if(e.code == 'weak-password'){
        return {'result': false, 'desc': 'Please provide a stronger password.'};
      }
      
   }
 }

   
   // get the user auth claims
  Future<Map<String,dynamic>> getUserAuthClaimns({Set? authTokenKeys }) async{


      try{

          // get the currently logged-in user
         User? _user = await getCurrentUser();

         // if the user is null return error 
         if(_user == null){
            return {'result': false,'desc': 'user not found.'};
         }

    // get the Id token result
    IdTokenResult _idTokenResult = await _user.getIdTokenResult();
   
       // check if the token result is empty
        if(_idTokenResult.claims!.isEmpty){
            return {'result': true,'desc': {}};
        }

        // declare the resultant map
        Map<String,dynamic> resultantMap = {'result': true};

        // if there are auth token keys to fetch
        // then fetch all the keys available in the auth token claims
        if(authTokenKeys != null){

              authTokenKeys.forEach((key) { 
             resultantMap[key] =  _idTokenResult.claims![key] ;

              });

        }else{
            // if the auth token keys not have being provided,
            // fetch only the values for the provided keys
              _idTokenResult.claims!.forEach((key, value) { 

                resultantMap[key] = value;

              });
          
       }
     
        return resultantMap;
      }on FirebaseAuthException catch(e){
        print('$e line 512 authservice.dart');
        // if(e.code == 'user-not-found'){
        //   return {'result':false ,'desc':'No user found'};
        // }
        return {'result':false,'desc':getFirebaseAuthException(e.code)};
      }
   }


  // get the user auth Id Token
  Future<Map<String,dynamic>> getAuthIdToken({bool forceRefresh = false})async{
    try{

      // get the current user
      User? _user = await getCurrentUser();

      //retrieve the auth id token
      String idToken = await _user!.getIdToken(forceRefresh);
      
      // return the results
      return {'result': true, 'data': idToken};
    }on FirebaseException catch(e){

      myPrint('$e 566 auth_service.dart');
      return{'result':false, 'desc':getFirebaseAuthException(e.code)};
    }
  }
 
 
 // confirm the user's locally stored passwordw
  Future<Map<String,dynamic>> confirmUserPassword(String password)async {
    try{

      return await SecureStorage.confirmUserPassword(password);

    }catch(e){
      print('$e line 573');
      return {'result': false,'desc': 'Unexpected error, please try again later.'};
    }
  }


// reauthenticate the user with password
  Future<Map<String,dynamic>> reauthenticateUserWithPassword(String password ,String userRole,{String companyDocID = ''} ) async{


      try{

              User? _user = await getCurrentUser();
              
              // check that the user exists
                if(_user == null){
                  return {'result': false,'desc':'Please sign-out completely and sign back in to continue.'};
                }

     
        Map<String,dynamic> confirmUserPasswordRes = await SecureStorage.confirmUserPassword(password);
        if(!confirmUserPasswordRes['result']){
            return confirmUserPasswordRes;
        }


       

      
      return {};
          }on FirebaseException catch(e){
           
               print( "$e line 573");
              return {'result':false, 'desc': getFirebaseAuthException(e.code)};

            }
  }


  // reauthenticate the user with biometrics
  Future<Map<String,dynamic>>reauthenticateWithBiometrics({String userRole = '',String companyDocID  =''})async {

    try{

      User? _user = await getCurrentUser();


      // if the user has signed-Out
      if(_user == null){
          return {'result': false,'desc': 'Please sign-Out completely and try again.'};

      }

     

      if(companyDocID.isNotEmpty){
     
        return {'result': true,'data': 'succes'};
      }
  

  return {};
   }on FirebaseAuthException catch(e){
      print('$e line 609');
      // catch all exceptions
      return {'result': false,'desc':getFirebaseAuthException(e.code)};
    }
  }


  // sign the user out completely
  Future<Map<String,dynamic>> signOutCompletely() async{


    try{


      // signout the user with firebase
      await signOut();

      // clear the user data from local storage
      await SharedPref.storeUser(MyUser());


      // clear the password stored in Secure Store
      await SecureStorage.storePassword(null);

      return {'result': true,'desc': 'success'};

    }on FirebaseAuthException catch(e){
      print('$e line 664');
      return {'result':false , 'desc': getFirebaseAuthException(e.code)};
    }
  }

   


  // helper method for getting firebase auth exception
  String getFirebaseAuthException(code){


    
    switch(code){
      case  'invalid-email':
      return "Email and password mismatch.";
      case 'user-not-found':
      return 'Email and password mismatch';
      case 'wrong-password':
      return 'Email and password mismatch';
     case 'email-already-in-use':
     return 'Please the email is already in use.';
     case 'weak-password':
     return 'Please provide a stronger password.';
     case 'invalid-credential':
     return 'Please the user credentials are mismatched';
     case 'user-mismatch':
     return 'Please sign-out completely and try again.';
     case 'network-request-failed':
     return 'Internet connection failed,please review your network settings.';

     default:return 'Authentication failed unexpectedly, please try again later.';
    }
  }

  



   
    }
    
  