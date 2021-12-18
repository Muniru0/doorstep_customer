import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/model_registry.dart';
import 'package:doorstep_customer/models/auth_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/validators.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class RegisterRoute extends StatefulWidget {
  @override
  _RegisterRouteState createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  // RegExp  alphaNumericFilter = RegExp("r[A-Z/0-9/a-z/@{1}/.]\w+");
  CustomAnimationControl _animationControl = CustomAnimationControl.PLAY;
  RegExp onlyDigitsFilter = RegExp(r"[0-9]");

  bool isOtpValid = false;
  late AuthModel _authModel;

  late OverlayEntry _overlayEntry;

  bool _showBlurredOverlay = false;

  bool isFullnameValid = false;

  bool isPhoneNumberValid = false;

  bool isEmailValid = false;



  @override
  void initState() {
    super.initState();
    _authModel = register<AuthModel>();
  }

 late double _w;
 late double _h;

  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<AuthModel>(
      showBlurredOverlay: _showBlurredOverlay,
      showSettingsIcon: false,
      screenTitle: "Register",
      child: Container(
        // margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 40.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15.0),
              child: Text("ENTER YOUR CREDENTIALS BELOW",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: warmPrimaryColor,
                    fontWeight: FontWeight.w900,
                  )),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30.0),
              width: _w * 0.667,
              child: Text("Use your credentials to register or login to 4pay",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: subHeadingsColor, fontSize: 12.0)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: UtilityWidgets.broadCustomTextField(_fullnameController,width: _w * 0.694444,
                  onChanged: (String value) {
                value = value.trim();

                if (filterFullname(value)) {
                  if (isFullnameValid) return;
                  setState(() => isFullnameValid = true);
                } else {
                  if (isFullnameValid) return;
                  setState(() => isFullnameValid = true);
                }
              },
                  symbol: "",
                  hint: "Enter your fullname",
                  isErrorBorder: (!isFullnameValid &&
                      _fullnameController.text.trim().length > 0)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: UtilityWidgets.broadCustomTextField(_phoneNumberController,width: _w * 0.694444,
                  digitsOnly: true, onChanged: (String phoneNumber) {
                phoneNumber = phoneNumber.trim();
                if (filterDigitsOnly(phoneNumber) && phoneNumber.length == 10) {
                  print("phone number valid");
                  if (isPhoneNumberValid) return;
                  setState(() => isPhoneNumberValid = true);
                } else {
                  print("phoneNumber invalid");
                  if (!isPhoneNumberValid) return;
                  setState(() => isPhoneNumberValid = false);
                }
              },
                  symbol: "",
                  hint: "Enter Your Phone Number",
                  isErrorBorder: (!isPhoneNumberValid &&
                      _phoneNumberController.text.trim().length > 0)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: UtilityWidgets.broadCustomTextField(_emailController,width: _w * 0.694444,
                  onChanged: (String email) {
                email = email.trim();

                if (filterEmail(email)) {
                  if (isEmailValid) return;
                  setState(() => isEmailValid = true);
                } else {
                  if (!isEmailValid) return;
                  setState(() => isEmailValid = false);
                }
              },
                  symbol: "",
                  hint: "Enter Your Email",
                  isErrorBorder: (!isEmailValid &&
                      _emailController.text.trim().length > 0)),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: UtilityWidgets.customConfirmationButton(context, () {
                if (isFullnameValid && isPhoneNumberValid && isEmailValid) {
                  _authModel.setRegDetails(
                      fullname: _fullnameController.text.trim(),
                      email: _emailController.text.trim(),
                      phoneNumber: _phoneNumberController.text.trim());
                  Navigator.pushNamed(
                      context, Constants.SELECTED_LOCATION_ROUTE);
                }
              },
                  confirmationText: "CONTINUE",
                  isLong: true,
                  isDisabled:
                      !(isFullnameValid && isPhoneNumberValid && isEmailValid)),
            ),
          ],
        ),
      ),
    );
  }

  static fadedCustomTextField(controller,
      {required FocusNode focusNode ,
      required Function(String text) onChanged,
      isErrorBorder = false,
      symbol = "₵",
      width = 250.0,
      marginTop: 0.0,
      marginBottom: 15.0,
      hint = '',
      vertPad: 10.0,
      horizPad: 10.0}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: vertPad, horizontal: horizPad),
      margin: EdgeInsets.only(bottom: marginBottom, top: marginTop),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            width: 0.5,
            color: isErrorBorder
                ? errorColor
                : Color(0xFF182e65).withOpacity(0.2)),
      ),
      child: Row(children: [
        Container(
          margin: EdgeInsets.only(right: 10.0),
          child: Text(symbol,
              style: TextStyle(
                  color: warmPrimaryColor, fontWeight: FontWeight.bold)),
        ),
        Container(
          width: width,
          padding: EdgeInsets.only(right: 15.0),
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: controller,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: warmPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            autofocus: true,
            cursorColor: warmPrimaryColor,
            decoration: InputDecoration.collapsed(
              hintText: hint,
              hintStyle: TextStyle(
                color: Color(0xFFd7e0ef),
                fontSize: 13,
              ),
            ),
            onChanged: onChanged,
          ),
        )
      ]),
    );
  }

}
