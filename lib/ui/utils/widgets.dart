

import 'dart:math';
import 'dart:ui' as ui;
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/services/data_models/parcel_data_model.dart';
import 'package:doorstep_customer/services/utils/local_auth.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:supercharged/supercharged.dart';

class OverlayChoice{

  final String choice;
  final  bool isSelected;
  final  void Function() choiceAction;
  final isLast;
  OverlayChoice({this.choice = '',required this.choiceAction ,this.isLast = false,this.isSelected = false});

}

class UtilityWidgets{




static Widget majorErrorWidget(desc,{double screenWidth = 0.0,String retryText = 'Retry',required VoidCallback onTap}){
  return  Center(
                child: Column(

            children: [

                SizedBox(height: 100.0,),
                SizedBox(
                  height: 40.0,
                  child: Icon(AntDesign.warning,color: silverColor,size: 30.0),
                ),

                Container(
                  width: screenWidth ,
                  alignment: Alignment.center,
                  height:35.0,
                  child: Text(desc,style: TextStyle(color: fadedHeadingsColor,fontSize: 13.5,fontWeight: FontWeight.bold))
                ),

                  InkWell(
                                  onTap: onTap,
                                  child: Container(
                  width: screenWidth,
                  alignment: Alignment.center,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(Ionicons.ios_refresh_circle_sharp,color: brightMainColor,size: 30.0)
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child:Text(retryText,style: TextStyle(color: brightMainColor,fontSize: 12.5,fontWeight: FontWeight.bold)),
                      ),
                    ]
                  ),
                                  ),
                                ),
                    
            ],

          ),
              );
        
}

static copyrightWidget(width){
  return  Container(
                 width: width,
                 alignment: Alignment.center,
                 margin: EdgeInsets.only(bottom:15.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('Copyright ',style: TextStyle(color: warmPrimaryColor.withOpacity(0.6),fontSize: 11.5)),
                     Container(
                       child: Text(Constants.COPYRIGHT_SYMBOL,style: TextStyle(color: warmPrimaryColor.withOpacity(0.6),fontSize: 11.5))
                     ),
                     Container(
                       
                       child: Text("2019 - ${DateTime.now().year.toString()} Doorstep LTD. ",style: TextStyle(color: warmPrimaryColor.withOpacity(0.6),fontSize: 11.5),
                     ),)
                   ],
                 )
               );
                 
}


static  refinedInformationDialog( {required BuildContext context, String desc = '', String title = '',required VoidCallback onTap,onTapText = 'Okay', color = brightMainColor, bool barrierDismissible = true}) {
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            actionsPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            titlePadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            buttonPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(
              padding: EdgeInsets.all(0.0),
              width: 270.0,
              height: 270.0,
              child: Column(children: <Widget>[
                Container(
                  width: 280.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                    color: color,
                  ),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 30, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width:150,
                        alignment:Alignment.center,
                          margin: EdgeInsets.only(left: 60),
                          child: Text(title,
                              style: TextStyle(
                                  color: white, fontWeight: FontWeight.bold))),
                      Expanded(child: SizedBox()),
                      InkWell(
                        splashColor: Colors.black.withOpacity(.3),
                        onTap: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20,right: 30.0),

                          child: Icon(Ionicons.md_close, size: 20,color: white),
                        ),
                      ),
                    ],
                  ),
                ),
               Expanded(child: SizedBox()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Text('$desc',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.7,
                        fontSize: 13,
                      )),
                ),

                Expanded(child: SizedBox()),

                  InkWell(
                  onTap: onTap,
                  child: Container(
                      width: 260,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: white,
                        border: Border(
                          top: BorderSide(
                            width: .5,
                            color: color,
                          ),
                        ),
                      ),
                      child: Text(onTapText,
                          style: TextStyle(color: color))),
                ),
          
              ]),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation) {return Container();});
}


