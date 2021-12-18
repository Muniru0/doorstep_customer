

import 'package:cloud_firestore/cloud_firestore.dart';

class CustomFirebaseFirestore {


FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;



 Map<String,dynamic>  col(colPath){
 
    try{
      
        return {'result': true, "desc": _firebaseFirestore.collection(colPath) } ;
    
    }catch(e){
      
      print(e);
      
      return {'result': false,'desc': 'Please contact admin if situation persists'};
    }


    }

  Map doc(docPath){
   
    try{
   
    return {'result': true, "desc": _firebaseFirestore.doc(docPath)};

 }catch(e){

   print(e);
   return {'result': false,'desc': 'Please contact admin if situation persists'};

 }

    }

    static colGroup(){
      
    }

}