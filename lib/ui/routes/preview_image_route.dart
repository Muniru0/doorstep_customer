
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class PreviewImageRoute extends StatefulWidget {

  final String imageType;
  final String? imageHeroTag;
  final Image? image;
  final String imageDesc;
  
  PreviewImageRoute({this.imageType = '',  this.imageHeroTag , this.image, this.imageDesc = ''});
 
  @override
  _PreviewImageRouteState createState() => _PreviewImageRouteState();
}

class _PreviewImageRouteState extends State<PreviewImageRoute> {


late double _w;
late double _h;

  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<UserModel>(
      screenTitle: "Preview ${widget.imageType}",
        child: Container(
          child: Column(
          children: [
           Hero(
          tag: widget.imageHeroTag!,
          child:Container(margin: EdgeInsets.only(top: 20.0),width: _w, height: _h * 0.3,child: widget.image),
        ),

 
        Container(
            margin: EdgeInsets.only(bottom: 15.0, top: 15.0),
            padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 10.0),
            width: double.infinity,
            color: white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: Text("Change Avatar", style: TextStyle(color: Color(0xFFc8d2de), fontSize: 13.0, )),
                ),
               
                Expanded(child: SizedBox()),
                
                   Container(
                                 child: Text("Change", style: TextStyle(fontWeight: FontWeight.w900,color: warmPrimaryColor.withOpacity(0.5), fontSize: subHeadingsSize)),
                  ),
                
              ]
            ),
          ),    
       
              Container(
                margin: EdgeInsets.only(top: 30.0),

                width: _w,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: Text(widget.imageDesc,textAlign: TextAlign.center, style: TextStyle(color: warmPrimaryColor,fontSize: 13,))
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: UtilityWidgets.customConfirmationButton(context, () {
                  
                  Navigator.pop(context);
                 },confirmationText: "BACK", isLong: true)
              ),
            ],
          ),
        ),
    );
  }
}