static Widget proceedBanner({marginTop = 20.0,marginBottom: 20.0,icon = Feather.user,iconColor:warmPrimaryColor ,title = '', onTap, titleWidth = 252,}){
  return InkWell(
                           onTap:onTap,
                         child: Container(
                          //  color: Color(0xFFFFFFFF),
                            padding: EdgeInsets.only(top: marginTop,bottom: marginBottom,left: 15.0,right: 10.0 ),
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: Icon(icon, color: 
                                    iconColor,size: 17.0),
                                  ),

                                Container(
                                  
                                  child: Text(title, style: TextStyle(
                                        color: warmPrimaryColor,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w900 ,
                                      ),
                                    ),),
 Expanded(child: SizedBox()),
                                    Container(
                                      child: Icon(Ionicons.ios_arrow_forward, size: 14.0,color: warmPrimaryColor.withOpacity(0.7))
                                    ),
                              ])),
                         );
         
}
 
  static Widget proceedSelectionBanner({title = '',onTap,iconPath}) {
    return InkWell(
      onTap: onTap,
      splashColor: warmPrimaryColor.withOpacity(0.2),
      child: Container(
        child: Column(children: [
          Container(
            width: 360,
            height: 60,
            margin: EdgeInsets.only(bottom: 15.0),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Container(
              height: 55,
              width: 360.0,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                // Container(
                //   width: 60,
                //   alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //   ),
                //   child: Text('📍', style: TextStyle(fontSize: 18)),
                // ),
                Container(
                  margin: EdgeInsets.only(left: 7.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(title,
                                style: TextStyle(
                                    color: warmPrimaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))),
                      ]),
                ),
                Expanded(child: SizedBox()),
                // Container(child: Text('₵ ${Random().nextInt(100)}', style:TextStyle(color: warmPrimaryColor, fontSize: 11.0, fontWeight: FontWeight.bold) )),
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(Ionicons.ios_arrow_forward,
                         size: 17.0,
                         color: silverColor),
                  ),
                
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  static getToast(msg,  {textColor = black,position = 'b', duration = '1'}) {
    Fluttertoast.showToast(
      msg: msg,
      
      toastLength: duration == '1' ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: position == 'b' ? ToastGravity.BOTTOM : ToastGravity.CENTER,
      backgroundColor: Colors.grey.withOpacity(0.1),
      textColor: textColor,
      fontSize: 14.0,
    );
  }



  static Widget infoBanner(
      {title = '', onTap, enable = false, isLoading = false, bool isTitleThick = false}) {
    return Container(
        color: Color(0xFFFFFFFF),
        padding:
            EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0, right: 10.0),
        margin: EdgeInsets.only(bottom: 35.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            child: Text(title,
                style: TextStyle(
                  color:isTitleThick ? warmPrimaryColor : Color(0xFF91a3b7),
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            child: Row(
              children: [
                AnimatedOpacity(
                    opacity: isLoading ? 1.0 : 0.0,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: loadingIndicator(
                          width: 15.0,
                          height: 15.0,
                          valueColor: buttonBorderColor),
                    )),
                InkWell(
                  onTap: onTap,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.all(1.5),
                    width: 50.0,
                    height: 25.0,
                    alignment:
                        enable ? Alignment.centerRight : Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: enable ? Color(0xFF32cafa) : Color(0xFFf1f0f5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }



  static Widget whiteSelectionBanner({
    title = '',
    onTap,
    iconPath,
   String desc = '',
    isSelected = false,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: warmPrimaryColor.withOpacity(0.2),
      child: Container(
        child: Column(children: [
          Container(
            width: 360,
            height: 60,
            margin: EdgeInsets.only(bottom: 15.0),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Container(
              height: 55,
              width: 360.0,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Text('📍', style: TextStyle(fontSize: 18)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(title,
                                style: TextStyle(
                                    color: warmPrimaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))),
                        
                    Visibility(
                      visible: desc.isEmpty,
                                          child: Container(
                              child: Text(desc,
                                  style: TextStyle(
                                      color: fadedHeadingsColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))),
                    ),
                        
                      ]),
                ),
                Expanded(child: SizedBox()),
                AnimatedOpacity(
                  opacity: isSelected ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(AntDesign.check,
                        size: 20.0, color: buttonBorderColor),
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }




static Widget toggleBannerWithDesc(width,{title = "",desc="",enable,required void Function() enableAction, disableAction}){
return 
        Container(
          width: width,
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.only(top: 15.0,bottom: 12.0,left: 15.0,right: 10.0 ),
            
            height: 105.0 ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
    
    child: Text(title, style: TextStyle(
      color: warmPrimaryColor.withOpacity(0.65),
      fontSize: 13.0,
      fontWeight: FontWeight.w900 ,
    )),
      ),
      
      InkWell(
        onTap: (){
        
         if(enable){
  enableAction();
         }else{
disableAction();
         }
        },
  child: AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    padding: EdgeInsets.all(1.5),
    width: 50.0,
    height: 25.0,
    alignment: enable ? Alignment.centerRight : Alignment.centerLeft,
    decoration: BoxDecoration(
        color: enable ? Color(0xFF32cafa) : Color(0xFFf1f0f5),
        borderRadius: BorderRadius.circular(15.0),
    ),
    child:  Container(
        
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          
        ),
    ),

    ),
      ),

    
      
]),

          Container(
            margin:EdgeInsets.only(top: 12.0),
            child: Text(desc, style: TextStyle(color:Color(0xFFa3b4c8), fontSize: 12))
          ),
],
));
}
 



static Widget toggleButton({enable = true ,required void Function() enableAction, disableAction}){
return InkWell(
        onTap: (){
        
         if(enable){
           print('Enabled');
  enableAction();
         }else{
           print('Disabled');
disableAction();
         }
        },
  child: AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    padding: EdgeInsets.all(1.5),
    width: 50.0,
    height: 25.0,
    alignment: enable ? Alignment.centerRight : Alignment.centerLeft,
    decoration: BoxDecoration(
        //color:  Color(0xFF32cafa) ,
        color: brightMainColor,
        borderRadius: BorderRadius.circular(15.0),
    ),
    child:  Container(
        
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          
        ),
    ),

    ),
      );


}
  

static Widget toggleBanner(width,{title = "",enable = true ,required void Function() enableAction, disableAction}){
return 
        Container(
          width: width,
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.only(top: 15.0,bottom: 12.0,left: 15.0,right: 10.0 ),
            
            height: 105.0 ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
    
    child: Text(title, style: TextStyle(
      color: warmPrimaryColor.withOpacity(0.65),
      fontSize: 13.0,
      fontWeight: FontWeight.w900 ,
    )),
      ),
      
      InkWell(
        onTap: (){
        
         if(enable){
  enableAction();
         }else{
disableAction();
         }
        },
  child: AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    padding: EdgeInsets.all(1.5),
    width: 50.0,
    height: 25.0,
    alignment: enable ? Alignment.centerRight : Alignment.centerLeft,
    decoration: BoxDecoration(
        color:  Color(0xFF32cafa) ,
        borderRadius: BorderRadius.circular(15.0),
    ),
    child:  Container(
        
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          
        ),
    ),

    ),
      ),

    
      
]),

],
));
}
  
 static requestProcessingDialog(context,
      {title = 'Processing...', int duration = 400}) {
   
   showGeneralDialog(
    context: context,
    transitionDuration:Duration(milliseconds: duration),
    barrierLabel: "Processing",
    pageBuilder: (context,anim1,anim2){

    return AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(24.0,00.0,24.0,0.0),
    insetPadding: EdgeInsets.symmetric( horizontal: 10.0),
      content: 
              Container(
          
           height: 80.0,
          color: Color(0xFFFEFEFC),
          child: 
          Row(
            children: [
          Container(width: 25.0,height:125.0,margin: EdgeInsets.only(right: 15.0),child:Image.asset("assets/images/loader-2.gif", fit:BoxFit.cover)),
          Container(
            child: Text(title, style: TextStyle(color: warmPrimaryColor)),
          ),
          ]),
        ),
     
          
       
       
       );
    },
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context,anim1,anim2,child){
    
      
  return FractionalTranslation(
    translation: Offset(0, 1 - anim1.value),
    child: child,
  );
      
    },
   
  );


  }


 static broadRequestProcessingDialog(context,
      {title = 'Processing...', screenWidth}) {
    return showGeneralDialog(
      context: context,
      transitionDuration: Duration(milliseconds: 400),
      barrierLabel: 'processing',
      pageBuilder: (context, anim1, anim2) {
        return AbsorbPointer(
          absorbing: true,
          child: AlertDialog(
           // backgroundColor:Colors.transparent,
            contentPadding: EdgeInsets.fromLTRB(15.0, 00.0, 15.0, 0.0),
            insetPadding: EdgeInsets.symmetric(horizontal: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(20.0),
            ),
            content: Container(
              height: 220.0,
              width: 80.0,
             // color: Color(0xFFFEFEFC),
              padding: EdgeInsets.all(8.0),
             // margin:EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                    height: 30.0,
                    margin: EdgeInsets.only(right: 15.0,bottom: 30,top: 40.0),
                    child: loadingIndicator(width: 30.0)),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                      alignment: Alignment.center,
                  //  width: screenWidth != null ? screenWidth * 0.6 : null,
                    child: Text(title, style: TextStyle(color:warmPrimaryColor,fontSize: 14.0)),
                  ),
                ),
              ]),
            ),
          ),
        );
      },
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, anim1, anim2, child) {
        return FractionalTranslation(
          translation: Offset(0, 1 - anim1.value),
          child: child,
        );
      },
    );
  }

  

  static OverlayEntry confirmationOverlay(context, animControl,
      {desc = 'Are you sure you want to continue?',
      required VoidCallback cancelAction,
      confirmationText = 'NEXT',
      cancelText = 'CANCEL',
      required VoidCallback confirmAction,
      disFromBottom = 350.0,
      dialogWidth = 320.0}) {
    return OverlayEntry(
      builder: (context) => CustomAnimation<double>(
          control: animControl,
          tween: 0.0.tweenTo(350.0),
          duration: 400.milliseconds,
          curve: Curves.easeInOut,
          builder: (context, child, value) {
            return 
            Positioned(
              left: 17.5,
              bottom: value,
              width: dialogWidth,
              child: Material(
                color: Colors.transparent,
                child: Card(
                  elevation: 30.0,
                  child: Container(
                      //  padding:EdgeInsets.only(top: 15.0,right: 12.0,left: 12.0,bottom: 15.0),
                      padding: EdgeInsets.only(
                          top: 30.0, bottom: 20.0, left: 12.0, right: 12.0),
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(desc,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: warmPrimaryColor,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold,
                                  fontSize: subHeadingsSize)),
                        ),

                        //  Container(
                        //    margin:EdgeInsets.only(bottom: 20.0),
                        //    width: 290,
                        //    child: Row(
                        //      children: [
                        //        Container(
                        //          margin: EdgeInsets.only(right: 5.0),
                        //          alignment: Alignment.center,
                        //         decoration: BoxDecoration(

                        //            shape: BoxShape.circle,
                        //            border: Border.all(width: 1.5,color: warmPrimaryColor),
                        //          ),
                        //          child: Icon(AntDesign.checkMark, color:buttonBorderColor, size: 20.0),
                        //        ),
                        //        Container(
                        //          width: 250,
                        //          child: RichText(
                        //            textAlign: TextAlign.center,

                        //            text: TextSpan(
                        //              text: 'I have read and agree to ',
                        //              style: TextStyle(
                        //                color: warmPrimaryColor,
                        //                fontSize: 12.0,

                        //              ),
                        //              children: [
                        //                TextSpan(
                        //                  style: TextStyle(
                        //                    fontSize: 12.0,
                        //                    height: 1.4,
                        //                   decoration: TextDecoration.underline,
                        //                    color: Color(0xFF8aa6e5),
                        //                  ),
                        //                  text: 'the terms of use of'
                        //                ),
                        //                TextSpan(
                        //                  style: TextStyle(
                        //                     height: 1.4,
                        //                  ),
                        //                  text: ' 4PAY',

                        //                ),
                        //              ]
                        //            ),
                        //          ),
                        //        ),
                        //      ]
                        //    ),
                        //  ),

                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customCancelButton(context, cancelAction,
                                    cancelText: cancelText),
                                customConfirmationButton(context, confirmAction,
                                    confirmationText: confirmationText),
                              ]),
                        ),
                      ])),
                ),
              ),
            );
       
          }),
    );
  }



  static getOverlayWithTextField(context,{textFieldController,hint = "",title = "Please provide the input",desc = "",cancelAction,confirmAction,animControl,disFromBottom = 100.0,textAlign = TextAlign.center,required Function (String value) onChanged, double width = 270.0}){



  return getOverlay(context, animControl, 
    
          Container(padding:EdgeInsets.only(bottom: 20.0),child: Column(
        children: [
        
      Container(margin: EdgeInsets.only(top: 15.0,bottom: 10.0),child: Text(title,style: TextStyle(color: warmPrimaryColor,fontSize: 14.0,fontWeight: FontWeight.bold))),
          Container(width: width,margin: EdgeInsets.only(bottom: 10.0),child: Text(desc,textAlign: TextAlign.center,style: TextStyle(color: warmPrimaryColor,fontSize: 13))),
        Container(padding: EdgeInsets.symmetric(horizontal: 20.0),child: UtilityWidgets.fadedCustomTextField(textFieldController,focusNode: FocusNode(),onChanged: onChanged,symbol: "",hint: hint, textAlign: textAlign) ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
      
         Container(margin: EdgeInsets.only(left: 15.0),child: customCancelButton(context,cancelAction,cancelText: "CANCEL")),

         Container(margin: EdgeInsets.only(right: 15.0),child: customConfirmationButton(context,confirmAction,confirmationText:"CONFIRM" )),

     ],
   )
  ]
)),distanceFromBottom: disFromBottom);

  


  



  }
  
 static Widget blurredOverlay(){
     
     return  Positioned.fill(
                            child: Visibility(
                              visible: false,
                                   child: PlayAnimation<double>(
                                  tween:Tween<double>(begin: 0.0,end:5.0) ,
                                   duration: Duration(milliseconds: 200),
                                   builder: (context, child, value) {
                                    return Visibility(
                                      visible: !(value < 5.0),
                                      child: BackdropFilter(
                                        filter: ui.ImageFilter.blur(
                                          sigmaX: value,
                                          sigmaY: value,
                                        ),
                                        child: Container(
                                          color: Colors.white.withOpacity(0.05),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          );
   }           



  static overlayChoicesWidget(OverlayChoice _overlayChoice) {
    return InkWell(
      splashColor: warmPrimaryColor.withOpacity(0.05),
      onTap: _overlayChoice.choiceAction,
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            Text(_overlayChoice.choice,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _overlayChoice.isSelected
                      ? warmPrimaryColor
                      : warmPrimaryColor.withOpacity(0.5),
                )),
  Expanded(child: SizedBox(),),
                Visibility(
                  
                  visible: _overlayChoice.isSelected ,
                                  child: Container(
                    child: Icon(AntDesign.check,size: 20, color: warmPrimaryColor)
                  ),
                ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            width: 2.5,
            color: _overlayChoice.isLast ? Colors.white : warmSecondaryColor,
          )),
        ),
      ),
    );
  }



    static AnimatedPositioned scrollableChoicesOverlayWithTextField(context, animControl,
      {title = 'choose',
      onChanged,
      gravity = 'bottom',width = 320.0,
      scrollHeight = 140.0,
      distanceFromBottom = -300.0,
      showCancelButton = false,
      required TextEditingController controller,
      textFieldWidth = 250.0,
      required VoidCallback cancelAction,
     required FocusNode focusNode,
     required List choices,
      required Function(String value) textFieldOnChanged,required TextAlign textAlign,
      }) {
   

    

    return AnimatedPositioned(
              left: 17.5,
              bottom: distanceFromBottom,
              width: width,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: Material(
                color: Colors.transparent,
                child: Column(
                  
                  children: [
                    Card(
                        elevation: 30.0,
                        shadowColor: Colors.white,
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 15.0, right: 12.0, left: 12.0),
                            child: Column(children: [
                              Container(
                                width: 300,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(bottom: 12.9),
                                child: Text(title,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            warmPrimaryColor.withOpacity(0.8))),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    width: 2.5,
                                    color: warmSecondaryColor,
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                 
                                
                                },
                                child: Container(
                                  height:scrollHeight ,
                                  child: Column(
                                    children: [
                     UtilityWidgets.fadedCustomTextField(controller,autoFocus: true,symbol: '',onChanged: onChanged
                      
                            , 
                            
                            width: textFieldWidth , focusNode: focusNode,textAlign: TextAlign.start),
                                     
                                      Container(
                                        height: scrollHeight * 0.8,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding:EdgeInsets.all(0.0),
                                          itemCount: choices.length,
                                          itemBuilder: (context,i)=>UtilityWidgets.overlayChoicesWidget(choices[i]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ])),
                      ),
                    
                    Visibility(
                        visible: showCancelButton,
                        child: Container(
                            margin: EdgeInsets.only(top: 15.0),
                            child: UtilityWidgets.customConfirmationButton(
                                context, cancelAction,
                                confirmationText: 'CANCEL',
                                isLong: true,
                                isDisabled: false))),
                  ],
                ),
              ),
            );
  }


  static transactionSuccessDialog(context,amountSent, receipientName,transactionID,cancelAction, {duration: 400,}){


    showGeneralDialog(
    context: context,
    transitionDuration:Duration(milliseconds: duration),
    barrierLabel: "Error Authenticating transaction",
    pageBuilder: (context,anim1,anim2){

    return AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(24.0,20.0,24.0,0.0),
    insetPadding: EdgeInsets.symmetric( horizontal: 10.0),
      content: 
              Container(
           padding: EdgeInsets.only(top: 20.0),
           height: 300.0,
          //  color: secondaryColor,
         //  color: secondaryColor,
         color: Color(0xFFFEFEFC),
          child: Column(
          
           
                    children: [
                     
Container(width: 50.0, height:50.0,child:
                      Image.asset("assets/images/transac_success_note.png", fit: BoxFit.cover),),
                      Container(
                        margin: EdgeInsets.only(bottom:5.0),
                       alignment: Alignment.center,
                      child:  RichText(
                        text: TextSpan(
                          text: "Transaction",
                          style: TextStyle(
                            fontWeight:FontWeight.bold,
                            //color: Color(0xFF182e65)
                            fontSize: 15,
                            color: Color(0xFF65749b),
                          ),
                         
                          children: [
                            TextSpan(
                            text: "Success",
                            style: TextStyle(color:primaryColor),
                          ),]
                        ),
                      ),),
                 Container(
                   margin: EdgeInsets.only(bottom: 15.0),
                   child: RichText(
                        text: TextSpan(
                          text: "You have successfully transfered ",
                          style: TextStyle(
                            fontWeight:FontWeight.bold,
                            //color: Color(0xFF182e65)
                            fontSize: 11, 
                            // color: Color(0xFF65749b),
                            color: Color(0xFFb2bdcf),
                          ),
                         
                          children: [
                            TextSpan(
                            text: "GH₵ $amountSent ",
                            style: TextStyle(color:primaryColor,fontWeight: FontWeight.bold, fontSize: 13),
                          ),

                           TextSpan(
                            text: "to ",
                            style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "$receipientName",
                            style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),
                          ),
                          ]
                        ),
                      ),
                   
                
                 ),
           
           Container(
             height: 100,
             width: 300,
             margin: EdgeInsets.only(bottom: 17.0),
             padding:EdgeInsets.symmetric(horizontal: 10.0, vertical: 17.0),
            // color: Color(0xFFFEFEFC),
            
             alignment: Alignment.center,
             child: Column(
               children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(child: Text("Amount deducted", style: TextStyle(fontSize:12 ,color: Color(0xFF7991ab)))),

                      Container(child: Text("-GH₵$amountSent", style: TextStyle(fontSize:12 , color:warmPrimaryColor,fontWeight: FontWeight.bold) )),
                    ]
                  ),
                ),

                  Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(child: Text("Transaction ID", style: TextStyle(color: Color(0xFF7991ab), fontSize: 12))),

                      Container(child: Text("$transactionID", style: TextStyle(color:warmPrimaryColor,fontWeight: FontWeight.bold,fontSize:12) )),
                    ]
                  ),
                ),


               ]
             ),
           ),
         
                             InkWell(
                      onTap:cancelAction,
                      child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                         elevation: 20.0,
                        // shadowColor: Color(0xFF80D8FF),
                        shadowColor: Color(0xFFFFFFFF),
                        child: Container(
                            width: 300,
                          //  margin: EdgeInsets.only(bottom:10.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5,color:primaryColor ),
                            //  border: Border.all(width: 1.5,color:Color(0xFF80D8FF) ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                             alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical:                               12,horizontal: 10.0),
                            child: Text("CANCEL", style: TextStyle(color: Color(0xFF3c4e7e), fontWeight: FontWeight.bold)),
                            ),
                        ),
                    ),
                
                    // ]),),
                //),
                    ]),
        ),
     
          
       
       
       );
    },
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context,anim1,anim2,child){
    
      
  return FractionalTranslation(
    translation: Offset(0, 1 - anim1.value),
    child: child,
  );
      
    },
   
  );



  }


  static transactionErrorDialog(context,desc,cancelAction,{duration: 400}){

        showGeneralDialog(
    context: context,
    transitionDuration: Duration(milliseconds: duration),
    barrierLabel: "Error Authenticating transaction",
    pageBuilder: (context,anim1,anim2){

    return AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(24.0,20.0,24.0,0.0),
    insetPadding: EdgeInsets.symmetric( horizontal: 10.0),
      content: 
              Container(
          // padding: EdgeInsets.only(top: 20.0),
           height: 200.0,
          color: Color(0xFFFEFEFC),
          child: Column(
          
           
                    children: [
                      Container(
                       
                         width: 50, height:50,child:
                       Image.asset("assets/images/transac_error_arrow.png") 
                      ,
                       ),
                    
                      Container(
                       // width: 300,
                        margin: EdgeInsets.only(bottom:5.0),
                       color: Colors.white, 
                       alignment: Alignment.center,
                      child:  RichText(
                        text: TextSpan(
                          text: "Transaction",
                          style: TextStyle(
                            fontWeight:FontWeight.bold,
                           
                            color: Color(0xFF65749b),
                          ),
                         
                          children: [
                            TextSpan(
                            text: "Failed",
                            style: TextStyle(color:errorColor),
                          ),]
                        ),
                      ),),
                 Container(
                   margin: EdgeInsets.only(bottom: 37.0),
                   child: Text(desc, style: TextStyle(color:Color(0xFF93a5bb), fontSize: 12, )),
                 ),
        
         
                  // Container(
                     
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                             InkWell(
                      onTap: cancelAction,
                       child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                         elevation: 20.0,
                        // shadowColor: Color(0xFF80D8FF),
                        shadowColor: Color(0xFFFFFFFF),
                        child: Container(
                            width: 300,
                          //  margin: EdgeInsets.only(bottom:10.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5,color:primaryColor ),
                            //  border: Border.all(width: 1.5,color:Color(0xFF80D8FF) ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                             alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical:                               12,horizontal: 10.0),
                            child: Text("CANCEL", style: TextStyle(color: Color(0xFF3c4e7e), fontWeight: FontWeight.bold)),
                            ),
                        ),
                    ),
                
                    // ]),),
                //),
                    ]),
        ),
     
          
       
       
       );
    },
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context,anim1,anim2,child){
    
      
  return FractionalTranslation(
    translation: Offset(0, 1 - anim1.value),
    child: child,
  );
      
    },
   
  );



  }


  static doubleButton(title,VoidCallback onTap){}

  static requestSuccessDialog(context,
      {title = '', desc = '', duration: 400, cancelAction, cancelText = 'CANCEL'}) {
    showGeneralDialog(
      context: context,
      transitionDuration: Duration(milliseconds: duration),
      barrierLabel: 'Request Success',
      pageBuilder: (context, anim1, anim2) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
          insetPadding: EdgeInsets.symmetric(horizontal: 10.0),
          content: Container(
            padding: EdgeInsets.only(top: 20.0),
            height: 300.0,
            color: Color(0xFFFEFEFC),
            child: Column(children: [
              Container(
                width: 50.0,
                height: 50.0,
                child: Icon(AntDesign.check, color: Colors.green),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5.0),
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text: title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF65749b),
                      ),
                      children: [
                        TextSpan(
                          text: 'Success',
                          style: TextStyle(color: primaryColor),
                        ),
                      ]),
                ),
              ),

              Container(
                height: 100,
                width: 300,
                margin: EdgeInsets.only(bottom: 17.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 17.0),
                alignment: Alignment.center,
                child: Column(children: [
                  Container(
                    width: 300,
                      alignment: Alignment.center,
                      child: Text(desc,textAlign: TextAlign.center,
                          style: TextStyle(
                              color: warmPrimaryColor.withOpacity(0.4)))),
                ]),
              ),

              InkWell(
                onTap: cancelAction,
                child: Material(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  elevation: 20.0,
                  // shadowColor: Color(0xFF80D8FF),
                  shadowColor: Color(0xFFFFFFFF),
                  child: Container(
                    width: 300,
                    //  margin: EdgeInsets.only(bottom:10.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: primaryColor),
                      //  border: Border.all(width: 1.5,color:Color(0xFF80D8FF) ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
                    child: Text(cancelText,
                        style: TextStyle(
                            color: Color(0xFF3c4e7e),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),

              // ]),),
              //),
            ]),
          ),
        );
      },
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, anim1, anim2, child) {
        return FractionalTranslation(
          translation: Offset(0, 1 - anim1.value),
          child: child,
        );
      },
    );
  }

   static OverlayEntry signupConfirmationOverlay(
      context, animControl,
      {gravity = 'center',
     required VoidCallback handleCancellation,
     required VoidCallback termsOfUseTap,
     bool isPhoneVerification = true,
      distanceFromBottom = 250.0,
     required VoidCallback handleConfirmation,
      String credential = '',
      regType = 'Register account'}) {
    if (isPhoneVerification) {
      credential = credential.isNotEmpty
          ? '${credential.substring(0, 3)}-${credential.substring(3, 6)}-${credential.substring(6, 10)}'
          : '';
    }

    return OverlayEntry(
      builder: (context) => CustomAnimation<double>(
          control: animControl,
          tween: 0.0.tweenTo(distanceFromBottom),
          duration: 500.milliseconds,
          curve: Curves.easeInOut,
          builder: (context, child, value) {
            return Positioned(
              left: 17.5,
              bottom: value,
              width: 320,
              child: Material(
                color: Colors.transparent,
                child:
                  Card(
                    elevation: 30.0,
                    child: Container(
                        //  padding:EdgeInsets.only(top: 15.0,right: 12.0,left: 12.0,bottom: 15.0),
                        padding: EdgeInsets.only(
                            top: 30.0, bottom: 20.0, left: 12.0, right: 12.0),
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 7),
                            child: !isPhoneVerification
                                ? Text('Verify your account with Email:',
                                    style: TextStyle(
                                        color: warmPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: subHeadingsSize))
                                : Text('$regType with phone number:',
                                    style: TextStyle(
                                        color: warmPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: subHeadingsSize)),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            alignment: Alignment.center,
                            width: 200,
                            child: !isPhoneVerification
                                ? Text(credential,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: warmPrimaryColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: subHeadingsSize))
                                : Text(credential,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: warmPrimaryColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: subHeadingsSize)),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            width: 290,
                            child: Row(children: [
                              Container(
                                margin: EdgeInsets.only(right: 5.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1.5, color: warmPrimaryColor),
                                ),
                                child: Icon(AntDesign.check,
                                    color: buttonBorderColor, size: 20.0),
                              ),
                              Container(
                                width: 250,
                                child: InkWell(
                                  onTap: termsOfUseTap,
                                                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text: 'I have read and agreed to ',
                                        style: TextStyle(
                                          color: warmPrimaryColor,
                                          fontSize: 12.0,
                                        ),
                                        children: [
                                          TextSpan(
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                height: 1.4,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: buttonBorderColor,
                                              ),
                                              text: 'the terms of use of'),
                                          TextSpan(
                                            style: TextStyle(
                                              height: 1.4,
                                            ),
                                            text: ' ${Constants.APP_NAME}',
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customCancelButton(context, handleCancellation),
                                  customConfirmationButton(
                                      context, handleConfirmation,
                                      confirmationText: 'NEXT'),
                                ]),
                          ),
                        ])),
                  ),
                
              ),
            );
          }),
    );
  }



  static requestErrorDialog(context,{title, desc, cancelAction, duration: 600,cancelText = 'CANCEL'}) {
    showGeneralDialog(
      context: context,
      
      transitionDuration: Duration(milliseconds: duration),
      barrierLabel: '',
      pageBuilder: (context, anim1, anim2) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
          insetPadding: EdgeInsets.symmetric(horizontal: 10.0),
          content: Container(
            // padding: EdgeInsets.only(top: 20.0),
            height: 200.0,
            color: Color(0xFFFEFEFC),
            child: Column(children: [
              Container(
                width: 50,
                height: 50,
                child: Image.asset('assets/images/transac_error_arrow.png'),
              ),

              Container(
                // width: 300,
                margin: EdgeInsets.only(bottom: 5.0),
                color: Colors.white,
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text: title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF65749b),
                      ),
                      children: [
                        TextSpan(
                          text: ' Failed',
                          style: TextStyle(color: errorColor),
                        ),
                      ]),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 37.0),
                child: Text(desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF93a5bb),
                      fontSize: 12,
                    )),
              ),

              InkWell(
                onTap: cancelAction,
                child: Material(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  elevation: 20.0,
                  // shadowColor: Color(0xFF80D8FF),
                  shadowColor: Color(0xFFFFFFFF),
                  child: Container(
                    width: 300,
                    //  margin: EdgeInsets.only(bottom:10.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: primaryColor),
                      //  border: Border.all(width: 1.5,color:Color(0xFF80D8FF) ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
                    child: Text(cancelText,
                        style: TextStyle(
                            color: Color(0xFF3c4e7e),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),

              // ]),),
              //),
            ]),
          ),
        );
      },
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, anim1, anim2, child) {
        return FractionalTranslation(
          translation: Offset(0, 1 - anim1.value),
          child: child,
        );
      },
    );
  }



 static Widget infoBannerWithImage(_width,{iconPath: Constants.LOGO,title= "", desc: "",required VoidCallback onTap }){
   return  InkWell(onTap: onTap,
        child: Container(
                           width: _width,
                           height: 60,
                           margin:EdgeInsets.only(bottom:7.0),
                           padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
                           decoration: BoxDecoration(
                              
                               color: white,
                               borderRadius: BorderRadius.all(Radius.circular(10.0)),
                           ),
                         
                           child: Container(
                             height: 55,
                             width: 360.0,
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                
                                   CircleAvatar(
                                     radius: 20,
                                     backgroundColor: white,
                                     backgroundImage: AssetImage(iconPath),
                                   ),
                                //   ),
                                 
                                 Container(
                                   margin: EdgeInsets.only(left: 7.0),  
                                    child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                      
                                      Container(
                                         child: Text(title, style: TextStyle(color: warmPrimaryColor,fontSize: 15, fontWeight: FontWeight.bold))
                                       ),
                                        Container(
                                         
                                             child: Text(desc,style: TextStyle(fontSize: 12.0, color: Color(0xFF8987ab) ))
                                           ),
                                      ]
                                   ),
                                 ),
                                 Expanded(child: SizedBox()),
                                 Container(
                                    margin: EdgeInsets.only(right: 10),
                                   child: 
                                  Icon(Ionicons.ios_arrow_forward, size: 15, color: warmPrimaryColor.withOpacity(0.7)),
                                 ),
                               ]
                             ),
                           ),
                         ),
   );
                 
 }


 static OverlayEntry filterOverlay(BuildContext context,_overlayEntry,{title = "filter by",required List<OverlayChoice> choiceObj,gravity = "bottom",animControl,distanceFromBottom = 50.0, showCancelButton: false, VoidCallback? cancelAction}){
List<Widget> listOfOverlayChoices = [];

choiceObj.forEach((choice) { 
  listOfOverlayChoices.add(overlayChoiceWidget(choice));
}) ;



return OverlayEntry(
  builder: (context)=>
    
       CustomAnimation<double>(
       control: animControl,
       tween: 0.0.tweenTo(distanceFromBottom),
       duration: 400.milliseconds,
       curve: Curves.easeInOut,
        builder: (context, child,value) {
          return
           Positioned(
           
          left:17.5,
          bottom: 50.0,
          width: 320,
          child: Material(
           
            color: Colors.transparent,
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                       print("touch detected");
                 },
                 child: Card(
                    elevation: 30.0,
                   // shadowColor: Colors.transparent,
                   shadowColor: Colors.white,
                    child: Container(
                       padding:EdgeInsets.only(top: 15.0,right: 12.0,left: 12.0),
                      child: Column(
                        children: [
                         
                             Container(
                              width: 300,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(bottom: 12.9),
                              child: Text(title, style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warmPrimaryColor.withOpacity(0.8)
                              )),
                               decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                  width: 2.5, color: warmSecondaryColor,
                                )),
                              ),
                            ),
                         
                         InkWell(
                           onTap: (){
                             print("here");
                          _overlayEntry.remove();
                           },
                            child: Column(
                             children:listOfOverlayChoices,
                             ),
                         )
                            ]
                     ) 
                          
                          
                      ),
                    ),
                ),
              
                                 Visibility(visible: showCancelButton,child:Container(margin: EdgeInsets.only(top: 15.0),child: customConfirmationButton(context, cancelAction,confirmationText: "CANCEL", isLong: true,isDisabled: false))),
             
              ],
            ),
            ),
          );
        }
      ),
    




);
  
  
  }



  
 static detailsParametersWidget(Map data,{width = 320.0}){

  if(data.isEmpty) return;
 List<Widget> parameters = [];
data.forEach((title, desc) {
 parameters.add( 
    Row(
                    children: [
                      Expanded(
                         child: Container(
                          margin: EdgeInsets.only(bottom: 15.0),
                          
                         child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(title, style:TextStyle(color: Color(0xFF8e9eb5),fontSize: subHeadingsSize, fontWeight: FontWeight.bold )),
                              ),
                              Container(
                                
                                child: Text(desc, style:TextStyle(color:warmPrimaryColor ,fontSize: subHeadingsSize, fontWeight: FontWeight.w900 )),
                              ),

                            ],
                          ),
                        ),
                      ),
                 
                    ],
                  )
 )  ;    
 });


  return Container(
                width:width ,
                padding:EdgeInsets.symmetric(vertical: 15.0, horizontal: 13.0),
                margin: EdgeInsets.only(bottom: 30.0),
                color: white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:parameters
          ),
        );
}
  


