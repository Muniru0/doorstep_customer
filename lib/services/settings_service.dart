
import 'package:doorstep_customer/services/data_models/settings_data_model.dart';
import 'package:doorstep_customer/services/utils/shared_prefs.dart';


class SettingsService {
  Future<Map> updateSettings(settings) async {
    try {
      return await SharedPref.updateSettings(settings);
    } catch (e) {
      print(e);
      return {"result": false, "desc": ""};
    }
  }

  Future<Map> fetchSettings() async {
    try {
      return await SharedPref.fetchSettings();
    } catch (e) {
      print(e);
      return {"result": false, "desc": "Error reading settings."};
    }
  }

  Future<Map> fetchBasicInfo() async {
    try {
      return await SharedPref.getValues({
        SessionDataModel.FULLNAME,
        SessionDataModel.ADDRESS,
        SessionDataModel.PHONE_NUMBER,
        SessionDataModel.FIREBASE_UID
      });
    } catch (e) {
      print(e);
      return {"result": false, "desc": "Unexpected error fetching settings."};
    }
  }
}
