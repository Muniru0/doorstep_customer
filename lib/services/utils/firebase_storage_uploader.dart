import 'dart:io';
import 'package:doorstep_customer/constants/constants.dart';
import 'package:firebase_core/firebase_core.dart' as fc;
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';



class FirebaseFileUploader {

  fs.FirebaseStorage _firebaseStorage = fs.FirebaseStorage.instance;

  Future<Map<String,dynamic>> uploadFile(File file, {remoteDir = '',bool getDownloadUrl = true})async {
   
     UploadTask uploadTask;
    try{

      
      var remoteFilePath = '$remoteDir/${basename(file.path)}';

      uploadTask = _firebaseStorage.ref(remoteFilePath).putFile(file);

      if(getDownloadUrl){

        TaskSnapshot taskSnapshot = await uploadTask;

        if(taskSnapshot.state == TaskState.success){
          String downloadUrl   = await taskSnapshot.ref.getDownloadURL();
          
          return {'result':true, 'data':downloadUrl};
        }

        return {'result':false,'desc': 'Error uploading file, please try again.'};

      }
      
     
      return {'result':true,'data': uploadTask.snapshot };
      
    } on FirebaseException catch (e) {
      print(e.code);
      print(e);
      if (e.code == 'object-not-found') {
        return {
          'result': false,
          'desc': 'Unexpectedly losing access to file. please try again.'
        };
      }
      if (e.code == 'cancelled') {
        return {'result': false, 'desc': 'The upload was cancelled.'};
      }
      if (e.code == 'permission-denied') {
        return {'result': false, 'desc': 'Sorry upload failed.'};
      }
          return {'result': false, 'desc': 'An unexpected error occured.'};
    }
    
  }

  String fromDownloadLinkToString(String input){

     return input.contains(Constants.UNIQUE_STRING) ? Uri.encodeComponent(input).split('%2F').join(Constants.UNIQUE_STRING) : '';
   
 }


  String fromStringToDownloadLink(input){

      
         return input.contains('dhuhgk') ? Uri.decodeComponent(input).split('dhuhgk').join('%2Fthumb_') : '';
     return input.contains(Constants.UNIQUE_STRING) ? Uri.decodeComponent(input).split(Constants.UNIQUE_STRING).join('%2F') : '';

}

  Future<Map> moveFile(File? file) async {
    String docDir = (await getApplicationDocumentsDirectory()).path;

    final File movedImage = await file!.copy(
        '$docDir/${DateTime.now().millisecondsSinceEpoch}${extension(file.path)}');
    if (movedImage != null) {
      print(movedImage.path);

      print('---------------------------- yes moved us');
      return {'result': true, 'desc': movedImage};
    } else {
      print(movedImage.path);
      return {'result': false, 'desc': 'Error moving image.'};
    }
  }
}