static overlayChoiceWidget(OverlayChoice _overlayChoice){
     return  InkWell(
       splashColor: warmPrimaryColor.withOpacity(0.05),
            onTap: _overlayChoice.choiceAction,
            child: Container(
         width: 300,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(_overlayChoice.choice, style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color:_overlayChoice.isSelected ? warmPrimaryColor : warmPrimaryColor.withOpacity(0.5),
                  )),
                   decoration:  BoxDecoration(
                    border: Border(bottom: BorderSide(
                      width: 2.5, color: _overlayChoice.isLast ? Colors.white : warmSecondaryColor,
                    )),
                  ),
                  ),
     );
               
  }





 static OverlayEntry scrollableChoicesOverlay(context,animControl,{title = "choose",required List<OverlayChoice> overlayChoices,gravity = "bottom",distanceFromBottom = 50.0,width = 320.0, showCancelButton: false,required VoidCallback cancelAction, listHeight = 250.0}){




return OverlayEntry(
  builder: (context)=>
    
       CustomAnimation<double>(
       control: animControl,
       tween: 0.0.tweenTo(distanceFromBottom),
       duration: 400.milliseconds,
       curve: Curves.easeInOut,
        builder: (context, child,value) {
          return Positioned(
          left: 17.5,
          bottom: value,
          width: width,
          child: Material(
           
            color: Colors.transparent,
            child: Column(
              children: [
               
                 Card(
                    elevation: 30.0,
                   // shadowColor: Colors.transparent,
                   shadowColor: Colors.white,
                    child: Container(
                       padding:EdgeInsets.only(top: 15.0,right: 12.0,left: 12.0),
                      child: Column(
                        children: [
                         
                             Container(
                              width: 300,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(bottom: 12.9),
                              child: Text(title, style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warmPrimaryColor.withOpacity(0.8)
                              )),
                               decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                  width: 2.5, color: warmSecondaryColor,
                                )),
                              ),
                            ),

                            Container(
                              height: listHeight,
                              child: ListView.builder(
                                  itemCount:overlayChoices.length ,
                                  itemBuilder: (context, index) => overlayChoiceWidget(overlayChoices[index]),
                              ),
                            ),
                          
                            ]
                     ) 
                          
                          
                      ),
                    ),
                
              
                  Visibility(visible: showCancelButton,child:Container(margin: EdgeInsets.only(top: 15.0),child: customConfirmationButton(context, cancelAction,confirmationText: "CANCEL", isLong: true,isDisabled: false))),
             
              ],
            ),
            ),
          );
        }
      ),
    




);
  
  
  }



