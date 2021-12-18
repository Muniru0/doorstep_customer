
import 'package:doorstep_customer/models/base_model.dart';
import 'package:doorstep_customer/services/data_models/settings_data_model.dart';
import 'package:doorstep_customer/services/settings_service.dart';


class SettingsModel extends BaseModel {
  bool fingerprintAuth = false;
  SettingsService _settingsService = SettingsService();

  Session _session = Session();

  Future fetchSettings() async {
    // try{
    var res = (await _settingsService.fetchSettings());

    if (res["result"]) {
      refreshSettingsModel(settings: Session.fromMap(Map.from(res["desc"])));

      return {"result": true, "desc": ""};
    }
    return res;

    // }catch(e){
    //   print(e);
    // return {"result": false, "desc":"An Unexpected error."};
    // }
  }

  Session get getSession => _session;
  refreshSettingsModel({Session? settings}) {
    if (settings == null) {
      _session = getSession;
    } else {
      _session = settings;
    }

    notifyListeners();
  }

  Future<Map> updateSettings(
      {String userDocID = "",
      String fullname = "",
      String phoneNumber = "",
}) async {
    try {
      Map updateSettingsString = {};

      if (fullname.isNotEmpty) {
        getSession.fullname = fullname;
        updateSettingsString.putIfAbsent(
            SessionDataModel.FULLNAME, () => fullname);
      }

      if (phoneNumber.isNotEmpty) {
        getSession.phoneNumber = phoneNumber;
        updateSettingsString.putIfAbsent(
            SessionDataModel.PHONE_NUMBER, () => phoneNumber);
      }

      if (userDocID.isNotEmpty) {
        getSession.firestoreDocID = userDocID;
        updateSettingsString.putIfAbsent(
            SessionDataModel.FIREBASE_UID, () => userDocID);
      }

      refreshSettingsModel();
      var res = await _settingsService.updateSettings(updateSettingsString);

      if (res["result"]) {
        return {'result': true, "desc": ""};
      }

      return res;
    } catch (e) {
      print(e);
      return {"result": false, "desc": "Sorry, Error storing data on device."};
    }
  }



  Future<Map> fetchBasicInfo() async {
    try {
      var res = await _settingsService.fetchBasicInfo();
      if (res["result"]) {
        getSession.address = res["desc"][SessionDataModel.FULLNAME];
        getSession.phoneNumber = res["desc"][SessionDataModel.PHONE_NUMBER];
        getSession.address = res["desc"][SessionDataModel.ADDRESS];
        getSession.firestoreDocID = res["desc"][SessionDataModel.FIREBASE_UID];

        refreshSettingsModel();
        print(getSession.fullname);
        print(getSession.phoneNumber);
        print(getSession.address);
      }
      return res;
    } catch (e) {
      return {"result": false, "desc": "Unexpected error."};
    }
  }
}
