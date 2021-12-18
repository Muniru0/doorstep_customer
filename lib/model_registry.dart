

import 'package:doorstep_customer/models/auth_model.dart';
import 'package:doorstep_customer/models/base_model.dart';
import 'package:doorstep_customer/models/parcels_model.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:get_it/get_it.dart';

GetIt register = GetIt.I;
void setupRegister(){

  // registering services
  register.registerSingleton<BaseModel>(BaseModel());
  register.registerSingleton<AuthModel>(AuthModel());
  register.registerSingleton<ParcelsModel>(ParcelsModel());
  register.registerSingleton<UserModel>(UserModel());


  // registering models
  // register.registerFactory<ErrorModel>(() => ErrorModel());

}