static OverlayEntry choicesOverlay(context,animControl,{title = "choose",required List<OverlayChoice> overlayChoices,gravity = "bottom",distanceFromBottom = 50.0,width = 320.0, showCancelButton: false,  VoidCallback? cancelAction}){
 List<Widget> _overlayChoices = [];

 overlayChoices.forEach((OverlayChoice overlayChoice) {
   _overlayChoices.add(overlayChoicesWidget(overlayChoice));
  });



return OverlayEntry(
  builder: (context)=>
    
       CustomAnimation<double>(
       control: animControl,
       tween: 0.0.tweenTo(distanceFromBottom),
       duration: 400.milliseconds,
       curve: Curves.easeInOut,
        builder: (context, child,value) {
          return Positioned(
          left: 17.5,
          bottom: value,
          width: width,
          child: Material(
           
            color: Colors.transparent,
            child: Column(
              children: [
               
                 Card(
                    elevation: 30.0,
                   // shadowColor: Colors.transparent,
                   shadowColor: Colors.white,
                    child: Container(
                       padding:EdgeInsets.only(top: 15.0,right: 12.0,left: 12.0),
                      child: Column(
                        children: [
                         
                             Container(
                              width: 300,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(bottom: 12.9),
                              child: Text(title, style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warmPrimaryColor.withOpacity(0.8)
                              )),
                               decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                  width: 2.5, color: warmSecondaryColor,
                                )),
                              ),
                            ),

                            Column(
                              children: 
                                _overlayChoices
                              ,
                            )
                          
                            ]
                     ) 
                          
                          
                      ),
                    ),
                
              
                  Visibility(visible: showCancelButton,child:Container(margin: EdgeInsets.only(top: 15.0),child: customConfirmationButton(context, cancelAction,confirmationText: "CANCEL", isLong: true,isDisabled: false))),
             
              ],
            ),
            ),
          );
        }
      ),
    




);
  
  
  }




 static changeAvatarWidget(width,{onTap, onDoubleTap, avatar , heroTag: Constants.YELLOW_PARCEL_ICON}){
  avatar ?? Image.asset(heroTag);


    return   Material(
            child: InkWell(
          onDoubleTap: onDoubleTap,
          onTap:onTap,
          splashColor: warmPrimaryColor.withOpacity(0.2),
            child: Container(
                   
                   child: Column(
                   
                     children: [
                       
                       Container(
                         width: width,
                         height: 60,
                         margin:EdgeInsets.only(bottom:15.0),
                         padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
                         decoration: BoxDecoration(
                            
                             color: white,
                             borderRadius: BorderRadius.all(Radius.circular(10.0)),
                         ),
                       
                         child: Container(
                           height: 55,
                           width: width,
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                Container(
                                 child: Text("Change Avatar", style: TextStyle(color: warmPrimaryColor.withOpacity(0.8),fontSize: 13, fontWeight: FontWeight.bold))
                                     ),
                               
                              Hero(
                                tag: heroTag,
                                child: Container(
                                   width: 55.0,
                                   child: avatar,
                                   ),
                              ),
                             ]
                           ),
                         ),
                       ),
                     ]
                   ),
                 ),
 ),
     );
   
  }



  // static Widget infoBanner(key, value){
  //   return 
  // Container(
  //           margin: EdgeInsets.only(bottom: 7.0, top: 15.0),
  //           padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 10.0),
  //           width: double.infinity,
  //           color: white,
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.only(right: 10.0),
  //                 child: Text(key,style: TextStyle(color: Color(0xFFc8d2de), fontSize: 13.0, )),
  //               ),
  // //               InkWell(
  // //                 onTap: ()async{

  // //                   if(showBalanceInWallet) {
  // //                     setState(() =>showBalanceInWallet = false); 
  // //                    return;
  // //                   }

  // //  Map res = await requestLocalAuth();

  // //  if(res.containsKey("result") ){
  // //     if(res["result"]){
  // //     setState((){
  // //       showBalanceInWallet = !showBalanceInWallet;
  // //     });
  // //     }
  // //  }
  // //                 },
  // //                                 child: Container(
  // //                   child: Icon(Feather.eye,  color:showBalanceInWallet ? Color(0xFF70dffa) :Color(0xFFc8d2de) , size: 15 ),
  // //                 ),
  // //               ),
            
            
  //               Expanded(child: SizedBox()),
  //               // AnimatedOpacity(
  //               //   opacity: showBalanceInWallet ? 1.0 : 0.0 ,
  //               //   duration: Duration(milliseconds: 400),
  //               //   curve: Curves.easeInOut,
  //               //   child:
  //                  Container(
  //                                child: Text(value, style: TextStyle(color: warmPrimaryColor, fontSize: 16.0)),
  //                 ),
  //            //   ),
  //             ]
  //           ),
  //         );  
     
       
  // }



 static Widget customConfirmationButton(context, VoidCallback? onTap,{confirmationText = "CONFIRM", isLong = false, isDisabled = false} ){
  var screenWidth = MediaQuery.of(context).size.width;
return 
AnimatedOpacity(
  opacity:isDisabled ? 0.4 : 1.0,
  duration: Duration(milliseconds: 700),
  curve: Curves.easeInOut,
  child:   
 
                          Material(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                           elevation: 30.0,
                         
                          shadowColor: Color(0xFFFFFFFF),
                          child: InkWell(
                            onTap: onTap,
                                                      child: Container(
                                width: isLong  ? screenWidth * 0.92 : 130,
                                decoration: BoxDecoration(
                                  border: isDisabled ? null : Border.all(width: 1.5,color:  goldColor ),
                                
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                 alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical:                               12,horizontal: 10.0),
                                child: Text(confirmationText, style: TextStyle(color: warmPrimaryColor, fontWeight: FontWeight.w700, fontSize: 12.0)),
                                ),
                          ),
                          ),
                      



);

  }


  static Widget customCancelButton(context, void Function() onTap, {cancelText = "CANCEL", isLong = false, isDisabled: false}){
     
    var screenWidth = MediaQuery.of(context).size.width;
   
   return  Opacity(
     opacity: isDisabled ? 0.2 : 1.0,
        child: InkWell(
        onTap:onTap,   child: Material(
                           
                             borderRadius: BorderRadius.circular(5.0),  
                            child: Container(
                             width:isLong ? screenWidth * 0.92 : 130,
                                decoration: BoxDecoration(
                             //   color: Color(0xFF80D8FF),
                             color: primaryColor,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                 alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 12.75,horizontal: 10.0),
                                child: Text(cancelText, style: TextStyle(color: Colors.white)),
                                ),
                            ),
                          ),
   );
  }
  




  static Widget searchBarWidget({width,textFieldController, hint, isLong = false, elevation = 5.0}){
    return Container(
   margin: EdgeInsets.only(right: 20.0),
      child: Material(
        elevation: elevation,
         borderRadius: BorderRadius.circular(14.0),
        child: Container(
          width: isLong ? width * 0.9 :  width * 0.7,
          padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 10.0),
         // margin: EdgeInsets.only(left: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Row(
            children: [
              Container(
                child: Icon(Feather.search, size: 15.0, color: silverColor) ,
              ),

                 Container(
                   margin: EdgeInsets.only(left: 10.0),
                            width: width * 0.55,
                             padding: EdgeInsets.only(right: 15.0), child: TextField(
                             
                              controller: textFieldController,
                            
                             textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 11,
                                color: warmPrimaryColor,
                                fontWeight : FontWeight.bold,
                              ),
                           
                              cursorColor: warmPrimaryColor,
                              decoration: InputDecoration.collapsed(
                                hintText: hint,
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 13,
                                ),
                              ),
                              onChanged: (String parcel){

                              },
                            ),
                          ),
            

            ],
          ),
        ),
      )
    ) ;
  }




 static Widget  parcelWidget(context,Parcel parcel,{width  = 360.0}){
var senders = ["Kwame Ibrahim", "Osman kareem", "Abdulai Mubarik", "Hafiz Elias","Muniru Yussif","Alhassan Yazeed", "Asmat Wulon"];


 var isDelivered = Random().nextInt(5) > 3;
 double rating = double.tryParse(Random().nextInt(5).toString()) as double;
return  
 InkWell(
   onTap: (){
     Navigator.pushNamed(context, Constants.PARCEL_DETAILS_ROUTE);
   },
    child: Container(
                 
                 child: Column(
                 
                   children: [
                     
                     Container(
                       width: width,
                       height: 75,
                       padding: EdgeInsets.only(left: 8.0,right: 8.0),
                       decoration: BoxDecoration(
                           //color: Color(0xFFf7f7fa),
                          // color: white,
                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
                       ),
                     
                       child: Container(
                         height: 55,
                         width: 360.0,
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               width: 55.0,
                               height: 75.0,
                               alignment: Alignment.center,
                               margin: EdgeInsets.only(right: 10.0),
                               decoration: BoxDecoration(
                                 // color: true ? Color(0xFFeceef0) :  circleColor,
                                 shape: BoxShape.circle,
                               ),
                              
                               child: ClipRRect(borderRadius:BorderRadius.circular(0.0) ,child: Container(height: 75.0,width: 75.0,decoration: BoxDecoration(shape: BoxShape.circle),child: Image.asset('assets/images/parcel_size_${Random().nextInt(10)}.png', fit: BoxFit.cover)))),
                             
                             Container(
                               margin: EdgeInsets.only(left: 7.0),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                     child: Text(senders[Random().nextInt(6)], style: TextStyle(color: warmPrimaryColor,fontSize: 13.5, fontWeight: FontWeight.bold))
                                   ),
                                 
                                  //  Row(
                                  //    children: [
                                  //      Container(
                                  //        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 3 ),
                                  //       //  decoration: BoxDecoration(
                                  //       //    color: Color(0xFFf7f7fa),
                                  //       //    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  //       //  ),
                                  //        child: Text("status:", style: TextStyle(fontSize: 12, color: primaryColor,fontWeight: FontWeight.bold))
                                  //      ),
                                       
                                  //      Container(
                                  //        margin: EdgeInsets.only(right: 30.0),
                                  //        child: Text("OnRoute",style: TextStyle(fontSize: 13.0, color:  Color(0xFF8987ab)))
                                  //      ),
                                    
                                       
                                  //    ],
                                  //  ),
                              
                                   Row(
                                     children: [
                                      //  Container(
                                      //    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 3 ),
                                      //    decoration: BoxDecoration(
                                      //      color: Color(0xFFf7f7fa),
                                      //      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      //    ),
                                      //    child: Text("from:", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color:primaryColor))
                                      //  ),
                                       
                                       Container(
                                       //  margin: EdgeInsets.only(right: 30.0),
                                         child: Text("Kumasi ",style: TextStyle(fontSize: 11.5, color: Color(0xFF8987ab) ))
                                       ),
                                        Container(
                                         margin: EdgeInsets.only(top: 2.0),
                                         child: Icon(Feather.arrow_right,size: 10.0,color: Color(0xFF8987ab) ))
                                       ,  Container(
                                         margin: EdgeInsets.only(right: 30.0),
                                         child: Text(" Accra",style: TextStyle(fontSize: 11.5, color: Color(0xFF8987ab) ))
                                       ),
                                       
                                     ],
                                   ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 1.5),
                                          child: Text(rating.toString(), style: TextStyle(color: warmPrimaryColor, fontSize: 11.0, fontWeight: FontWeight.bold)),
                                        ),
                                        SmoothStarRating(
                                          rating: rating,
                                          size: 11.0,
                                          color:goldColor,
                                          borderColor: goldColor,

                                        ),
                                        Container(
                                             margin: EdgeInsets.only(left:3.5 ,right: 30.0,top: 3.0),
                                             child: Text("Cloth",style: TextStyle(fontSize: 11.5, color: Color(0xFF8987ab) ))),
                                      ],
                                    )
                                    ]
                                  ),
                                 

                                 ]
                               ),
                             ),
                             Expanded(child: SizedBox()),
                             Container(
                               // margin: EdgeInsets.only(right: 20),
                               child: Row(
                               
                                 children: [
                                  //  Container(
                                  //    margin: EdgeInsets.only(bottom: 0.0),
                                  //    child: Text("₵ 45", style: TextStyle(color:Color(0xFF8987ab) , fontSize: 13.0)),
                                  //  ),
                                    Container(
                                     width: 5.0,
                                     height: 5.0,
                                     decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       color: isDelivered ? Color(0xFF00ff00) :goldColor,
                                     ),
                                   ),

                                   Container(
                                     padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5.0),
                                    //  decoration: BoxDecoration(
                                    //    color: Color(0xFFf7f7fa),
                                    //    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                    //  ),
                                     child: isDelivered ? Text("₵ ${Random().nextInt(100)}", style: TextStyle(color:warmPrimaryColor,fontSize: 11.5,fontWeight: FontWeight.bold)) :  Text("₵ ${Random().nextInt(100)}", style: TextStyle(color:warmPrimaryColor,fontSize: 11.5,fontWeight: FontWeight.bold))
                                   ),
                                 ]
                               ),
                             ),
                           ]
                         ),
                       ),
                     ),
                    
                   ]
                 ),
               ),
 );
           
}



 static Widget  oldParcelWidget(context,Parcel parcels,{width  = 360.0}){
var senders = ["Kwame Ibrahim", "Osman kareem", "Abdulai Mubarik", "Hafiz Elias","Muniru Yussif","Alhassan Yazeed", "Asmat Wulon"];

var circleColors = [Color(0xFFf5723f),
Color(0xFF210070),
Color(0xFFFFE042),
Color(0xFFE71989)
,Color(0xFFFFA781),
Color(0xFF5E001F),
Color(0xFF00E1D9)];
 var circleColor = circleColors[Random().nextInt(6)];
 var iconPath    = Constants.PARCEL_ICONS[Random().nextInt(6)];
return  
 InkWell(
   onTap: (){
     Navigator.pushNamed(context, Constants.PARCEL_DETAILS_ROUTE);
   },
    child: Container(
                 
                 child: Column(
                 
                   children: [
                     
                     Container(
                       width: width,
                       height: 90,
                       padding: EdgeInsets.only(bottom: 8.0,left: 8.0,right: 8.0),
                       decoration: BoxDecoration(
                           //color: Color(0xFFf7f7fa),
                          // color: white,
                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
                       ),
                     
                       child: Container(
                         height: 55,
                         width: 360.0,
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               width: 55.0,
                               height: 90.0,
                               alignment: Alignment.center,
                               margin: EdgeInsets.only(right: 10.0),
                               decoration: BoxDecoration(
                                 // color: true ? Color(0xFFeceef0) :  circleColor,
                                 shape: BoxShape.circle,
                               ),
                              
                               child: ClipRRect(borderRadius:BorderRadius.circular(0.0) ,child: Container(height: 75.0,width: 75.0,decoration: BoxDecoration(shape: BoxShape.circle),child: Image.asset('assets/images/parcel_size_${Random().nextInt(10)}.png', fit: BoxFit.cover)))),
                             
                             Container(
                               margin: EdgeInsets.only(right: 10.0),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                     child: Text(senders[Random().nextInt(6)], style: TextStyle(color: primaryColor,fontSize: 15, fontWeight: FontWeight.bold))
                                   ),
                                   Row(
                                     children: [
                                       Container(
                                         padding: EdgeInsets.symmetric(vertical: 2,horizontal: 3 ),
                                        //  decoration: BoxDecoration(
                                        //    color: Color(0xFFf7f7fa),
                                        //    borderRadius: BorderRadius.all(Radius.circular(10)),
                                        //  ),
                                         child: Text("status:", style: TextStyle(fontSize: 12, color: primaryColor,fontWeight: FontWeight.bold))
                                       ),
                                       
                                       Container(
                                         margin: EdgeInsets.only(right: 30.0),
                                         child: Text("OnRoute",style: TextStyle(fontSize: 13.0, color:  Color(0xFF8987ab)))
                                       ),
                                    
                                       
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       Container(
                                         padding: EdgeInsets.symmetric(vertical: 2,horizontal: 3 ),
                                         decoration: BoxDecoration(
                                           color: Color(0xFFf7f7fa),
                                           borderRadius: BorderRadius.all(Radius.circular(10)),
                                         ),
                                         child: Text("from:", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color:primaryColor))
                                       ),
                                       
                                       Container(
                                         margin: EdgeInsets.only(right: 30.0),
                                         child: Text("Kumasi - Accra",style: TextStyle(fontSize: 13.0, color: Color(0xFF8987ab) ))
                                       ),
                                    
                                       
                                     ],
                                   ),
                                   
                                    ]
                                  ),
                                 

                                 ]
                               ),
                             ),
                             Expanded(child: SizedBox()),
                             Container(
                               // margin: EdgeInsets.only(right: 20),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Container(
                                     margin: EdgeInsets.only(bottom: 0.0),
                                     child: Text("₵ 45", style: TextStyle(color:Color(0xFF8987ab) , fontSize: 13.0)),
                                   ),

                                   Container(
                                     padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5.0),
                                    //  decoration: BoxDecoration(
                                    //    color: Color(0xFFf7f7fa),
                                    //    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                    //  ),
                                     child: Text("Paid", style: TextStyle(color:primaryColor))
                                   ),
                                 ]
                               ),
                             ),
                           ]
                         ),
                       ),
                     ),
                    
                   ]
                 ),
               ),
 );
           
}



