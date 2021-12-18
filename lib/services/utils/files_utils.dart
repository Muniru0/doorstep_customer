
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_customer/ui/utils/helper_functions.dart/functions.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';



 Future convertWidgetToImage({key, name = ""}) async {
  try {


    await Future.delayed(Duration(milliseconds: 500));

    RenderRepaintBoundary renderRepaintBoundary =
        key.currentContext.findRenderObject();

    ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 2.0);

      ByteData? byteData =  await boxImage.toByteData(format: ui.ImageByteFormat.png);


    return {'result': true,'data': byteData};
   
  } catch (e) {
    myPrint(e);
    return {'result':false,'desc': 'Error processing image'};
  }
}



Future<Map<String,dynamic>> getImage(ImageSource source)async{

    try{
    
    XFile? file = await ImagePicker().pickImage(source: source);

      return {'result': true, 'data': file};

    }on PlatformException catch(e){

      myPrint(e,heading: '${e.code} line 15 files_utils.dart');
      return {'result': false,'desc': e.message};

    }

}