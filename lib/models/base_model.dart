

import 'package:connectivity/connectivity.dart';

import 'package:scoped_model/scoped_model.dart';

class BaseModel extends Model{
 
bool isInternetServicesEnabled = false;
bool _connectionStatus = false;
bool _hasSubscribed = false;



  Map<String, dynamic> _dimensions = {};


get getHasSubscribed => _hasSubscribed;
void setHasSubscribed(hasSubscribed){
  _hasSubscribed = hasSubscribed;
  notifyListeners();
}

get getIsInternetServicesEnabled => isInternetServicesEnabled;
void setIsInternetServicesEnabled(bool internetServices){
  isInternetServicesEnabled = internetServices;
  notifyListeners();
}

get getConnectionStatus => _connectionStatus;
void setConnectionStatus({ connectionStatus }){

    _connectionStatus = connectionStatus;
 

 notifyListeners();
}


Stream<ConnectivityResult> subscribeToConStatus() {
  
  return Connectivity().onConnectivityChanged;
 
  
}

Map get screenDimensions => _dimensions;
void setDimensions(screenWidth, screenHeight) {
    _dimensions = {'w': screenWidth,"h":screenHeight};
    print("dimen set ${screenWidth} $screenHeight");
    notifyListeners();
  }

Future<bool> getCurrentConStatus()async{


 var result = await Connectivity().checkConnectivity();
   if(result == ConnectivityResult.none){
      
        setIsInternetServicesEnabled(false);
        return false;
       }else{
         print("has connection");
        
        setIsInternetServicesEnabled(true);
         return true;
       }

      
    
}


  
}