static Widget routeHeading(title, {onTap}){
  return    Row(
                        children: [
                          InkWell(
                onTap: onTap,
                child: Container(
                
                  alignment: Alignment.centerLeft ,
                  margin: EdgeInsets.only(left: 10.0,top:20),
                  child: Icon(Feather.arrow_left, color: primaryColor,),),
              ),
                         Container(
                           margin: EdgeInsets.only(left: 10.0),
                           child: Text(title, style: TextStyle(color: primaryColor,fontSize: 17.0, fontWeight: FontWeight.bold)),
                         ),
                        ],
                      );
          
} 

static Widget corneredButton({title,width: 270.0,elevation = 25.0,onTap, Color color = cornedButtonColor }){

  return  Container(
          
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Material(
              elevation: elevation,
              shadowColor: color,
              borderRadius: BorderRadius.circular(5.0),
              child: InkWell(
                onTap: onTap,
                                                                         child: Container(
                   alignment: Alignment.center,                                                         width:width,
                              padding: EdgeInsets.symmetric(vertical: 18.0, ),decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: color,
                    ),child: Text(title, style: TextStyle(color: white, fontSize: 14.0,fontWeight: FontWeight.bold))),
                          ),
                        )
                      );
                    

}


static                                                
Widget inputField({screenWidth = 0.0,controller,icon = "", title = '',hint = 'required', defaultValue = '', hasMargin = true, isActive,required Function (String value) onChanged,focusNode ,bool obscureText = false, isGender = false, onTap}){
                    
                      return   Column(
                    children: [
                      Container(
                              
                    width: screenWidth,
                   padding: EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: 
                    Container(
                      padding: EdgeInsets.all(7.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 25.0,bottom: 5.0),
                            child: Text(title, style: TextStyle(color: Color(0xFFC0C0C0),fontWeight: FontWeight.bold, fontSize: 12.0)),
                          ),
                    
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 7.0),
                              child: Icon(icon, color: primaryColor,size: 14.0),
                            ),
                    
                        Container(
                          width: screenWidth * 0.7,
                          padding: EdgeInsets.only(right: 15.0), 
                          child:  TextField(
                                        keyboardType: TextInputType.name ,
                                        controller:controller,
                                        focusNode: focusNode,
                                        textAlign: TextAlign.start,
                                        obscureText: obscureText,
                                        style: TextStyle(
                                          color: warmPrimaryColor,
                                          fontSize: 13,
                                          fontWeight : FontWeight.bold,
                                        ),
                                        
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
                                    ),
                      
                    
                                      
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                
                              ),
                                SizedBox(height: hasMargin ? 30.0 : 0.0),
                              ],
                            );
                                                        
                                                }

 
      

