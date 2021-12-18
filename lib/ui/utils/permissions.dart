

import 'package:permission_handler/permission_handler.dart';

class Permissions {

  static requestPermission() async{

    //  await PermissionHandler().requestPermissions([PermissionGroup.contacts,PermissionGroup.storage,PermissionGroup.phone,PermissionGroup.location]);

    //  PermissionStatus contactsPermission = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
    //  PermissionStatus storagePermission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    //  PermissionStatus phonePermission  = await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
    //  PermissionStatus locationPermission  = await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
     


    // if(contactsPermission == PermissionStatus.granted){
    //   print("Contacts Permission Granted Inside the Permissions Class");
    // }else{
    // print("Contacts Permission Denied Inside the Permissions Class");
    // }


    //  if(storagePermission == PermissionStatus.granted){
    //    print("Storage Permission Granted Inside the Permissions Class");
    //  }else{
    //    print("Storage Permission Denied Inside the Permissions Class");
    //  }
     

     
    // if(phonePermission == PermissionStatus.granted){
    //   print("Phone Permission Granted Inside the Permissions Class");
    // }else{
    // print("Phone Permission Denied Inside the Permissions Class");
    // }
     
    // if(locationPermission == PermissionStatus.granted){
    //   print("Location Permission Granted Inside the Permissions Class");
    // }else{
    //   print("Please Permission Denied Inside the Permissions Class");

    // }
     
     
//   void checkServiceStatus(BuildContext context, Permission permission) async {
//     Scaffold.of(context).showSnackBar(SnackBar(
//       content: Text((await permission.status).toString()),
//     ));
//   }

//   Future<void> requestPermission(Permission permission) async {
//      Permission.speech.request().then((value){
//  print(value.toString());
//      });
//      return;
//     final status = await permission.request();

//     setState(() {
//       print(status);
//       _permissionStatus = status;
//       print(_permissionStatus);
//     });
//   }

  }

 
}