static broadCustomTextField(controller, { FocusNode? focusNode,required void Function (String text) onChanged,isErrorBorder = false,digitsOnly: false,symbol="₵",copyright = "©",width = 250.0,enableTrailingIcon = false, iconAction,textAlign = TextAlign.center,trailingIcon = Feather.eye,marginTop:0.0, marginBottom: 15.0 , hint='', bool obscureText = false}){

return       

 Container(
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 8.0),
                        margin: EdgeInsets.only(bottom: marginBottom,top: marginTop ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                         border: Border.all(width: 0.5, color:isErrorBorder ? errorColor: Color(0xFF182e65).withOpacity(0.2)),
                        ),
                      child: 
                      Row(
                      
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10.0),
                          child: Text(symbol, style: TextStyle(color: warmPrimaryColor, fontWeight: FontWeight.bold                                     )),
                          ),

                       Container(
                            width: width,
                             padding: EdgeInsets.only(right: 15.0), child: 
                             TextField(
                              keyboardType: digitsOnly ?  TextInputType.phone : TextInputType.name ,
                              controller: controller,
                             focusNode: focusNode,
                             textAlign: textAlign,
                              style: TextStyle(
                                color: warmPrimaryColor,
                                fontWeight : FontWeight.bold,
                              ),
                              autofocus: true,
                              cursorColor: warmPrimaryColor,
                              obscureText: obscureText,
                              decoration: InputDecoration.collapsed(
                                hintText: hint,
                                hintStyle: TextStyle(
                                  color: Color(0xFFd7e0ef),
                                  fontSize: 13,
                                ),
                              ),
                              onChanged: onChanged,
                            ),
                         
                          ),
            

            
             Visibility(
                             visible: enableTrailingIcon,
                            child: InkWell(
                               onTap: iconAction,
                               
                              child: Container(
                              margin: EdgeInsets.only(left: 20.0),
                          child: Icon(trailingIcon, color: Color(0xFF182e65).withOpacity(0.5), size: 17),
                          ),
                             ),
                           ),
            
                        ]
                      ),
                       
                        
                        );
  

           
  }



static Widget fadedCustomTextField(controller, { FocusNode? focusNode,required void Function (String text) onChanged,digitsOnly = false,isErrorBorder = false,symbol="₵",textAlign = TextAlign.center,obscureText: false,width = 250.0, marginTop:0.0, autoFocus: true,marginBottom: 15.0 ,maxLines = 1,isLongTextField: false,canToggleTextVisibility: true,trailingIcon: Feather.eye,keyboard, hint='', vertPad: 10.0, horizPad: 10.0}){

return       
 Container(
                        padding: EdgeInsets.symmetric(vertical: vertPad,horizontal:isLongTextField ? 0.0: horizPad),
                        margin: EdgeInsets.only(bottom: marginBottom,top: marginTop ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                         border: Border.all(width: 0.5, color:isErrorBorder ? errorColor: Color(0xFF182e65).withOpacity(0.2)),
                        ),
                      child: Row(
                      
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10.0),
                          child: Text(symbol, style: TextStyle(color: warmPrimaryColor, fontWeight: FontWeight.bold                                     )),
                          ),

                       Container(
                            width: width,
                            padding: EdgeInsets.only(right: isLongTextField ? 0.0: 15.0), child: TextField(
                              keyboardType: digitsOnly ? TextInputType.phone : TextInputType.text ,
                              controller: controller,
                              
                             focusNode: focusNode,
                             obscureText: obscureText,
                             textAlign: textAlign,
                             maxLines: maxLines,
                              style: TextStyle(
                                color: warmPrimaryColor,
                                fontWeight : FontWeight.bold,
                              ),
                              autofocus: autoFocus,
                              //cursorColor: Color(0xFF636B85),
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
            
                        ]
                      ),
                        
                        );
            
  }



static OverlayEntry getOverlay(context,animControl,Widget content,{distanceFromBottom = 50.0}){


return OverlayEntry(
  builder: (context)=>
    
       CustomAnimation<double>(
       control: animControl,
       tween: 0.0.tweenTo(distanceFromBottom),
       duration: 400.milliseconds,
       curve: Curves.easeInOut,
        builder: (context, child,value) {
          return Positioned(
          left: 7.5,
          bottom: value,
           width: 350,
          child: Material(
           // elevation: 30.0,
            color: Colors.transparent,
            child: InkWell(
              onTap: (){
                   print("touch detected");
             },
                          child: Card(elevation: 30.0,child: content)
                
        
            )
            ),
          );
        }
      ),
    




);
  
  
  }





}

getDialogWithSingleInputField(context,title,inputFieldController,{cancelText="CANCEL",confirmText="CONFIRM",required void Function() cancelAction,required void Function() confirmAction, animDuration =  400}){

     showGeneralDialog(
    context: context,
    transitionDuration: Duration(milliseconds: animDuration),
    barrierLabel: "Input supermarket name",
    pageBuilder: (context,anim1,anim2){

    return AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(24.0,20.0,24.0,0.0),
    insetPadding: EdgeInsets.symmetric( horizontal: 10.0),
      content: 
              Container(
           padding: EdgeInsets.only(top: 20.0),
           height: 200.0,
          color: Color(0xFFFEFEFC),
          child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        margin: EdgeInsets.only(bottom:15.0),
                       color: Colors.white, 
                      child:  RichText(
                        text: TextSpan(
                          text: "Please enter supermarket ",
                          style: TextStyle(fontWeight:FontWeight.bold,color: Color(0xFF182e65)),
                          children: [
                            TextSpan(
                            text:"name",
                            style: TextStyle(color: primaryColor),
                          ),]
                        ),
                      ),),
                    
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10.0),
                        margin: EdgeInsets.only(bottom: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                         border: Border.all(width: 0.5, color: Color(0xFF182e65)),
                        ),
                      child: Row(
                      
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                          child: Text("&", style: TextStyle(color:                                      Colors.black)),
                          ),

                          Container(
                            width: 250,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: inputFieldController,
                             
                              autofocus: true,
                              cursorColor: Color(0xFF636B85),
                              decoration: InputDecoration.collapsed(
                                hintText: "",
                              ),
                              onChanged: (String amount){
                                
                              },
                            ),
                          ),
                        ]
                      ),
                        
                        ),

                  Container(
                     
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        InkWell(
                          onTap:cancelAction 
                          
                          //(){

                        //    Navigator.pop(context);
                        //    if(showBlurredOverlay){
                        //  showBlurredOverlay = false;
                        //    }
                     
                        //   }
                          ,   child: Material(
                         
                           borderRadius: BorderRadius.circular(5.0),  
                          child: Container(
                           width: 130,
                              decoration: BoxDecoration(
                           //   color: Color(0xFF80D8FF),
                           color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                               alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 12.75,horizontal: 10.0),
                              child: Text(cancelText, style: TextStyle(color: Colors.white)),
                              ),
                          ),
                        ),

                    InkWell(
                      onTap: confirmAction
                         
                        // if(Navigator.canPop(context)){
                        //   Navigator.pop(context);
                        // }
                        // Navigator.pushNamed(context, "/add_supermarket_details_route");
                        // if(showBlurredOverlay){
                        //   setState((){
                        //     showBlurredOverlay = false;
                        //   });
                        // }  
                      ,
                       child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                         elevation: 30.0,
                        // shadowColor: Color(0xFF80D8FF),
                        shadowColor: Color(0xFFFFFFFF),
                        child: Container(
                            width: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5,color:primaryColor ),
                            //  border: Border.all(width: 1.5,color:Color(0xFF80D8FF) ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                             alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical:                               12,horizontal: 10.0),
                            child: Text(confirmText, style: TextStyle(color: Colors.black)),
                            ),
                        ),
                    ),
                    ]),),
                //),
                    ]),
        ),
     
          
       
       
       );
    },
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context,anim1,anim2,child){
    
      
  return FractionalTranslation(
    translation: Offset(0, 1 - anim1.value),
    child: child,
  );
      
    },
   
  );


}


class CustomNavigator {
  static pushNamed(context, route,
      {isSecured = false, msg = 'Please authorize access to this screen'}) {
    if (isSecured) {
      requestLocalAuth(msg: msg).then((res) {
        if (res == null) return;
        if (!res['result']) return;

        Navigator.pushNamed(context, route);
      }).catchError((error) {
        print(' $error this is an error ');
        print('Error authorizing access to screen.');
      });
    } else {
      Navigator.pushNamed(context, route);
    }
  }
}


Widget mainButton(
    {title = 'Resend Sms Code',
    onPressed,
    buttonColor = brightMainColor,
    textColor: white}) {
  return MaterialButton(
    disabledColor: Colors.grey[200],
    disabledTextColor: Colors.grey,
    disabledElevation: 0.0,
    onPressed: onPressed,
    child: Text(
      title,
      style: TextStyle(color: textColor),
    ),
    color: buttonColor,
  );
}

topNavigationBar(context, screenWidth, screenHeight) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
        child: Container(
          padding:
              EdgeInsets.only(left: screenWidth * 0.05, top: screenHeight / 23),
          child: Icon(Ionicons.ios_arrow_back)
        ),
      ),
      Divider(thickness: 1.2, color: Colors.black12)
    ],
  );
}

authenticationRouteTypeCard(
    {width = 0.0, icon = Icons.mail_outline, description = ''}) {
  return Column(
    children: <Widget>[
      Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            child: Material(
              color: white,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(7),
            ),
          ),

          Container(
            width: width / 10,
            height: width / 13.4,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(width / 17)),
            child: Center(
              child: Icon(icon, color: brightMainColor),
            ),
          ),
          //  ),
        ],
      ),
      SizedBox(height: width * 0.03),
      Text(
        description,
        style: TextStyle(fontSize: 10),
      ),
    ],
  );
}

immersendCircularIcon(screenWidth, title, {titleColor = brightMainColor}) {
  return Column(
    children: <Widget>[
      Stack(
        children: <Widget>[
          Container(
              width: screenWidth * 0.25,
              height: screenWidth * 0.25,
              padding: EdgeInsets.fromLTRB(10.0, 15, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: Color(0xFFe7e7e7),
                  borderRadius: BorderRadius.circular(screenWidth * 0.125)),
              child: Container()),
          Positioned(
            top: 10,
            left: 10,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  child: Material(
                    shadowColor: white,
                    color: white,
                    elevation: 30.0,
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                Container(
                  child: Icon(Icons.fingerprint,
                      size: screenWidth * 0.09, color: brightMainColor),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: screenWidth * 0.01),
      Container(
        child: Text(title, style: TextStyle(color: titleColor)),
      ),
    ],
  );
}

immersendRectangularIcon(screenWidth, title, {titleColor = brightMainColor}) {
  return Column(
    children: <Widget>[
      Stack(
        children: <Widget>[
          Container(
              width: screenWidth * 0.2,
              height: screenWidth * 0.2,
              padding: EdgeInsets.fromLTRB(10.0, 15, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: Color(0xFFe7e7e7),
                  borderRadius: BorderRadius.circular(screenWidth * 0.09)),
              child: Container()),
          Positioned(
            top: 10,
            left: 10,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  child: Material(
                    shadowColor: white,
                    color: white,
                    elevation: 30.0,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                Container(
                  child: Icon(Icons.fingerprint,
                      size: screenWidth * 0.09, color: brightMainColor),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: screenWidth * 0.01),
      Container(
        child: Text(title, style: TextStyle(color: titleColor)),
      ),
    ],
  );
}

 showAnimatedDialog(context, {title = '', content = ''}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, anim1, anim2) {return Container();},
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black,
    transitionBuilder: (context, anim1, anim2, child) {
      return AlertDialog(
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text('Dismiss')),
        ],
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text(content),
      );
    },
    transitionDuration: Duration(milliseconds: 300),
  );
}



showProgressDialog(_context, {title = 'Please wait', message = ''}) {
  showDialog(
    context: _context,
    builder: (_) => CupertinoAlertDialog(
        title: Text(title, style: TextStyle(color: Colors.black)),
        content: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Container(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(brightMainColor),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              child: Text(message, style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
        actions: []),
    barrierDismissible: false,
  );





}


refinedInformationDialog(context, title, msg) {
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            actionsPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            titlePadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            buttonPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(
              padding: EdgeInsets.all(0.0),
              width: 270.0,
              height: 270.0,
              child: Column(children: <Widget>[
                Container(
                  width: 280.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                    color: brightMainColor,
                  ),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 30, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 60),
                          child: Text(title,
                              style: TextStyle(
                                  color: white, fontWeight: FontWeight.bold))),
                      SizedBox(width: 40),
                      InkWell(
                        splashColor: Colors.black.withOpacity(.3),
                        onTap: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Icon(Ionicons.md_close, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Text('$msg',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.7,
                        fontSize: 13,
                      )),
                ),
              ]),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation) {return Container();});
}


transactionCompletionDialog(context, title, msg) {
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            actionsPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            titlePadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            buttonPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(
              padding: EdgeInsets.all(0.0),
              width: 270.0,
              height: 270.0,
              child: Column(children: <Widget>[
                Container(
                  width: 280.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                    color: brightMainColor,
                  ),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 30, bottom: 30),
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(title,
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: 10),
                Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: brightMainColor,
                          style: BorderStyle.solid,
                          width: .8),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 12,
                      height: 12,
                      child: Icon(Ionicons.ios_checkmark,
                          size: 20, color: brightMainColor),
                    )),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Text('$msg',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.7,
                        fontSize: 13,
                      )),
                ),
                Expanded(flex: 2, child: SizedBox()),
                InkWell(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                      width: 260,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: white,
                        // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                        border: Border(
                          top: BorderSide(
                            width: .5,
                            color: brightMainColor,
                          ),
                        ),
                      ),
                      child: Text('Okay',
                          style: TextStyle(color: brightMainColor))),
                ),
          
              ]),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation) {return Container();});
}

taskProcessingDialog(_context, title, msg) {
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            actionsPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            titlePadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            buttonPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(
              padding: EdgeInsets.all(0.0),
              width: 270.0,
              height: 270.0,
              child: Column(children: <Widget>[
                Container(
                  width: 280.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                    color: brightMainColor,
                  ),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 30, bottom: 30),
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(title,
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(brightMainColor)),
                ),
              ]),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: _context,
      pageBuilder: (context, animation1, animation) {return Container();});
}

taskSuccessDialog(_context, title, msg) {
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            actionsPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            titlePadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            buttonPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(
              padding: EdgeInsets.all(0.0),
              width: 270.0,
              height: 270.0,
              child: Column(children: <Widget>[
                Container(
                  width: 280.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                    color: brightMainColor,
                  ),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 30, bottom: 30),
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(title,
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: 10),
                Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: brightMainColor,
                          style: BorderStyle.solid,
                          width: .8),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 12,
                      height: 12,
                      child: Icon(Ionicons.ios_checkmark,
                          size: 20, color: brightMainColor),
                    )),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Text('$msg',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.7,
                        fontSize: 13,
                      )),
                ),
                Expanded(flex: 2, child: SizedBox()),
                InkWell(
                  onTap: () {
                    print('Print');
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                      width: 260,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: white,
                        // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                        border: Border(
                          top: BorderSide(
                            width: .5,
                            color: brightMainColor,
                          ),
                        ),
                      ),
                      child: Text('Okay',
                          style: TextStyle(color: brightMainColor))),
                ),
              ]),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: _context,
      pageBuilder: (context, animation1, animation) {return Container();});
}

taskProcessingErrorDialog(context, title, msg, {timer = true}) {
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            actionsPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            titlePadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            buttonPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(
              padding: EdgeInsets.all(0.0),
              width: 270.0,
              height: 270.0,
              child: Column(children: <Widget>[
                Container(
                  width: 280.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                    color: errorColor,
                  ),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 30, bottom: 30),
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(title,
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: 10),
                Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: errorColor,
                          style: BorderStyle.solid,
                          width: .8),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 12,
                      height: 12,
                      child:
                          Icon(AntDesign.close, size: 20, color: errorColor),
                    )),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Text('$msg',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.7,
                        fontSize: 13,
                      )),
                ),
                Expanded(flex: 2, child: SizedBox()),
                InkWell(
                  onTap: () {
                    print('Print');
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                      width: 260,
                      height: 50,
                      alignment: Alignment.center,
                      decoration:const BoxDecoration(
                        color: white,
                        // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                        border: Border(
                          top: BorderSide(
                            width: .5,
                            color: errorColor,
                          ),
                        ),
                      ),
                      child:const Text('Okay')),
                ),
              ]),
            ),
          ),
        );
      },
      transitionDuration:const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation) {return Container();});
}

customInfoDialog(_context, title, msg) {
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            actionsPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            titlePadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            buttonPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(
              padding: EdgeInsets.all(0.0),
              width: 270.0,
              height: 270.0,
              child: Column(children: <Widget>[
                Container(
                  width: 280.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                    color: brightMainColor,
                  ),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 30, bottom: 30),
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(title,
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: 10),
                Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: brightMainColor,
                          style: BorderStyle.solid,
                          width: .8),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 12,
                      height: 12,
                      child: Icon(Ionicons.ios_checkmark,
                          size: 20, color: brightMainColor),
                    )),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text('$msg',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.7,
                        fontSize: 13,
                      )),
                ),
                InkWell(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                      width: 260,
                      padding: EdgeInsets.only(top: 10),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: white,
                        border: Border(
                          top: BorderSide(
                            width: .5,
                            color: brightMainColor,
                          ),
                        ),
                      ),
                      child: Text('Okay',
                          style: TextStyle(color: brightMainColor))),
                ),
              ]),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: _context,
      pageBuilder: (context, animation1, animation) {return Container();});
}

androidBusyDialog(context, {title = 'Loading', msg = ''}) {
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.translate(
          offset: Offset(0, a1.value),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            actionsPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            titlePadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            buttonPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(
              padding: EdgeInsets.all(0.0),
              width: 270.0,
              height: 270.0,
              child: Column(children: <Widget>[
                Container(
                  width: 280.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                    color: brightMainColor,
                  ),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 30, bottom: 30),
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(title,
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: 10),
                Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: brightMainColor,
                          style: BorderStyle.solid,
                          width: .8),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 12,
                      height: 12,
                      child: Icon(Ionicons.ios_warning,
                          size: 20, color: brightMainColor),
                    )),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10, left: 20),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(width: 1.2, color: brightMainColor)),
                      ),
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(brightMainColor)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: Text('$msg',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.7,
                            fontSize: 13,
                          )),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation) {return Container();});
}

//ƒƒƒç√ƒ∫˙˜µµ≤ˆ¨¥¬≤≥≥÷…¬˚…÷≥æ…“‘≠–º¬˚ˆ∆¨˙¥†©ƒ®∂´ß∑åœ¡™£¢∞¢¢¢¢¢¢ 
