


import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_customer/constants/constants.dart';
import 'package:doorstep_customer/models/user_model.dart';
import 'package:doorstep_customer/services/data_models/user_data_model.dart';
import 'package:doorstep_customer/ui/base_route.dart';
import 'package:doorstep_customer/ui/utils/colors_and_icons.dart';
import 'package:doorstep_customer/ui/utils/helper_functions.dart/functions.dart';
import 'package:doorstep_customer/ui/utils/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:ui';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:validators/validators.dart';

class TestRoute extends StatefulWidget {
  const TestRoute({ Key? key }) : super(key: key);

  @override
  _TestRouteState createState() => _TestRouteState();
}

class _TestRouteState extends State<TestRoute> {


  static http.Client httpClient = http.Client();

  String imagePath = 'https://firebasestorage.googleapis.com/v0/b/doorsteppay-50730.appspot.com/o/user_avatars%2Fthumb_1633985501008_385cdff8-6af3-4909-812e-78d50ad501ef282297304922382690.jpg?alt=media&token=f774c831-ac63-454a-a2aa-f3c968bcb336';
  File? mfile;

  double? value = 0.0;
late double _w;
late double _h;


CarouselController _carouselController = CarouselController();

late int count;
late   Location location ;

  late int sortByDateAdded;

  late int sortByBestRating;

  late int sortByNumberOfParcels;

 late bool _showSortWidget;

 late bool showSearchTextField;

 late bool _addedToFavorites;

 late bool _showParcelTypes;



@override
  void initState() {
    count = 0;
    sortByBestRating  = 0;
    sortByDateAdded   = 0;
    sortByNumberOfParcels = 0;
    _showSortWidget = false;
    showSearchTextField = false;
    _addedToFavorites = false;
    

    
      // Future.delayed(Duration(seconds: 2),(){
        
       
      // });
//      DirectionsResponse response = DirectionsResponse.fromMap({
//   "geocoded_waypoints":
//     [
//       {
//         "geocoder_status": "OK",
//         "place_id": "ChIJ8f21C60Lag0R_q11auhbf8Y",
//         "types": ["locality", "political"],
//       },
//       {
//         "geocoder_status": "OK",
//         "place_id": "ChIJgTwKgJcpQg0RaSKMYcHeNsQ",
//         "types": ["locality", "political"],
//       },
//     ],
//   "routes":
//     [
//       {
//         "bounds":
//           {
//             "northeast": { "lat": 40.4165207, "lng": -3.7025932 },
//             "southwest": { "lat": 39.862808, "lng": -4.029406799999999 },
//           },
//         "copyrights": "Map data ©2021 Inst. Geogr. Nacional",
//         "legs":
//           [
//             {
//               "distance": { "text": "74.3 km", "value": 74341 },
//               "duration": { "text": "57 mins", "value": 3431 },
//               "end_address": "Madrid, Spain",
//               "end_location": { "lat": 40.4165207, "lng": -3.705076 },
//               "start_address": "Toledo, Spain",
//               "start_location": { "lat": 39.862808, "lng": -4.0273727 },
//               "steps":
//                 [
//                   {
//                     "distance": { "text": "0.6 km", "value": 615 },
//                     "duration": { "text": "2 mins", "value": 101 },
//                     "end_location":
//                       { "lat": 39.8681019, "lng": -4.029378299999999 },
//                     "html_instructions": "Head <b>northwest</b> on <b>Av. de la Reconquista</b> toward <b>C. de la Diputación</b>",
//                     "polyline":
//                       {
//                         "points": "quhrF`rqWCBQJUJm@PQFg@Ni@JeBh@}@XaD|@{@Vk@Ns@RUFoA^u@R_AXwA`@WHMBG@C?E?GAC?IC",
//                       },
//                     "start_location": { "lat": 39.862808, "lng": -4.0273727 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "0.2 km", "value": 174 },
//                     "duration": { "text": "1 min", "value": 24 },
//                     "end_location": { "lat": 39.8675297, "lng": -4.0275807 },
//                     "html_instructions": "At the roundabout, take the <b>1st</b> exit onto <b>C. Duque de Lerma</b>",
//                     "maneuver": "roundabout-right",
//                     "polyline":
//                       {
//                         "points": "svirFr~qW?AAEAEACACACCCACF_@H[FQNi@j@cB`@qAHW",
//                       },
//                     "start_location":
//                       { "lat": 39.8681019, "lng": -4.029378299999999 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "0.6 km", "value": 594 },
//                     "duration": { "text": "2 mins", "value": 91 },
//                     "end_location": { "lat": 39.8688577, "lng": -4.021535 },
//                     "html_instructions": 'At the roundabout, take the <b>3rd</b> exit onto <b>Av. Gral. Villalba</b><div style="font-size:0.9em">Go through 1 roundabout</div>',
//                     "maneuver": "roundabout-right",
//                     "polyline":
//                       {
//                         "points": "asirFjsqW@?@??A@?@A@A@?DI@C@C@A@C@C@CDS?A@O?G@G?GAKAA?AAAAA?CAAA?AAAAAAA?AAA?A?AAA?A?A?C@A?A?A@A@A??@A@CBQMIIEEACISCIIWEQEMI[Oi@?CYy@@E?K?A?A?AAA?A?AA??A?AAAAA?AA??AA??AA?A??AA?A?A?A?UcAOi@Mi@Mk@I]AMCOAQAQCWCgA?k@EuCCaCA{@?O",
//                       },
//                     "start_location": { "lat": 39.8675297, "lng": -4.0275807 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "0.2 km", "value": 198 },
//                     "duration": { "text": "1 min", "value": 29 },
//                     "end_location": { "lat": 39.8700417, "lng": -4.0208568 },
//                     "html_instructions": "At the roundabout, take the <b>3rd</b> exit onto <b>Av. de Madrid</b>",
//                     "maneuver": "roundabout-right",
//                     "polyline":
//                       {
//                         "points": "k{irFrmpW@A@A@A@A@A?A@A@A?A@A?A@A?C?A@A?C?C?C?A?CAC?AAC?AAAACAAA??AAAAAC?AAA?A?A?A?AAA@A?A?A?]W_@U{@a@o@YGACAKBE@A@A@EDCFAH?F?H",
//                       },
//                     "start_location": { "lat": 39.8688577, "lng": -4.021535 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "0.4 km", "value": 415 },
//                     "duration": { "text": "1 min", "value": 56 },
//                     "end_location": { "lat": 39.8737356, "lng": -4.0207605 },
//                     "html_instructions": "Turn <b>right</b> to stay on <b>Av. de Madrid</b>",
//                     "maneuver": "turn-right",
//                     "polyline":
//                       {
//                         "points": "wbjrFjipWEFCBABC@E@E@G?M?a@Aq@CsBCK?s@As@CcCE{@?{AEo@AGAOECAMA",
//                       },
//                     "start_location": { "lat": 39.8700417, "lng": -4.0208568 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "1.1 km", "value": 1065 },
//                     "duration": { "text": "1 min", "value": 63 },
//                     "end_location": { "lat": 39.8830007, "lng": -4.0190202 },
//                     "html_instructions": "At the roundabout, take the <b>2nd</b> exit onto the <b>A-42</b> ramp to <b>Madrid</b>",
//                     "maneuver": "roundabout-right",
//                     "polyline":
//                       {
//                         "points": "{yjrFvhpW?C?CAC?AACAAACAAAACAAAAACAC?A?AAA@C?A?A?A@A?C@A?A@C@A@ABA@AB?@ABE?A?KDGDG@I@KBgACoCEQEW?[A[AgAAu@CiBEi@EKCyAMiAM[G_@I[Mk@S_@Qa@Qa@OQGKEICICYGIAIAKAQCUCO?Q?OAS?]?Q?g@@EAG?GAG?IAIAGCKAYI[KCAo@WmAe@q@SMCiAS_@B",
//                       },
//                     "start_location": { "lat": 39.8737356, "lng": -4.0207605 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "19.2 km", "value": 19159 },
//                     "duration": { "text": "11 mins", "value": 641 },
//                     "end_location":
//                       { "lat": 40.0333486, "lng": -3.925665899999999 },
//                     "html_instructions": "Merge onto <b>A-42</b>",
//                     "maneuver": "merge",
//                     "polyline":
//                       {
//                         "points": "wslrFz}oWKA]C[CS?UA[@u@@kBFaBFsBBS@c@?kA?uCAY?eACS?I?{@ESCK?QCKASAGAMAIC_@Ea@GUE_AQSEOC[G]I]I[I]I]I[I_@KGAGCYGMCUG[I_@Ka@KuBg@]Im@Ok@Mu@OiAUKAMCA?iAQaAM{@MWCUEi@K[GSEOCwA[s@Qu@So@Oc@Ke@KKC_@Io@Qu@Q]ISGMC]I[GoBe@_Cm@kAYyA]i@QaBc@CA_A[oDyAy@]mAe@yD}Aw@]qCgAaAe@u@_@_@S}@i@_Ao@UOIEa@Ye@Ye@WOIu@]o@Wa@OYMsBu@YK[McC}@iE_BYMwDwAOGKESGsHsCgE}AWKg@QeC_AqIaDgC}@gC_AoBu@oAe@{Ak@qCeAeBq@cE{AmCcAkAc@QGQG[MmAe@_Bm@qAg@_A]a@MeA]}@SICsAYw@M}B]cCa@a@G}@OaGaAwASg@KOE[Ge@MICe@M{@YMEGA[M[KyAe@GCQEoAc@c@OwAc@_DeAo@SeA]eAYk@OA?s@Mg@Ia@Iq@ImBYaB_@UGEC}@Yu@YMEg@Uk@Wo@YSMQIo@a@{@g@_@Wg@[mCmBaAs@oA}@]UmAu@q@[e@U{@e@SMKIQKGCGESKoDgCgGmEwCuBKI{AcAYQe@Um@WgAc@IE}@Y_Be@oBm@_Bc@e@OaAYo@Su@Wc@Uq@_@EAe@Yg@[iDwBWQOKOK]UuBqA}AcAeBiAwCoBUOUMGGqA{@i@_@_@Y[WYUYWYWe@a@eB}Ae@_@c@[]WYQm@_@UOc@W_@SCA[QKGMGk@Y}@c@q@]yAs@UMIE_@UWO]S]WcAq@k@c@a@]QKc@][WUQ]Yo@g@}AkAiCgBcC_BgCcBa@WSKg@]g@[MKKE_Am@OKiAq@uBoAm@]qAy@w@g@y@i@gAu@w@i@iCkB}B}AYSCAEE}B{A}AcAeAq@w@i@IGIG_BcAwA}@oKaHmUgOaMeIq@c@e@[ECKG_C}AmCeBmCeBcC_BiBkAmAy@wBuAwGkEkBmAQK_BeASMgAs@yDgCy@i@s@c@ECIGs@e@iCaBoAw@i@_@OKIEYQqAw@kBcAOIm@YKG[OSKICoB}@y@[uAg@u@YyAe@y@U]KgAYs@SwAY{@QICc@GOCwAU{@MwAQ{@IwAOa@C_AG{@Ee@AYA]A]A]?_@A]?y@?M?c@?}@@G?s@@M?Q@Y@K?W@e@@}@DSBM?O@aCPcAHmAJQ@[BWBy@Fu@FC?[BC@]B[@a@BYB]@c@By@BW@u@BcA?]?]?_@A]A]Ca@A[C]E[C]E_@E]G]G[G_@I]I]I[K_@KYKYK_@M[OYK]Q[O[QYO[SYQYQ[SYSYUWS[WWUYWUUWYWWWYWYUYUYU]UYU]S[U]S]Q]S]S_@Q_@Q]Qa@Q_@O_@Oa@Q_@Wq@GQMa@Qe@]cAM_@K_@Qg@M_@K]?C[cA[iAK_@Og@W}@EKACIYEK?CSq@k@mBi@iBK_@Oe@Og@e@aBi@kB[eAi@iBeAqDi@eBMc@}@uCm@oBSq@Ww@Wu@Us@M]Wq@[}@a@iAa@_AeAcCSe@c@_Ac@aA_AoB}@kBg@}@c@}@c@w@Ua@S[S]S]e@y@U]e@u@W_@QWk@{@_AsAk@u@OUW[W]MOIKOS[_@_AkAMMa@e@UWY[UWCEQQWY_@a@e@e@WWCCSQYYq@o@USWWYYYUEEcB{Au@m@wBgBOMgA{@AAm@g@m@e@k@c@eAy@o@i@YU[UYUkByA{CaCkByA",
//                       },
//                     "start_location": { "lat": 39.8830007, "lng": -4.0190202 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "47.1 km", "value": 47071 },
//                     "duration": { "text": "30 mins", "value": 1799 },
//                     "end_location": { "lat": 40.3957623, "lng": -3.7039499 },
//                     "html_instructions": "Keep <b>left</b> to stay on <b>A-42</b>",
//                     "maneuver": "keep-left",
//                     "polyline":
//                       {
//                         "points": "m_jsFlv}ViEkDkFcEsAgAk@c@qB_BIGKI_BoAIIg@_@{E{DgA{@oCwBw@o@m@e@oAaAu@m@yAkA]W?A]Wo@g@aF}Dq@i@oAcAWSQMAAMKWUq@g@mJuHo@g@q@i@eG}Ea@[a@]mCuBg@c@[UWSo@i@YSWUOMKIWSWUYSQMKKKG][WSWQWUo@e@YWWSYUUSYSi@c@YUYU}@u@}@s@WSWS[WKKWSUQSQs@g@_@[q@i@m@g@u@k@m@g@w@m@o@i@g@a@OKMMw@m@cBsAoDqCk@e@m@g@c@a@MKm@k@y@u@KIgAiA{A{AeBkBwCyCoBqBkAoAWWkBmBcAeAWWgAiAmAoAeAgA{@}@s@w@USa@a@w@y@e@g@u@w@QQ_@]KMKKoAqAaBeB}A_BGIAA}@_A_BaByA}AgAiAeAeACCk@q@SUS[U[Ua@Wc@Q_@Ui@Se@Qg@Og@K_@Me@Ki@Ie@EWMw@Gk@UoBSeBYmCMiAMeA[qCYmCIu@YyBE[UmBc@_EIy@_AeIK}@c@cE]sCa@sDAK]wCK_AQqASuBGc@yAuMk@cFCSE]?A?AACASAG?GCMESW_CAISkBUwB?CIi@MgAGa@Kq@WqA_@gBOm@_@gA_@iAc@iAISAASe@CIg@aAi@aAw@sA_@k@i@u@W[EEY_@OOs@w@i@k@c@_@e@a@SOm@c@[Uq@c@a@S_@SUMuAo@uBcA_@Qq@[wMoGYMOIwAq@_LiFCCkEsByGaDuFmC_CgAeFgCq@_@sAu@iBcAgC_B_@W}@k@uBuAgCaBc@YWQa@WCC]UgDuBcBiAq@a@cBiAGCOK_@UWQQKc@YwDeCuA}@u@e@]UCCaCiBu@k@[YQQw@s@kAmA[]SUw@_Aq@}@o@}@U[g@w@i@_Ae@y@o@iA]o@_CwE[m@uA_C{A{Bi@s@UYCC}@aAe@g@EEk@k@w@s@YWu@q@iA_AmA{@iAw@sAy@iCsAu@[qAs@}CcAaCq@aCk@w@OkEiAcEeAUGSGcAUqCq@eDy@aDy@cLwCoBi@aG{A]IqA]sD{@EAu@Sg@Mi@O]KsCq@qA]e@MkBe@yEoAu@SgBi@sCaAMEaBk@uAe@y@Y{@YGA{@[CAyBs@SGaBm@yDoAeBo@i@QyCaAUIcBq@yAm@uB{@wFeCqAi@aBq@w@Y[KqBs@[KuAc@sBm@gAWiCm@wAYs@M_AOWEa@GSCQCYCUGqAQk@G{@K_@GyAY}A[}A]a@K_Be@ECy@WaA_@c@OSI[K_A]mDsAgDoAA?_@OkEaBmAe@uAi@}As@iB}@y@e@g@Wg@WoCiAsBw@eAa@m@UgBq@m@Sy@[yCiAkAc@aA_@q@WwAg@uBy@}@[oAc@mA_@EAu@SQEmAY{@Sk@Oq@Sa@Mi@SEAaC}@qAe@uAi@A?kBq@wAk@kAi@cCmAi@Ww@]wAo@cBs@aC}@aC_ASGsCeAsCeAeBo@]KmAe@_@O{FuBgDoASIkHkCiAa@mCcAYK]M{EgB}B{@]MmFoBWKYK_FiBKECAOGkCaAqDsA}FwBGCWK_@MUIgAc@aDkA]MA?]Mi@SGCMEMEYMcE{AsAi@kAa@oAg@EA_@Qi@Sw@_@c@UOIGEQKKIOIc@[e@_@i@e@OOUUa@c@Y]i@q@U]e@w@IOGMKO[m@Yq@Ui@Uk@Qg@KWSm@o@mBk@eB}@oCgBoFeD_K_@gAqDcLKYIWSk@{@mCk@aBk@cBKUEIKUSc@KU_@o@U]Y_@[a@]a@e@e@YWWSWUSMA?[SKGk@Yk@Uc@Qm@Mg@KEAk@Gq@IaAE_A@W@{@Di@Ds@JA?E@oAR_APc@Fu@N}@NyAX{AV{@N{AXyAV{AXyB^uCf@sDn@{AXq@Lu@N}B^YFoAPkANs@BC@u@?m@CWAMAM?_AIw@Mk@MEAw@Ua@OOGc@QKGg@Uo@a@SO}@q@CCq@i@a@[aHsFeEeDm@g@o@i@q@i@g@_@_@YSOCCOKIGEEWQGEUQIEWWq@i@iCoB_BcAaB{@aBq@_A]]MqA_@{@SQEOCA?}@Oc@IE?A?QCmAM{@Gy@GA?_@CeFWkCOkBIyBKgBKyOy@G?MAYAgAIUA}DScCOa@C{BS}BYuB[yAY_Ce@yBg@}D_A{Cs@m@Mo@OoEeA}@UuCo@wCs@EAICMCYGiBa@eLiC}HiBmBc@_Bc@cAYm@Uu@[CA{@a@c@Ua@Ua@YYQIG_@[g@c@][c@c@WYSW_@c@S[W_@S[S[O[U_@O]Q[M]O[M_@Sg@M_@K_@M_@GS]sAMk@Q{@Kg@SeAI_@O{@SkAu@kEc@eCe@iCSiA]kBWkA[kAOm@Y{@?AQi@_@{@e@aAuAgC{@mAsA{Aw@y@uAgAm@a@w@a@KGeBs@AA[KsAe@{Bo@GCc@Ma@KYIOEYIuCaA[M_@Qi@Uk@Yi@Yi@[}A}@MI_@UoAu@e@YqC_BsBmAUMeDqB{@g@i@[uCeB_@UaDmBgEeC_@U_Ak@_@Ue@Yy@e@iGsDeBcAs@c@i@]e@Ue@[IEiF}C_DkBwA{@SKmBiAuCeBGEyA{@MIcDmBmBiAaBaA}FiDaBaAi@]u@c@_@UeAo@uEoCcBaAwA}@sAw@yA{@aBaAaCwAcEcCu@a@OKeAq@iC_ByCaB_CuA{Aw@gB_AaDcBy@e@cB_AmEiCmBiA[SWO{A}@mDuBsAw@CA]Ua@UiC{Ac@W[Qy@a@w@]]Og@Ma@Ig@K]EOAa@C_@Ak@?c@Bw@Fc@DW@aAPkB^sJxAoInAcBX{@JiCb@_@FyJ|AqFx@eG`Am@Je@Fa@Fk@Jm@FsAHk@Bq@Am@Ak@Cs@Ia@IYI]K[Mi@YYSWOa@Yq@k@m@g@}@u@g@a@eByA}BkB{@s@MKc@]_Aw@}OsMaBsAuBcB]Y{AoA_@Yy@s@KG?AWSsBeBeCsBwBeBwAmA}BmBuBiBsAiAgByAa@_@wBeBcBuAII_Aw@g@_@e@_@{AqAk@g@g@_@mAcAk@c@g@[c@Uc@Sm@S[I]I[G_@Ec@CCA_@AGAuDEgEWaBKgCOe@EyAIgAIs@Go@CkCQq@E{BIgAEa@A[AMAM?oBIs@EOAu@EGAI?s@G{@EoAIgAII?aBKm@Ee@Cy@IWAYCyCSC?WCcAEKAC?OAsBOYCWAuDWIAMAE?u@G{@GKAuCWmIu@kAKc@EKA_AIm@GiAOiAOu@IgBSo@G_AIwAKqAIq@Ei@EsAIcAImCO{CUmCQSAWA}CSo@Eo@EaBMMA_BKSAiEYw@Gg@CcAIwIm@A?IAIAmDS?AsBMI?{@Gk@EcAGsAKWAgBMQAk@Eg@Eg@E_@A_@CGA[CYAKAoAGq@AYCY?oAGoCK]?q@EUAiBIWCkAG}BMmF[aAGm@EkBMMAK?}DWSAq@Ec@EKAC?a@CIAG?E?iAIaAGEA_CMs@EsAKWAkAIKAe@CcCOGA{BMgDSeBMe@E_@EI?QCYAa@AWAQ?M?MAK?KAOA[CYCy@KUEMAKAKC[E_B_@oAWYG{Co@q@MMEA?s@QYIWIq@[m@]EAa@W]S]WWYMO[[gAiAcAeAUWEEUUUWa@c@UWQQcAeAg@k@mAoAIKGG_@c@SSw@}@QSa@k@e@w@e@y@q@cBm@mBs@eCe@_BWy@[eA_@qAg@cBM_@M[O_@O_@Sc@IOAAS_@QWGKOWMOMQW[SWSSKIIG{BqBQQMKCCAAA?SQSS_Ay@u@q@_@]CAAACCCCi@e@KKYWAAs@k@[Y][a@_@WUm@g@",
//                       },
//                     "start_location":
//                       { "lat": 40.0333486, "lng": -3.925665899999999 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "1.7 km", "value": 1693 },
//                     "duration": { "text": "2 mins", "value": 111 },
//                     "end_location": { "lat": 40.4001319, "lng": -3.7183967 },
//                     "html_instructions": "Take exit <b>2A</b> to merge onto <b>M-30</b> toward <b>A-5</b>/<wbr/><b>Badajoz</b>/<wbr/><b>A-6</b>",
//                     "maneuver": "ramp-right",
//                     "polyline":
//                       {
//                         "points": "oxpuFtlrUIWEGGIEGAGEOAKAA?EAI?G@G?A?IBK@IBI?ADIDIDKJOHKLKHIJGDAFEDAFADADAP@H@BB@?HDDBFFBB@D@BBFBF@H?L?N@b@EHGFUd@Ud@CHg@tAQr@EPGTGRMj@?@Id@S`A?l@?TETETEVCNADMl@q@rDKf@ENMj@ABg@pBCJ?@Oh@Oh@Mh@Oh@Mh@A@Of@Qj@Yx@Yr@s@hB]n@CFQ^CDCDEFEJEJ{BfDwA~BMPINQXEHQ\\CFOd@Qj@AB]fCIl@EREVIl@Ij@SzAEPER?j@@\\?HDn@@`@Fz@DlAFlA",
//                       },
//                     "start_location": { "lat": 40.3957623, "lng": -3.7039499 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "0.5 km", "value": 487 },
//                     "duration": { "text": "1 min", "value": 38 },
//                     "end_location": { "lat": 40.4026657, "lng": -3.7219427 },
//                     "html_instructions": "Keep <b>left</b> to stay on <b>M-30</b>",
//                     "maneuver": "keep-left",
//                     "polyline":
//                       {
//                         "points": "ysquF~fuU?\\@T?H@V?V?HAd@?@Cj@Gf@G\\GVAFCFIZCFA@K`@Sr@s@EWEMEC?KEECc@DO@O@C@UFE@IBUJa@ZWZKNMPGFMZIPUx@EDMPY`@",
//                       },
//                     "start_location": { "lat": 40.4001319, "lng": -3.7183967 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "0.7 km", "value": 692 },
//                     "duration": { "text": "1 min", "value": 42 },
//                     "end_location":
//                       { "lat": 40.40876859999999, "lng": -3.7214006 },
//                     "html_instructions": "Keep <b>left</b> to stay on <b>M-30</b>",
//                     "maneuver": "keep-left",
//                     "polyline":
//                       {
//                         "points": "ucruFb}uUkA\\YDK?a@DYBc@BA?aAHi@FW@e@Du@BQ?c@?i@C]AC?KASCc@Gi@Kc@KYGECk@OoA_@q@UYKICy@UMEo@Iw@EyAA",
//                       },
//                     "start_location": { "lat": 40.4026657, "lng": -3.7219427 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "0.3 km", "value": 259 },
//                     "duration": { "text": "1 min", "value": 27 },
//                     "end_location": { "lat": 40.4110837, "lng": -3.721353 },
//                     "html_instructions": "Take exit <b>17</b> toward <b>Pᵒ V. del Puerto</b>/<wbr/><b>C/<wbr/> Segovia</b>",
//                     "maneuver": "ramp-right",
//                     "polyline":
//                       {
//                         "points": "yisuFvyuUm@QMAk@BQ?Q@A?a@@A?S@M?[?aABG?{@@A?U?G@S?M?UG",
//                       },
//                     "start_location":
//                       { "lat": 40.40876859999999, "lng": -3.7214006 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "0.3 km", "value": 324 },
//                     "duration": { "text": "1 min", "value": 66 },
//                     "end_location": { "lat": 40.4139789, "lng": -3.7209563 },
//                     "html_instructions": "Merge onto <b>P.º de la Virgen del Puerto</b>",
//                     "maneuver": "merge",
//                     "polyline":
//                       { "points": "gxsuFlyuUkAAIAu@Co@Ew@GUCk@GGAmBSUAsAKm@G" },
//                     "start_location": { "lat": 40.4110837, "lng": -3.721353 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "0.8 km", "value": 764 },
//                     "duration": { "text": "2 mins", "value": 115 },
//                     "end_location": { "lat": 40.413898, "lng": -3.7119377 },
//                     "html_instructions": "Turn <b>right</b> onto <b>C. de Segovia</b>",
//                     "maneuver": "turn-right",
//                     "polyline":
//                       {
//                         "points": "kjtuF~vuUBu@?m@@_D?q@@kB@y@?e@?a@@{A@iC?C?e@?k@?mA?E?S@e@?}A?]?q@?u@?mC?i@?K?_@?M?O?C?G?]?I?W?_A?}A?M@c@?IAQ",
//                       },
//                     "start_location": { "lat": 40.4139789, "lng": -3.7209563 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "0.1 km", "value": 95 },
//                     "duration": { "text": "1 min", "value": 25 },
//                     "end_location":
//                       { "lat": 40.4144408, "lng": -3.712543399999999 },
//                     "html_instructions": "Turn <b>left</b> onto <b>C. de la Villa</b>",
//                     "maneuver": "turn-left",
//                     "polyline":
//                       {
//                         "points": "{ituFr~sUS?W?A?A?A@ERGZCHEREPELAD?@A@A@A?A@A?A?CAAAAA",
//                       },
//                     "start_location": { "lat": 40.413898, "lng": -3.7119377 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "84 m", "value": 84 },
//                     "duration": { "text": "1 min", "value": 21 },
//                     "end_location": { "lat": 40.414991, "lng": -3.7122205 },
//                     "html_instructions": "<b>C. de la Villa</b> turns <b>right</b> and becomes <b>C. del Pretil de los Consejos</b>",
//                     "polyline": { "points": "gmtuFjbtUEKCECCCCACEAC?iALEm@" },
//                     "start_location":
//                       { "lat": 40.4144408, "lng": -3.712543399999999 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "26 m", "value": 26 },
//                     "duration": { "text": "1 min", "value": 7 },
//                     "end_location":
//                       { "lat": 40.4152243, "lng": -3.712259699999999 },
//                     "html_instructions": "Turn <b>left</b> onto <b>C. del Sacramento</b>",
//                     "maneuver": "turn-left",
//                     "polyline": { "points": "uptuFj`tUm@F" },
//                     "start_location": { "lat": 40.414991, "lng": -3.7122205 },
//                     "travel_mode": "DRIVING",
//                   },
//                   {
//                     "distance": { "text": "0.6 km", "value": 626 },
//                     "duration": { "text": "3 mins", "value": 175 },
//                     "end_location": { "lat": 40.4165207, "lng": -3.705076 },
//                     "html_instructions": "Turn <b>right</b> onto <b>C. Mayor</b>",
//                     "maneuver": "turn-right",
//                     "polyline":
//                       {
//                         "points": "crtuFr`tUCMIaACYAOE]C[AAI{@?CSiBGk@ESE[UuAESAGCKIg@EWIm@Ge@?GIe@Ga@Ge@AC?IAG?CGo@Ek@Gq@Ek@?ICSEs@CYOiBCa@QkC",
//                       },
//                     "start_location":
//                       { "lat": 40.4152243, "lng": -3.712259699999999 },
//                     "travel_mode": "DRIVING",
//                   },
//                 ],
//               "traffic_speed_entry": [],
//               "via_waypoint": [],
//             },
//           ],
//         "overview_polyline":
//           {
//             "points": "quhrF`rqWcHzBaNzDeG~A][?k@lA{Dr@mBR]HmA[WQDWE[g@mAeE?]QOeAcE[kFEiJHOEo@{@_@kCqA]@Ol@q@T{NUcDOQKOUi@@QPe@NuFKmJY_Fm@iCeAaCq@wCKkBE}FoBcCUcBIwOXoJOsC]}KcCuHkBsIyAkHqA_ImB_LmCqHmBmHuCiRcIkG{Dk\\gMueAs`@aLeEaFoA{IuA{OqCqGsByPoFmLuBaHmCiLwHoJyFqSwNiEcCoFiBwH{B{DaBsIoFwQqL_IwGiGaEoHsDcG{DuH_GiPuKsMaI_NiJudAoq@iu@if@aJ}FqIuEqNgFmIiBgH_AuFa@qGIaPh@cPhAeIDqFg@kFqA_FyBsEaD}DcEgDeFoC_GiGoR{ImZmHaVuFuNkIsPgE}GqMqP{LoLi]oX}cA}x@qp@{h@sP{MgXwTq|@g~@qGuHoCiHuBoPqCiVaMghAqBoQkAmGsBiGmEiIsFkGmGeEokA}j@eUoN}NoJsKaHuJuHsDaE_DoE}CsF{CeGqD{FaCsCoCmCgFeE}IaFoFwBcG}A}MgDgi@aNoMcDwJcCkOoEcKkDiVgIsXcLwIqC}ImBaHcAaFu@}HkBcMsEuKaEkJaEyG_DoIaDoSwHsLiDyMuEoQ{HgXaKyv@kYyd@{PkMyEsGuCgEgD_EwFcEqK_Rck@yEyM{AcCyBaCeEcC_Cm@_FUiI`A_QzCaZhFiFl@_CCsCYkCu@mF_DkYcUsGaFaE_CaDoA}DgA{Eo@oVqAoWuA_N{@mMuBu]eI}_@{I_IwByCuAqFiEoDeFeC{F_C}J_FyX}AaGwAiDqCuEkCuCgEsCaLuDkJkDue@_Yml@u]wn@e_@gYsP_ZqPsd@_X_DeAwBWgDHiFx@yr@rK{J|AyE`@_EQuBm@}BwAeEkDq_@c[uIeHgh@{b@}F}E{CiBkE{@eLa@iJk@oQ_AgTkAuXiBs`@sDqPqAuV_Bqg@iDuSsAaa@kBqTuA{k@uDkMiC}Aa@}BeAuB}AuD{DuE_FeGyG_DaG_DmKsD{KeBoCwL_LuHwGi@wADaAx@sA|@a@|@\\L`ACl@]l@sAxDc@fB]vCwApI}ApGyBvHoChGiGzJ[n@aA|EiAtH^|J@~Co@|DMb@Sr@s@Ee@KOEiADi@N{ArAm@fAcArBsCh@_Hd@aDK_IqB}Ae@oEWyBOw@B{EF{FSgK_ALg]@_Q?cE@m@UQ]@WlAUl@QQMQIAiALEm@q@EM{AMkAmAoJq@uEqAsOQkC",
//           },
//         "summary": "A-42",
//         "warnings": [],
//         "waypoint_order": [],
//       },
//     ],
//   "status": "OK",
// });
   
//    String overviewPolyline = response.routes.first.overviewPolyline;

//       List<PointLatLng> _pointLatLng   = PolylinePoints().decodePolyline(overviewPolyline);

//       myPrint(_pointLatLng.length, heading: 'The length of the PointLatLng');
   

 


// cancelling subscription will also stop the ongoing location request
//subscription.cancel();


  // BackgroundLocation.startLocationService().then((value){

  //   myPrint('location service started');

  
   
  //       BackgroundLocation.getLocationUpdates((location) {
  //          myPrint('receiving location updates');
  //       FirebaseFirestore.instance.doc('test/background_location_data').set({'latitude': location.latitude,'longitude': location.longitude
  //       });
  //   });
    
  //  //  });
    
  // });
   

  
 location =  Location();
  //setupBackgroundLocationCalls();
   
    super.initState();
  }

 

 setupBackgroundLocationCalls()async{
    
bool locationSettings = await location.changeSettings(accuracy: LocationAccuracy.high,);
 
 if(locationSettings){
   myPrint('Location settigns changed');
 }else{
   myPrint('Error Changing location settings');
 }
 
 await  location.enableBackgroundMode(enable: true);
 myPrint('Background Location enabled');

    location.onLocationChanged.listen((LocationData currentLocation) {
        myPrint('lat:${currentLocation.latitude}, lng:${currentLocation.longitude}');
        // FirebaseFirestore.instance.doc('test/background_data').set({'latitude': currentLocation.latitude,'longitude': currentLocation.longitude,'bearing':currentLocation.heading});
});
  
 }






  
 TimelineTween<AnimPros> createTween(){
  var tween =  TimelineTween<AnimPros>();
  tween.addScene(begin: Duration.zero, end: Duration(milliseconds: 500),).animate(AnimPros.elevation, tween: Tween(begin: 10.0, end: 2),curve: Curves.easeInOut).animate(AnimPros.scale, tween: Tween(begin: 0.9,end: 1.0),curve: Curves.easeInOut) ;

return tween;
  
 }
Color customFadedColor = const Color(0xFF636363);
//  
  
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<UserModel>(
        
      child:
      Container(
          width: _w,
          height: _h,

          child: true ? 
             Column(
               children: [
                 Container(
                  margin:const EdgeInsets.only(left:5,top: 100.0 ),
                  width: 20.0,height: 20.0,
                  padding: EdgeInsets.all(2.5),
                  child: Container(width: 15.0, height: 15.0,decoration: BoxDecoration(
                    color: true ? black : white,
                    shape: BoxShape.circle)),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0,color: black),
                    shape: BoxShape.circle,
            ) ),
               ],
             )
          :
           Stack(
             alignment: Alignment.bottomCenter,
           
            children: [

              
             
                Visibility(
                  visible: false,
                  child: Material(
                    elevation:20,
                    borderRadius: BorderRadius.circular(20),
                    color: black,
                    child:Container(
                      width: _w,
                      height: _h * 0.9,
                        padding:const EdgeInsets.only(top: 25.0,right: 17.0,left: 17.0),
                      child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                   Container(
                                     width:_w ,
                                   
                                     margin:const EdgeInsets.only(bottom: 20.0),
                                     child: Row(
                                       children: const [
                          
                                         Text('Send Parcel',style: TextStyle(color: white, fontSize: 15.0,fontWeight: FontWeight.bold)),
                                         Expanded(child: SizedBox()),
                                         Icon(Feather.x,color: white,size: 25.0),
                                         
                                       ],
                                     ),
                                   ),
                               
                                  Row(
                                    children: [
                                  parcelDetailsBreadcrumbsWidget(1,currentlyActive: true),
                                  parcelDetailsBreadcrumbsWidget(2),
                                  parcelDetailsBreadcrumbsWidget(3),
                                  parcelDetailsBreadcrumbsWidget(4,showDottedLines: false),
                                    ],
                                  ),
                                 
                                  
                           
                              ],
                            ),
                          
                        
                   )
                      
                  ),
                ),

           
          true ? Visibility(visible: false,child: parcelRequestConfirmedWidget())   :  AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child:

                           
                        Container(
                          width: _w,
                          height: _h * 0.7,
                          padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                          child: 
                         Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children:const [
                                Text('Choose Dispatch',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                               
                               
                 
                              ]
                            ),
                          ),

                          SizedBox(
                            width: _w,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               

                                Column(
                                 children: [
                                  Container(
                              width: 80,
                              height: 80.0,
                              margin:const EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: LinearGradient(
                                  colors: [logoMainColor.withOpacity(0.9),logoMainColor],
                                  stops:const [0.3,1],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Image.asset('assets/images/delivery_bike.png',fit:BoxFit.cover)),
                                  Text('Nearest',style: TextStyle(color: black,fontWeight: FontWeight.bold,fontSize: 13.5)),
                                
                                 ],),


                              Column(
                                       children: [
                                           Container(
                                    width: 80,
                                    height: 80.0,
                                    margin:const EdgeInsets.only(bottom: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      gradient: LinearGradient(
                                        colors: [customFadedColor.withOpacity(0.5),customFadedColor.withOpacity(0.2)],
                                        stops:const [0.3,1],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                            ),
                                            child: Image.asset('assets/images/delivery_bike.png',fit:BoxFit.cover)),
                                        Text('Standard',style: TextStyle(color: customFadedColor.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 13.5)),
                                      
                                       ],),
                                 

                               
                                  Column(
                                 children: [
                                     Container(
                              width: 80,
                              height: 80.0,
                              margin:const EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: LinearGradient(
                                  colors: [customFadedColor.withOpacity(0.5),customFadedColor.withOpacity(0.2)],
                                  stops:const [0.3,1],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Image.asset('assets/images/delivery_bike.png',fit:BoxFit.cover)),
                                  Text('Custom Courier',style: TextStyle(color: customFadedColor.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 13.5)),
                                
                                 ],),

                             

                             ]
                           ),
                          ),


                      Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),

                           SizedBox(
                             width: _w,
                             child: Row(
                               children: [
                                 Icon(FontAwesome.map_marker,color:customFadedColor,size: 15.0),
                                
                               const  Text(' 21 km',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(Feather.clock,color:customFadedColor,size: 12.0),
                                
                               const  Text(' 8 mins',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(MaterialIcons.payments,color:customFadedColor,size: 18.0),
                                
                               const  Text( ' ${Constants.CEDI_SYMBOL} 25',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               

                               ],
                             ),
                           ),


                        Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),




                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const SizedBox(height: 15.0),
                    
                         Row(children: [
                             
                 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              
                 
                             
                           Row(children: [
                            Column(
                              children: [
                                Container(decoration: BoxDecoration(color: white,shape: BoxShape.circle,border: Border.all(width: 6.0, color: logoMainColor), ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                 Container(width:1.5,height:_w * 0.15,decoration: BoxDecoration(color: black.withOpacity(0.5),borderRadius: BorderRadius.circular(4.0)),),
                                 Container(decoration: BoxDecoration(shape: BoxShape.circle,color: white,border: Border.all(width: 6.0, color: black) ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                              ],
                            ),
                 
                          const  SizedBox(width: 10.0,),
                 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pickup',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                            const    SizedBox(height: 7.5),
                            const   Text('Neon Cafe, 23/A Park Avenue',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                 
                            Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.67,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),
                 
                             Text('Drop Off',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                            const    SizedBox(height: 7.5),
                            const   Text('Rex House, 769 Isadore',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),       
                 
                            ],),
                 
                        
                 
                          ],),
                 
                         ],),
                 
                            const  SizedBox(width: 20.0),
                            Container(margin:const EdgeInsets.only(bottom: 15.0),padding:const EdgeInsets.all(4.0),decoration: BoxDecoration(shape: BoxShape.circle, color:  customFadedColor.withOpacity(0.05)),child:
                              
                              Transform.rotate(angle: 3.14 * 0.2,child: const Icon(AntDesign.swap , color: Color(0xFF0091FF),size: 15.0))),
                            
                 
                 
                            ],),
                 
                     
                     ]
                      ),
                      
                      const Expanded(child: SizedBox(),),

                  Row(
                    children: [
                          
                               Container(width: _w * 0.2,padding:const EdgeInsets.symmetric(vertical: 16.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(10.0),), child:Transform.rotate(angle: 3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left ,color: white, size:  30.0,)),),

                                 Container(width: _w * 0.65,padding:const EdgeInsets.symmetric(vertical: 23.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: logoMainColor,  borderRadius: BorderRadius.circular(10.0),), child:const Text('Request a Delivery' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),),

                    ]
                  ),
                    

                      ]   
                          ),
                   
                   
                          )
                        )



           )])
     
     
     
     
      )
  );
  }

  Widget courierServiceSearchWidget(){
    return   Container(
                  width: _w,
                  padding:const EdgeInsets.only(left: 15.0,right: 15.0,top: 75.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(
                         width: _w,
                         child: Row(
                           children: [
                             Text('Search for Courier Service',style: TextStyle(color:black.withOpacity(0.8),fontSize: 25.0,fontWeight: FontWeight.bold,)),
                             const Expanded(child: SizedBox()),
                             Icon(Feather.x ,color: customFadedColor,size: 25.0)
                           ],
                         ),
                       ),
               
              const SizedBox(height: 35.0),
                     Row(
                       children: [
                         Container(
                           width: _w * 0.73,
                           margin:const EdgeInsets.only(right: 10.0),
                           padding:const EdgeInsets.symmetric(vertical: 11.5, horizontal: 10.0),
                           child: Row(
                             children: [
                               Icon(EvilIcons.search,color: customFadedColor.withOpacity(0.5),size: 25),
                                 Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                width: _w * 0.5,
                                 padding:const EdgeInsets.only(right: 15.0), child: TextField(
                                 
                                  controller: TextEditingController(),
                                
                                 textAlign: TextAlign.left,
                                  style:const TextStyle(
                                    fontSize: 14.3,
                                    color: warmPrimaryColor,
                                    fontWeight : FontWeight.bold,
                                  ),
                               
                                  cursorColor: warmPrimaryColor,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'courier service',
                                    hintStyle: TextStyle(
                                      color: customFadedColor.withOpacity(0.5),
                                     fontSize: 14.3,
                                    ),
                                  ),
                                  onChanged: (String parcel){

                                  },
                                ),
                              ),
                                
                                const Expanded(child: SizedBox()),
                                  InkWell(
                                    onTap: (){
                                      
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(3.5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: customFadedColor.withOpacity(0.1),
                                      ),
                                      child: Icon(Feather.x,color: customFadedColor.withOpacity(0.2),size: 15)),
                                  ),



                             ]
                           ),
                           decoration: BoxDecoration(
                             border: Border.all(color: customFadedColor.withOpacity(0.2)),
                             borderRadius: BorderRadius.circular(10.0),
                           )
                         ),
                         
                           Container(
                              width: 55.0,
                              height: 55.0,
                             
                              alignment: Alignment.center,
                              child:const Icon(Fontisto.equalizer,size: 18.0,color: white),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: logoMainColor,
                              ),
                                                                
                           ),
                            
                             
                      
                       ],
                     ),

                    Container(margin:const EdgeInsets.symmetric(vertical: 25.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),

                 
                       RichText(text: TextSpan(
                           text: 'Results for ',
                           style: TextStyle(color: customFadedColor.withOpacity(0.5),fontSize: 13.5, ),
                           children: [
                             TextSpan(
                               text: 'Ups',
                               style: TextStyle(color: customFadedColor.withOpacity(0.95),fontSize: 14.5, fontWeight: FontWeight.bold),
                             ),


                           ]
                         ),) ,   
                      
                    const SizedBox(height: 15.0),
                  SizedBox(
                    width: _w,
                    height: _h * 0.5,
                    child: ListView(
                 
                      children: [
                       
                         Container(
                      width: _w * 0.73,
                      margin:const EdgeInsets.only(right: 10.0,bottom: 20.0),
                      padding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      child: Row(children: [
                           Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Icon(FontAwesome5Brands.ups,color: logoMainColor,size: 18.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                 Text(
                                   'UPS',
                                   style: TextStyle(color: black.withOpacity(0.9),fontSize: 13.5, fontWeight: FontWeight.bold),
                                 ),
                                const SizedBox(height: 3.5),
                                  Row(
                                    children: [
                                      Text(
                                 '4.9 ',
                               style: TextStyle(color: customFadedColor.withOpacity(0.7),fontSize: 11.5, fontWeight: FontWeight.bold,),
                            
                             ),

                              SmoothStarRating(
                            rating: 4.2,
                            size: 13.5,
                            color:goldColor,
                            borderColor:customFadedColor.withOpacity(0.08),
                            defaultIconData:AntDesign.star ,
                            filledIconData:AntDesign.star, 
                            halfFilledIconData: FontAwesome5.star_half,
                           
                            ),
                                    ],
                                  ),

                            ],
                          ),
                      ],), 
                      decoration: BoxDecoration(
                        border: Border.all(color: customFadedColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10.0),
                      )
                      ),
                     
                       Container(
                      width: _w * 0.73,
                      margin:const EdgeInsets.only(right: 10.0,bottom: 20.0),
                      padding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      child: Row(children: [
                           Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Icon(FontAwesome5Brands.dhl,color: logoMainColor,size: 18.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                 Text(
                                   'DHL',
                                   style: TextStyle(color: black.withOpacity(0.9),fontSize: 13.5, fontWeight: FontWeight.bold),
                                 ),
                                const SizedBox(height: 3.5),
                                  Row(
                                    children: [
                                      Text(
                                 '4.3 ',
                               style: TextStyle(color: customFadedColor.withOpacity(0.7),fontSize: 11.5, fontWeight: FontWeight.bold,),
                            
                             ),

                              SmoothStarRating(
                            rating: 4.2,
                            size: 13.5,
                            color:goldColor,
                            borderColor:customFadedColor.withOpacity(0.08),
                            defaultIconData:AntDesign.star ,
                            filledIconData:AntDesign.star, 
                            halfFilledIconData: FontAwesome5.star_half,
                           
                            ),
                                    ],
                                  ),

                            ],
                          ),
                      ],), 
                      decoration: BoxDecoration(
                        border: Border.all(color: customFadedColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10.0),
                      )
                      ),
                     
                     
                      ]
                    ),
                  ),
                  

                    ]
                  ),
                );
         
             
  }
  
  
  Widget requestDeliveryWidget(){
    return   AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child:

                           
                        Container(
                          width: _w,
                          height: _h * 0.7,
                          padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                          child: 
                         Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children:const [
                                Text('Choose Dispatch',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                               
                               
                 
                              ]
                            ),
                          ),

                          SizedBox(
                            width: _w,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               

                                Column(
                                 children: [
                                  Container(
                              width: 80,
                              height: 80.0,
                              margin:const EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: LinearGradient(
                                  colors: [logoMainColor.withOpacity(0.9),logoMainColor],
                                  stops:const [0.3,1],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Image.asset('assets/images/delivery_bike.png',fit:BoxFit.cover)),
                                  Text('Nearest',style: TextStyle(color: black,fontWeight: FontWeight.bold,fontSize: 13.5)),
                                
                                 ],),


                              Column(
                                       children: [
                                           Container(
                                    width: 80,
                                    height: 80.0,
                                    margin:const EdgeInsets.only(bottom: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      gradient: LinearGradient(
                                        colors: [customFadedColor.withOpacity(0.5),customFadedColor.withOpacity(0.2)],
                                        stops:const [0.3,1],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                            ),
                                            child: Image.asset('assets/images/delivery_bike.png',fit:BoxFit.cover)),
                                        Text('Standard',style: TextStyle(color: customFadedColor.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 13.5)),
                                      
                                       ],),
                                 

                               
                                  Column(
                                 children: [
                                     Container(
                              width: 80,
                              height: 80.0,
                              margin:const EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: LinearGradient(
                                  colors: [customFadedColor.withOpacity(0.5),customFadedColor.withOpacity(0.2)],
                                  stops:const [0.3,1],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Image.asset('assets/images/delivery_bike.png',fit:BoxFit.cover)),
                                  Text('Custom Courier',style: TextStyle(color: customFadedColor.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 13.5)),
                                
                                 ],),

                             

                             ]
                           ),
                          ),


                      Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),

                           SizedBox(
                             width: _w,
                             child: Row(
                               children: [
                                 Icon(FontAwesome.map_marker,color:customFadedColor,size: 15.0),
                                
                               const  Text(' 21 km',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(Feather.clock,color:customFadedColor,size: 12.0),
                                
                               const  Text(' 8 mins',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(MaterialIcons.payments,color:customFadedColor,size: 18.0),
                                
                               const  Text( ' ${Constants.CEDI_SYMBOL} 25',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               

                               ],
                             ),
                           ),


                        Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),




                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const SizedBox(height: 15.0),
                    
                         Row(children: [
                             
                 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              
                 
                             
                           Row(children: [
                            Column(
                              children: [
                                Container(decoration: BoxDecoration(color: white,shape: BoxShape.circle,border: Border.all(width: 6.0, color: logoMainColor), ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                 Container(width:1.5,height:_w * 0.15,decoration: BoxDecoration(color: black.withOpacity(0.5),borderRadius: BorderRadius.circular(4.0)),),
                                 Container(decoration: BoxDecoration(shape: BoxShape.circle,color: white,border: Border.all(width: 6.0, color: black) ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                              ],
                            ),
                 
                          const  SizedBox(width: 10.0,),
                 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pickup',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                            const    SizedBox(height: 7.5),
                            const   Text('Neon Cafe, 23/A Park Avenue',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                 
                            Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.67,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),
                 
                             Text('Drop Off',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                            const    SizedBox(height: 7.5),
                            const   Text('Rex House, 769 Isadore',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),       
                 
                            ],),
                 
                        
                 
                          ],),
                 
                         ],),
                 
                            const  SizedBox(width: 20.0),
                            Container(margin:const EdgeInsets.only(bottom: 15.0),padding:const EdgeInsets.all(4.0),decoration: BoxDecoration(shape: BoxShape.circle, color:  customFadedColor.withOpacity(0.05)),child:
                              
                              Transform.rotate(angle: 3.14 * 0.2,child: const Icon(AntDesign.swap , color: Color(0xFF0091FF),size: 15.0))),
                            
                 
                 
                            ],),
                 
                     
                     ]
                      ),
                      
                      const Expanded(child: SizedBox(),),

                  Row(
                    children: [
                          
                               Container(width: _w * 0.2,padding:const EdgeInsets.symmetric(vertical: 16.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(10.0),), child:Transform.rotate(angle: 3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left ,color: white, size:  30.0,)),),

                                 Container(width: _w * 0.65,padding:const EdgeInsets.symmetric(vertical: 23.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: logoMainColor,  borderRadius: BorderRadius.circular(10.0),), child:const Text('Request a Delivery' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),),

                    ]
                  ),
                    

                      ]   
                          ),
                   
                   
                          )
                        )



           );
     
     
  }


  Widget customerBadgeWiningWidget(){
    return         AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child:

                           
                        Container(
                          width: _w,
                          height: _h * 0.55,
                          padding:const EdgeInsets.only(top: 35.0,left:15.0,right: 15.0),
                          child: 
                          Column(
                          
                            children: [

                              SizedBox(
                              width: 120,
                              height: 120.0,
                              child: Image.asset('assets/images/best_gold_badge.png',fit:BoxFit.cover)),
                         
                         const SizedBox(height: 40.0),
                                 
                            const Text('New Badge Earned!',style:  TextStyle(color:black, fontSize: 15.5, fontWeight: FontWeight.bold)),
                            const   SizedBox(height: 7.5,),
                            Text('Congratulations! You have earned a new badge with 25 deliveries.',textAlign: TextAlign.center,style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                           const SizedBox(height: 45.0),
                       

                      
                            
                            

                            const Expanded(child: SizedBox()),
                             
                                  

                                 Container(width: _w * 0.9,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: logoMainColor,  borderRadius: BorderRadius.circular(10.0),), child:const Text('Take a new ride' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),),

                           

                        const SizedBox(height: 20.0),


                            ]
                                )
                                    
                                    
                                              ),
                   
                   
                          )
                        );


  }


  Widget tipDispatchRiderWidget(){
    return   
    
     AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child:Stack(
                      clipBehavior: Clip.none,
                      children: [
                          Positioned(
                            top: -35.0,
                            
                            child: Container(
                              width:_w,
                              alignment: Alignment.center,
                              child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: SizedBox(
                              width: 60,
                              height: 60.0,
                              child: Image.asset(Constants.AVATAR_USER_ICON,fit:BoxFit.cover)),
                                                    ),
                            ),
                          ),   

                           
                        Container(
                          width: _w,
                          height: _h * 0.55,
                          padding:const EdgeInsets.only(top: 35.0,left:15.0,right: 15.0),
                          child: 
                          Column(
                          
                            children: [
                             
                            const Text('Zhan Huo',style:  TextStyle(color:black, fontSize: 15.5, fontWeight: FontWeight.bold)),
                            const   SizedBox(height: 5.0,),
                            Text('Toyota (BFD823-434)',style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                         const SizedBox(height: 40.0),
                                 
                            const Text('Wow 5 start!',style:  TextStyle(color:black, fontSize: 15.5, fontWeight: FontWeight.bold)),
                            const   SizedBox(height: 7.5,),
                            Text('Any additional tip for Zhan Huo?',textAlign: TextAlign.center,style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                           const SizedBox(height: 45.0),
                       

                      
                                 SizedBox(
                                   width: _w,
                                
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                          Container(
                              width: 75.0,
                              height: 75.0,
                              alignment: Alignment.center,
                            
                              child:  Text('${Constants.CEDI_SYMBOL}15.0' ,style:  TextStyle(color: customFadedColor, fontSize: 13.5, fontWeight: FontWeight.bold)),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                  
                              ),  
                            
                                         Container(width: 65.0,
                                        height: 65.0,
                                        margin:const EdgeInsets.symmetric(horizontal: 25.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('${Constants.CEDI_SYMBOL}10.0' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),),

                                            Container(
                              width: 55.0,
                              height: 55.0,
                              alignment: Alignment.center,
                            
                              child:  Text('${Constants.CEDI_SYMBOL}2.0' ,style:  TextStyle(color: customFadedColor, fontSize: 13.5, fontWeight: FontWeight.bold)),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                  
                              ),  
                            

                                     ]
                                   ),
                                 ), 

                                      
                             
                           
                            

                            const Expanded(child: SizedBox()),
                             
                                  

                                 Container(width: _w * 0.9,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Tip' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),),

                           

                        const SizedBox(height: 20.0),


                            ]
                                )
                                    
                                    
                                              ),
                   
                   
                      ],
                    )
                          )
                        );

       
  }

  Widget rateDeliveryExperienceWidget(){
    return     AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child:Stack(
                      clipBehavior: Clip.none,
                      children: [
                          Positioned(
                            top: -35.0,
                            
                            child: Container(
                              width:_w,
                              alignment: Alignment.center,
                              child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: SizedBox(
                              width: 60,
                              height: 60.0,
                              child: Image.asset(Constants.AVATAR_USER_ICON,fit:BoxFit.cover)),
                                                    ),
                            ),
                          ),   

                           
                        Container(
                          width: _w,
                          height: _h * 0.70,
                          padding:const EdgeInsets.only(top: 35.0,left:15.0,right: 15.0),
                          child: 
                          Column(
                          
                            children: [
                             
                            const Text('Zhan Huo',style:  TextStyle(color:black, fontSize: 15.5, fontWeight: FontWeight.bold)),
                            const   SizedBox(height: 5.0,),
                            Text('Toyota (BFD823-434)',style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                         const SizedBox(height: 40.0),
                                 
                            const Text('How was your delivery?',style:  TextStyle(color:black, fontSize: 14.5, fontWeight: FontWeight.bold)),
                            const   SizedBox(height: 7.5,),
                            Text('Your feedback will help improve parcel delivery experience',textAlign: TextAlign.center,style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                            SizedBox(height: 45.0),
                       

                         SmoothStarRating(
                            rating: 4,
                            size: 30.0,
                            color:goldColor,
                            borderColor:customFadedColor.withOpacity(0.08),
                            defaultIconData:AntDesign.star ,
                            filledIconData:AntDesign.star, 
                           
                            ),


                           Container(
                             width: _w * 0.9,
                             height: _h * 0.2,
                             margin:const EdgeInsets.only(top: 25.0),
                             padding:const EdgeInsets.only(top: 10.0,left: 10.0),
                            child: Text('Additional comments...',style: TextStyle(color: customFadedColor.withOpacity(0.2),fontWeight:FontWeight.bold,fontSize: 12.5)),
                             decoration: BoxDecoration(
                               color: customFadedColor.withOpacity(0.08),
                               borderRadius: BorderRadius.circular(15.0),

                             )
                           ),


                                
                                  

                                      
                             
                           
                            

                            const Expanded(child: SizedBox()),
                             
                                  

                                 Container(width: _w * 0.9,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Submit Feedback' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),),

                           

                        const SizedBox(height: 20.0),


                            ]
                                )
                                    
                                    
                                              ),
                   
                   
                      ],
                    )
                          )
                        );

       

  }


  Widget trackRiderToPickupLocation(){
    return    AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child:Container(
                      width: _w,
                      height: _h * 0.83,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: _w,
                            child: Column(
                              children: [
                                Container(
                                  width: 45.0,
                                  height: 4.5,
                                  decoration: BoxDecoration(
                                    color: customFadedColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ],
                            ),
                          ),



                          Container(
                            width: _w,
                            height: 25.0,
                            margin:const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children:const [
                                  Text('ARRIVES IN 7 MIN',style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                              ],
                            )),

                             Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),
                            
                         
                         SizedBox(
                           width: _w,
                         //  height: _h * 0.1,
                           child: Row(
                             children: [
                               ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                 child: SizedBox(
                                   width: 60,
                                   height: 60.0,
                                   child: Image.asset(Constants.AVATAR_USER_ICON,fit:BoxFit.cover)),
                               ),
                               const SizedBox(width: 10.0),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                      const Text('Zhan Huo',style:  TextStyle(color:black, fontSize: 14.5, fontWeight: FontWeight.bold)),
                                   const   SizedBox(height: 5.0,),
                                      Text('Toyota (BFD823-434)',style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                                 ]
                               ),

                               const Expanded(child: SizedBox()),

                               Container(
                                 padding:const EdgeInsets.symmetric(vertical: 3.5,horizontal: 7.5),
                                 decoration: BoxDecoration(
                                   color: customFadedColor.withOpacity(0.07),
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),
                                 child: Row(
                                   children:const [
                                     Icon(Fontisto.star,color:goldColor,size: 11.0),
                                    
                                     Text('4.9',style:  TextStyle(color:black, fontSize: 11.5, fontWeight: FontWeight.bold)),
                                   ]
                                 ),
                               ),
                             ],
                           ),
                         ),

                           Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),

                           SizedBox(
                             width: _w,
                             child: Row(
                               children: [
                                 Icon(FontAwesome.map_marker,color:customFadedColor,size: 15.0),
                                
                               const  Text(' 21 km',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(Feather.clock,color:customFadedColor,size: 12.0),
                                
                               const  Text(' 8 m',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(MaterialIcons.payments,color:customFadedColor,size: 18.0),
                                
                               const  Text( ' ${Constants.CEDI_SYMBOL} 25',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               

                               ],
                             ),
                           ),


                        Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),
                     

                         Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                                Icon(Fontisto.map_marker_alt,color:customFadedColor,size: 15.0),

                                const  Text( ' Pickup Point',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5)),
                                const Expanded(child: SizedBox()),
                              const  Text('CHANGE',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                 
                              ]
                            ),
                          ),



                        
                            Container(
                              width: _w,
                              height: _h * 0.25,
                              margin:const EdgeInsets.only(bottom: 25.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                child: GoogleMap(
                                          
                                          onMapCreated: (controller){},
                                          myLocationEnabled: true,
                                                        
                                          myLocationButtonEnabled: false,
                                          mapType: MapType.normal ,
                                        
                                          onCameraIdle: ()async{
                                   
                                               },
                                          onTap: (LatLng latLng){
                                                   },
                                      compassEnabled: false,
                                      zoomControlsEnabled: false,
                                      initialCameraPosition:const CameraPosition(
                                          target: LatLng(5.6778757, -0.0174085),
                                          bearing: 120.0,
                                          zoom:15.0,
                                      ),
                                                                                        
                                                                                      ),
                              ),
                                        
                            ),
                          

                        const Expanded(child: SizedBox()),
                                
                             Row(
                          children:[

                           Container(
                              width: 55.0,
                              height: 55.0,
                              alignment: Alignment.center,
                            
                              child:  const Icon( Foundation.telephone, size:  30.0,),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),  
                              

                             Container(width: _w * 0.72,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Cancel Request' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),)

                          ]
                        ),

                    const SizedBox(height: 20.0),


                        ]
                            )
                                
                                
                                          )
                          )
                        );

       
  }

  Widget parcelRequestConfirmedWidget(){
    return    AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                         SizedBox(
                           width: _w,
                         //  height: _h * 0.1,
                           child: Row(
                             children: [
                               ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                 child: SizedBox(
                                   width: 60,
                                   height: 60.0,
                                   child: Image.asset(Constants.AVATAR_USER_ICON,fit:BoxFit.cover)),
                               ),
                               const SizedBox(width: 10.0),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                      const Text('Zhan Huo',style:  TextStyle(color:black, fontSize: 14.5, fontWeight: FontWeight.bold)),
                                   const   SizedBox(height: 5.0,),
                                      Text('Toyota (BFD823-434)',style:  TextStyle(color: customFadedColor.withOpacity(0.8),fontSize: 13.5, fontWeight: FontWeight.bold)),

                                 ]
                               ),

                               const Expanded(child: SizedBox()),

                               Container(
                                 padding:const EdgeInsets.symmetric(vertical: 3.5,horizontal: 7.5),
                                 decoration: BoxDecoration(
                                   color: customFadedColor.withOpacity(0.07),
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),
                                 child: Row(
                                   children:const [
                                     Icon(Fontisto.star,color:goldColor,size: 11.0),
                                    
                                     Text('4.9',style:  TextStyle(color:black, fontSize: 11.5, fontWeight: FontWeight.bold)),
                                   ]
                                 ),
                               ),
                             ],
                           ),
                         ),

                           Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),

                           SizedBox(
                             width: _w,
                             child: Row(
                               children: [
                                 Icon(FontAwesome.map_marker,color:customFadedColor,size: 15.0),
                                
                               const  Text(' 21 km',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(Feather.clock,color:customFadedColor,size: 12.0),
                                
                               const  Text(' 8 m',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               const Expanded(child:SizedBox()),
                                 Icon(MaterialIcons.payments,color:customFadedColor,size: 18.0),
                                
                               const  Text( ' ${Constants.CEDI_SYMBOL} 25',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5)),

                               

                               ],
                             ),
                           ),


                        Container(margin:const EdgeInsets.symmetric(vertical: 20.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.1),)),
                     

                         Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                                Icon(Fontisto.map_marker_alt,color:customFadedColor,size: 15.0),

                                const  Text( ' Pickup Point',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5)),
                                const Expanded(child: SizedBox()),
                              const  Text('CHANGE',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                 
                              ]
                            ),
                          ),



                        
                            Container(
                              width: _w,
                              height: _h * 0.25,
                              margin:const EdgeInsets.only(bottom: 25.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                child: GoogleMap(
                                          
                                          onMapCreated: (controller){},
                                          myLocationEnabled: true,
                                                        
                                          myLocationButtonEnabled: false,
                                          mapType: MapType.normal ,
                                        
                                          onCameraIdle: ()async{
                                   
                                               },
                                          onTap: (LatLng latLng){
                                                   },
                                      compassEnabled: false,
                                      zoomControlsEnabled: false,
                                      initialCameraPosition:const CameraPosition(
                                          target: LatLng(5.6778757, -0.0174085),
                                          bearing: 120.0,
                                          zoom:15.0,
                                      ),
                                                                                        
                                                                                      ),
                              ),
                                        
                            ),
                          

                        const Expanded(child: SizedBox()),
                                
                             Row(
                          children:[

                           Container(
                              width: 55.0,
                              height: 55.0,
                              alignment: Alignment.center,
                            
                              child:  const Icon( Foundation.telephone, size:  30.0,),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),  
                              

                             Container(width: _w * 0.72,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0,),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Cancel Request' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),)

                          ]
                        ),

                    const SizedBox(height: 20.0),


                        ]
                            )
                                
                                
                                          )
                          )
                        );

       
  }

  Widget parcelPaymentDetailsStepWidget(){
    return     AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 25.0),
                            child: Row(
                              children:const [
                                Text('Select Payment',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                 Expanded(child: SizedBox()),
                                Text('ADD NEW',style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                 
                              ]
                            ),
                          ),

                          Container(
                            padding:const EdgeInsets.symmetric(vertical: 15.0,horizontal:15),
                            margin: EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                                Material(
                                  elevation: 0,
                                  color: logoMainColor,
                                  borderRadius: BorderRadius.circular(15.0),
                                  child:Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child:const Icon(MaterialIcons.payments,color: white,size: 25.0)
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Cash Payment',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                  const  SizedBox(height: 7.5),
                                    Text('Default method',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color: customFadedColor.withOpacity(0.45))),


                                  ]
                                ),

                                const Expanded(child: SizedBox()),
                             const   Icon(MaterialIcons.check_circle,color: black,size: 20),
                              ]
                            ),
                            decoration: BoxDecoration(
                              color: customFadedColor.withOpacity(0.1),
                              borderRadius:BorderRadius.circular(12.5),
                            ),
                          ),
                           Container(
                            padding:const EdgeInsets.symmetric(vertical: 15.0,horizontal:15),
                            margin: EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                             
                                  Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child:Image.asset(Constants.MTN_MOMO_LOGO,fit:BoxFit.cover)
                                  ),
                                
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Mtn Momo',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                  const  SizedBox(height: 7.5),
                                    Text('*** **** ***',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold,color: customFadedColor.withOpacity(0.45))),


                                  ]
                                ),

                                const Expanded(child: SizedBox()),
                                Icon(MaterialIcons.check_circle,color: false ?  black : customFadedColor.withOpacity(0.5),size: 20),
                              ]
                            ),
                            decoration: BoxDecoration(
                              color: customFadedColor.withOpacity(0.1),
                              borderRadius:BorderRadius.circular(12.5),
                            ),
                          ),

                            SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("Payer",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Text('Me',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              ),
                            Container(
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              padding:const EdgeInsets.all(10.0),
                              child:const Text('receipient',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                       

                        Container(margin:const EdgeInsets.symmetric(vertical: 15.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),


                       const   Text('Promo Code',style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20.0),

                      Container(
                             width: _w * 0.9,
                            padding:const EdgeInsets.symmetric(vertical: 25.0,horizontal:15),
                            margin:const EdgeInsets.only(bottom: 15.0),
                            alignment: Alignment.center,
                            child: const Text('ADD PROMO CODE',style: TextStyle(fontSize: 12.5,color: Color(0xFF0091FF),fontWeight: FontWeight.bold)),
                         decoration: BoxDecoration(
                              border:Border.all(width: 1.0,color: customFadedColor.withOpacity(0.15)),
                              color: customFadedColor.withOpacity(0.07),
                              borderRadius:BorderRadius.circular(12.5),
                            ),
                      ),

                    const Expanded(child: SizedBox()),

                               Row(
                          children:[

                           Container(
                              width: 55.0,
                              height: 55.0,
                              alignment: Alignment.center,
                            
                              child: Transform.rotate(angle: 3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left , size:  30.0,)),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),  
                              

                             Container(width: _w * 0.72,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Request Parcel Delivery' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),)

                          ]
                        ),




                       const Expanded(child: SizedBox()),

                        ]
                            )
                                          )
                          )
                        );

       
  }

  Widget parcelSizeDetailsWidget(){
    return  
      AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35)),
                    child:Container(
                      width: _w,
                      height: _h * 0.9,
                      decoration:const BoxDecoration(
                           borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35)),
                      ),
                      padding:const EdgeInsets.only(left:15.0,right: 15.0),
                      child: 
                      ListView(
                       padding:const EdgeInsets.all(0.0),
                        children: [
                          Column(
                            
                            children: [
                             

                              SizedBox(
                                width: _w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                       const Expanded(child: SizedBox(),),
                                    Container(width: 35.0, height: 4.5,margin: EdgeInsets.only(bottom: 20.0,top: 10.0,right: _w * 0.35),decoration: BoxDecoration(color: customFadedColor.withOpacity(0.2), borderRadius: BorderRadius.circular(5.0))),
                                 
                                  const   Icon(Feather.x, size: 25.0)
                                  ],
                                ),
                              ),

                            ],
                          ),

                         Container(width: _w * 0.9, height: _h * 0.3,margin:const EdgeInsets.only(bottom: 20.0,top: 10.0),decoration: BoxDecoration(color: customFadedColor.withOpacity(0.05), borderRadius: BorderRadius.circular(25.0)),child:  Image.asset('assets/images/parcel_size_1.png',fit: BoxFit.cover)),

                          Container(
                             
                              child:const  Text('PARCEL SIZE 1',style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold)),
                              ),

                               Container(
                                 width:_w,
                                  margin:const EdgeInsets.symmetric(vertical: 30.0),
                              child:  Row(
                                children: [
                                  Text('Max Weight',style: TextStyle(fontSize: 13.5,color: customFadedColor.withOpacity(0.6))),
                                const  Expanded(child: SizedBox()),
                                    Text('1.5kg',style: TextStyle(fontSize: 13.5,color: customFadedColor.withOpacity(0.6))),
                                ],
                              ),
                              ),
                        
                        
                        RichText(
                          text: TextSpan(
                            text: 'This parcel is from the small group of parcels. It has the averagely the same size as a ',
                                style: TextStyle(fontSize: 11.5,color: customFadedColor.withOpacity(0.6)),
                              children: [
                            const TextSpan(
                              text: 'small to medium size mobile phone box.',
                              style: TextStyle(fontSize: 12,fontWeight:  FontWeight.bold,color: black)
                            ),
                              TextSpan(
                              text: '\n\nWhether it has being parceled rounded,cylindrical or any other shape, so far as it can fit into a ',
                              style: TextStyle(fontSize: 11.5,color: customFadedColor.withOpacity(0.6)),
                            ),
                            const  TextSpan(
                              text: 'small to medium size mobile phone box,',
                              style: TextStyle(fontSize: 12,fontWeight:  FontWeight.bold,color: black,)
                            ),
                            TextSpan(
                              text: 'it should be considered as a parcel size 1.',
                              style: TextStyle(fontSize: 11,color: customFadedColor.withOpacity(0.6)),
                              )
                          ]
                          )
                        
                        ),
                        

                        Container(margin:const EdgeInsets.symmetric(vertical: 30.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),

                        SizedBox(
                          width: _w,
                          height: 35.0,
                          child: Row(
                            children: [
                              const Icon(Foundation.lightbulb,color:Color(0xFF0091FF),size:18 ),
                           const SizedBox(width: 7.0),
                              Text('Reference Object',style:TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold, color: customFadedColor.withOpacity(0.3))),
                              const Expanded(child: SizedBox()),
                            const  Text('Phone Box',style:TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold,color:  black )),

                            

                              
                            ]
                          ),
                        ),
                       
                        Container(width: _w * 0.9,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(top: 17.0,left: 10.0),alignment: Alignment.center,decoration: BoxDecoration(color: logoMainColor,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Close' ,style:  TextStyle(color: white, fontSize: 12.5, fontWeight: FontWeight.bold)),),
             

                     
                   
                
              ]
                             )
                          )
                        )
                 );
        
  }

  Widget chooseParcelTypeWidget(){
    return  AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 20.0),
                            child:const  Text('I am sending ?',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                          ),
                 
                   SizedBox(
                     width: _w,
                     height: _h * 0.6,
                     child: ListView(
                     shrinkWrap: true,
                     children:  parcelTypesWidget()

                   ),),

                     
                   
                
              ]
                             )
                          )
                        )
                 );
       
  }

  

   List<Widget> parcelTypesWidget(){
     List<String> types = ['Envelope','Books','Medicines','Jewellery','Television','Sound Systems','Laptop','Mobile Phone','Other electronic gadgets','Metallic Artifacts','Glass Artifacts'];
      return List.generate(types.length, (index) => Container(
        width: _w * 0.9,
        padding:const EdgeInsets.only(bottom: 15.0),
        margin:const EdgeInsets.only(left: 10.0,bottom:20.0),
        decoration: BoxDecoration(
          border: Border(bottom:  BorderSide(width: 1.0,color: customFadedColor.withOpacity(0.1)),
        ),),
        child: Row(
          children: [
           const Icon(MaterialIcons.delivery_dining, size: 20),
           SizedBox(width: 15.0),
          Text(types[index],style: TextStyle(color: customFadedColor.withOpacity(0.8), fontSize: 14.5,fontWeight: FontWeight.bold)),
          ],
        ),
      ));
    }

   Widget parcelSizeWidget({imagePath = 'assets/images/parcel_size_1.png'}){
    return  
          Stack(
            clipBehavior: Clip.none,
            children: [
    
               Positioned(
                    bottom: _h * 0.1,
                    
                    child: Container(
                      width: _w * 0.42,
                      height: _h * 0.15,
                      alignment: Alignment.bottomCenter,
                      padding:const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: black.withOpacity(0.3) ),
                        borderRadius: BorderRadius.circular(13.0)
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Min. Parcel Price',style: TextStyle(color: customFadedColor.withOpacity(0.07),fontSize: 10.0,fontWeight: FontWeight.bold)),
                  
                            Text('${Constants.CEDI_SYMBOL} 13.99',style: TextStyle(color:  black.withOpacity(0.9),fontSize: 24.0,fontWeight: FontWeight.w400)),
                  
                          ],
                      ),
                    ),
                  ),
    
                 
              Material(
                elevation: 35.0 ,
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: _w * 0.425,
                  height: _h * 0.32,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15.0),
                     color: logoMainColor 
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Small',style: TextStyle(color: white,fontSize: 13.0,fontWeight: FontWeight.bold)),
                      Text('Fits in a shoe box',style: TextStyle(color: white.withOpacity(0.35),fontSize: 11.0,fontWeight: FontWeight.bold)),
    
    
                       Expanded(child: SizedBox()),
                      Container(
                        width: 135,
                        height: 135,
                        child: Image.asset(imagePath,fit: BoxFit.cover),
                      ),
    
    
                      Expanded(flex: 2,child: SizedBox()),
    
                       Container(width: _w * 0.425,alignment: Alignment.centerRight,child: Text('Max. Weight/Length: ',style: TextStyle(color: white.withOpacity(0.3),fontSize: 11.0,fontWeight: FontWeight.bold))),
                      Container(width: _w * 0.425,alignment: Alignment.centerRight,child: Text('15kg | 33cm',style: TextStyle(color: white,fontSize: 14.0,fontWeight: FontWeight.bold))),
                     
    
    
                    ],
                  ),
                ),
              ),
          
              Positioned(
                bottom: _h * 0.17,
                left: 65.0,
                child:const Icon(Ionicons.checkmark_circle,color: logoMainColor,size: 22.0))
          
            ],
          );
  
  }


   Widget parcelTypeWidget (title, {bool isSelected = false}){
    return  Container(
                 
                  height: _w * 0.1,
                
                  padding:const EdgeInsets.only(top: 8.5,right: 25.0,left: 25.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: isSelected ?logoMainColor : white)
                    ,borderRadius: BorderRadius.circular(16.5),color:isSelected ? white : Color(0xFFbf022b)),
                  child: Text(title,style: TextStyle(color:isSelected ? logoMainColor: white, fontSize: 12.5,fontWeight: FontWeight.bold)),
                );
              
              
  } 


  Widget firstParcelDetailsStepWidget(){
    return  
     AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children:const [
                                Text('Parcel',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                 Expanded(child: SizedBox()),
                                Text('Change',style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                 
                              ]
                            ),
                          ),
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const SizedBox(height: 15.0),

                    

                        const   Text('Courier Service / Destination Type',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),

                      const SizedBox(height: 25.0),

                       SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("Courier Service",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Text('Auto',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              ),
                                Container(
                              //width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              padding:const EdgeInsets.all(5.0),
                              child:const Text('Custom',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                  

                      const SizedBox(height: 25.0),

                        SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin: EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: logoMainColor
                                ),
                              ),

                             const   Text("It's Inter-city delivery",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                                Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Text('yes',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              ),
                             
                             
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Text('no',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: black)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),

                              
                              ],
                            ),
                                    
                                                                 


                            ],),
                        ),
                 



                    Visibility(
                      visible: false,
                      child: Row(children: [
                               
                                     
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                
                                     
                               
                             Row(children: [
                              Column(
                                children: [
                                  Container(decoration: BoxDecoration(color: white,shape: BoxShape.circle,border: Border.all(width: 6.0, color: logoMainColor), ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                   Container(width:1.5,height:_w * 0.15,decoration: BoxDecoration(color: black.withOpacity(0.8),borderRadius: BorderRadius.circular(4.0)),),
                                   Container(decoration: BoxDecoration(shape: BoxShape.circle,color: white,border: Border.all(width: 6.0, color: black) ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                ],
                              ),
                                     
                            const  SizedBox(width: 10.0,),
                                     
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pickup',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                              const    SizedBox(height: 7.5),
                              const   Text('Neon Cafe, 23/A Park Avenue',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                                     
                              Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.67,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),
                                     
                               Text('Drop Off',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                              const    SizedBox(height: 7.5),
                              const   Text('Rex House, 769 Isadore',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),       
                                     
                              ],),
                                     
                          
                                     
                            ],),
                                     
                           ],),
                                     
                              const  SizedBox(width: 20.0),
                              Container(margin:const EdgeInsets.only(bottom: 15.0),padding:const EdgeInsets.all(4.0),decoration: BoxDecoration(shape: BoxShape.circle, color:  customFadedColor.withOpacity(0.05)),child:
                                
                                Transform.rotate(angle: 3.14 * 0.2,child: const Icon(AntDesign.swap , color: Color(0xFF0091FF),size: 15.0))),
                              
                                     
                                     
                              ],),
                    ),
                 
                     ]
                      ),
                             
                      Container(margin:const EdgeInsets.symmetric(vertical: 30.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),   


                        const   Text('Quantity and Parcel Type',style: TextStyle(color: logoMainColor, fontSize: 14.5,fontWeight: FontWeight.bold)),

                      const SizedBox(height: 25.0),

                       SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("Parcel Type",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              height: 40.0,
                              alignment: Alignment.center,
                              padding:const EdgeInsets.all(10.0),
                              child:const Text('Tap to select',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              ),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    alignment: Alignment.center,
                                    margin:const EdgeInsets.symmetric(horizontal: 5.0),
                                    child:const Text('No',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                                    decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: customFadedColor.withOpacity(0.07),
                                                              ),
                                                                  
                                                              ),
                                ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                  

                      const SizedBox(height: 25.0),

                        SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin: EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: logoMainColor
                                ),
                              ),

                             const   Text('Quantity',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Icon(AntDesign.minus,size: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 7.5),
                              child:const Text('2',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color:white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: black,
                              ),
                                                                
                              ),

                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Icon(MaterialIcons.add,size: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                                          ),
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),
                 

                        const Expanded(child: SizedBox()),

                    
                        Row(
                          children:[

                           Container(
                              width: 55.0,
                              height: 55.0,
                              alignment: Alignment.center,
                            
                              child: Transform.rotate(angle: 3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left , size:  30.0,)),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),  
                              

                             Container(width: _w * 0.7,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0),alignment: Alignment.center,decoration: BoxDecoration(color: logoMainColor,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Continue' ,style:  TextStyle(color: white, fontSize: 12.5, fontWeight: FontWeight.bold)),)

                          ]
                        ),


                       
                       
                       
                        const SizedBox(height: 15.0),
                             
                        ],
                      ),
                    ),
                     ),
                 );
 
 
  }
 


  Widget uneditedFirstParcelDetailsStepWidget(){
    return   AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children:const [
                                Text('Parcel',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                                 Expanded(child: SizedBox()),
                                Text('Change',style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Color(0xFF0091FF))),
                 
                              ]
                            ),
                          ),
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const SizedBox(height: 15.0),

                    

                        const   Text('Quantity and Destination',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),

                      const SizedBox(height: 25.0),

                       SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("It's Inter-city",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Text('Yes',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Text('No',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                  

                      const SizedBox(height: 25.0),

                        SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin: EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: logoMainColor
                                ),
                              ),

                             const   Text('Quantity',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Icon(AntDesign.minus,size: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Text('2',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color:white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: black,
                              ),
                                                                
                              ),

                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Icon(MaterialIcons.add,size: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                                          ),
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),
                 



                    Visibility(
                      visible: false,
                      child: Row(children: [
                               
                                     
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                
                                     
                               
                             Row(children: [
                              Column(
                                children: [
                                  Container(decoration: BoxDecoration(color: white,shape: BoxShape.circle,border: Border.all(width: 6.0, color: logoMainColor), ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                   Container(width:1.5,height:_w * 0.15,decoration: BoxDecoration(color: black.withOpacity(0.8),borderRadius: BorderRadius.circular(4.0)),),
                                   Container(decoration: BoxDecoration(shape: BoxShape.circle,color: white,border: Border.all(width: 6.0, color: black) ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                                ],
                              ),
                                     
                            const  SizedBox(width: 10.0,),
                                     
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pickup',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                              const    SizedBox(height: 7.5),
                              const   Text('Neon Cafe, 23/A Park Avenue',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                                     
                              Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.67,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),
                                     
                               Text('Drop Off',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                              const    SizedBox(height: 7.5),
                              const   Text('Rex House, 769 Isadore',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),       
                                     
                              ],),
                                     
                          
                                     
                            ],),
                                     
                           ],),
                                     
                              const  SizedBox(width: 20.0),
                              Container(margin:const EdgeInsets.only(bottom: 15.0),padding:const EdgeInsets.all(4.0),decoration: BoxDecoration(shape: BoxShape.circle, color:  customFadedColor.withOpacity(0.05)),child:
                                
                                Transform.rotate(angle: 3.14 * 0.2,child: const Icon(AntDesign.swap , color: Color(0xFF0091FF),size: 15.0))),
                              
                                     
                                     
                              ],),
                    ),
                 
                     ]
                      ),
                             
                      Container(margin:const EdgeInsets.symmetric(vertical: 30.0),width: _w * 0.9,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),   


                        const   Text('Quantity and Destination',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),

                      const SizedBox(height: 25.0),

                       SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin:const EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black
                                ),
                              ),

                             const   Text("It's Inter-city",style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Text('Yes',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: black,
                              ),
                                                                
                              ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Text('No',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color: white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),

                              
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),


                  

                      const SizedBox(height: 25.0),

                        SizedBox(
                          width: _w * 0.9,
                          child: Row(
                            children: [

                              Container(
                                width:7.5,
                                height: 7.5,
                                margin: EdgeInsets.only(right: 10.0),
                                decoration:const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: logoMainColor
                                ),
                              ),

                             const   Text('Quantity',style: TextStyle( fontSize: 14.5,fontWeight: FontWeight.bold)),
                             const Expanded(child: SizedBox()),

                          
                            Row(
                              children: [
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Icon(AntDesign.minus,size: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),
                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child:const Text('2',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold,color:white)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: black,
                              ),
                                                                
                              ),

                                Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child:const Icon(MaterialIcons.add,size: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                                          ),
                              ],
                            ),
                                    
                                                                


                            ],),
                        ),
                 

                        const Expanded(child: SizedBox()),

                    
                        Row(
                          children:[

                           Container(
                              width: 55.0,
                              height: 55.0,
                              alignment: Alignment.center,
                            
                              child: Transform.rotate(angle: 3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left , size:  30.0,)),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),  
                              

                             Container(width: _w * 0.7,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Continue' ,style:  TextStyle(color: white, fontSize: 12.5, fontWeight: FontWeight.bold)),)

                          ]
                        ),


                       
                       
                       
                        const SizedBox(height: 15.0),
                             
                        ],
                      ),
                    ),
                     ),
                 );
 
 
  }
  
  Widget parcelSizeAndTypeWidget(){
    return   AnimatedPositioned(
                    curve:Curves.easeInOut,
                    duration:const Duration(milliseconds: 700),
                    bottom: 0.0,
                   child: Material(
                    elevation:20,
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    child:Container(
                      width: _w,
                      height: _h * 0.72,
                      padding:const EdgeInsets.only(top: 15.0,left:15.0,right: 15.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w ,
                            margin:const EdgeInsets.only(bottom: 20.0),
                            child:const  Text('Select Parcel Size',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),
                          ),
                 
                
                   CarouselSlider(
                carouselController:_carouselController ,
        options: CarouselOptions(
                height:400.0,
                enlargeCenterPage: true,
                viewportFraction: 0.6,
                onPageChanged: (i,reason){
                    myPrint('On Page Changed Called');
                },
                onScrolled: (i){
                        myPrint('On Scrolled Called');
                },
                ),
                
        items: [1,2,3,4,5].map((i) {
                return Builder(
                    builder: (BuildContext context) {
                      return   parcelSizeWidget();
                    },
                );
        }).toList(),
      ),
                 


            SizedBox(
                          width: _w * 0.89,
                          child:
                                 Row(
                          children:[

                           Container(
                              width: 55.0,
                              height: 55.0,
                              alignment: Alignment.center,
                            
                              child: Transform.rotate(angle: 3.14 * 0.25 ,child:const Icon( MaterialCommunityIcons.arrow_bottom_left , size:  30.0,)),
                              decoration: BoxDecoration(
                                border: Border.all(color: customFadedColor.withOpacity(0.07),),
                                borderRadius: BorderRadius.circular(13),
                                color: customFadedColor.withOpacity(0.07),
                              ),
                                                                
                              ),  
                              

                             Container(width: _w * 0.72,padding:const EdgeInsets.symmetric(vertical: 21.0),margin:const EdgeInsets.only(left: 10.0),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Request Parcel Delivery' ,style:  TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.bold)),)

                          ]
                        ),



                       
                        )
                 

                
              ]
                             )
                          )
                        )
                 );
       
       
  }
 
 
  Widget parcelDetailsBreadcrumbsWidget(int step,{bool showDottedLines = true,currentlyActive = false}){
   return  Row(
                               
                        children: [
                          
                          Material(
                            elevation:currentlyActive ? 10.0 : 7.5,
                            borderRadius: BorderRadius.circular(10),
                            color:currentlyActive ? white : white.withOpacity(0.1),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              child: Text('$step',style: TextStyle(color:currentlyActive ? black :  white,fontSize: 13.5,fontWeight: FontWeight.bold)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                 color:currentlyActive ? white : white.withOpacity(0.1),
                              ),
                                                  
                            ),
                          ),
                          
                            Visibility(
                              visible: showDottedLines,
                              child: Row(
                              children: dottedLine(),
                                                      ),
                            ),
                      
                        ],
                      );
                         
 }


 List<Widget> dottedLine(){
   Widget dot =  Container(margin:const EdgeInsets.only(right: 3.0),color: white.withOpacity(0.15),width: 4.9,height: 1);
   return  List.generate(7, (index) => dot) ;
 }
 
 
  Widget pickLocationOnMapWidget(){
   return  Column(
                    children: [
                  
                      Material(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                        width: _w * 0.95,
                        height: 60,
                        padding:const EdgeInsets.symmetric(vertical: 7.5,horizontal: 15.0),
                        decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          children:[
                          const  Icon(Feather.arrow_left,size: 30,),
                            Container(
                              width: _w * 0.7,
                              height: 50,
                              alignment: Alignment.center,
                              margin:const EdgeInsets.symmetric(horizontal:10.0 ),
                              padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: customFadedColor.withOpacity(0.2)
                              ),
                              child:const Text('Picked location',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold)),
                            ),
                          ]
                        ),

                        )
                      ),
                 
                  
                    ],
                  );
  }

  Widget multipleContactsDisplayWidget(){
    return 
    Column(
                    children: [
                      Material(
                        elevation: 30.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child:Container(
                          width: _w ,
                          height:_h * 0.6,
                         
                          padding:const EdgeInsets.only(top: 15.0,bottom: 25.0, left: 15.0,right: 15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                          ),
                        
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 40,height: 3.0,
                                margin: EdgeInsets.only(bottom:15.0,left: _w * 0.4),
                                decoration: BoxDecoration(
                                  color: customFadedColor.withOpacity(0.5),
                                  borderRadius:BorderRadius.circular(7.5) )),
                              Container(
                                width: _w,
                                alignment:Alignment.center,
                                child: const Text('Yussif Muniru',style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold))),
                               
                             const SizedBox(height: 25.0),

                              Row(
                                children: [
                                  const Text('1. \t\t',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                                  Container(
                                    width: _w * 0.8,
                                    padding:const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.0, color: logoMainColor),
                                      borderRadius: BorderRadius.circular(10.0)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('024-179-2877',style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold)),
                                      const  SizedBox(height: 5.0),
                                        Text('+233241792877',style: TextStyle(color: customFadedColor,fontSize: 12.5,fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                               Row(
                                children: [
                                  const Text('2. \t\t',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                                  Container(
                                    width: _w * 0.8,
                                    padding:const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.0, color: logoMainColor),
                                      borderRadius: BorderRadius.circular(10.0)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('024-179-2877',style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold)),
                                      const  SizedBox(height: 5.0),
                                        Text('+233241792877',style: TextStyle(color: customFadedColor,fontSize: 12.5,fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                                const SizedBox(height: 10),
                               Row(
                                children: [
                                  const Text('3. \t\t',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                                  Container(
                                    width: _w * 0.8,
                                    padding:const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.0, color: logoMainColor),
                                      borderRadius: BorderRadius.circular(10.0)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('024-179-2877',style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold)),
                                      const  SizedBox(height: 5.0),
                                        Text('+233241792877',style: TextStyle(color: customFadedColor,fontSize: 12.5,fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          
                          
                            ]
                          ),
                          )),
                    ],
                  );
                
                    
  }

 Widget learnMoreWidgetOfIntercityDelivery(){
  return   Column(
                  children: [
                    Material(
                      elevation: 20,
                      borderRadius:const BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0)),
                      child: Container(
                        width: _w ,
                        height: _h * 0.8,
                        decoration:const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: _h * 0.4,
                              child: Stack(
                                children: [
                    
                                  Positioned(
                                    right: -10,
                                    top: -30.0,
                                    child: 
                                      Container(
                                        width: _w * 0.8 ,
                                        height: _h * 0.4,
                                         decoration:const BoxDecoration(
                                           color: logoMainColor,
                                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular( 45.0)
                                         )
                                        ),
                                      ),
                                    
                                  ),
                                   Positioned(
                                     left: 40,
                                     top: 120.0, 
                                     child: Container(
                                      width: _w * 0.6,
                                      height: _h * 0.45,
                                       decoration: BoxDecoration(
                                       color: white.withOpacity(0.2),
                                       borderRadius: BorderRadius.only(topRight: Radius.circular( 45.0)
                                         )
                                      ),
                                                           ),
                                   ),
                                   Positioned(
                                     left: 200,
                                     top: 80.0, 
                                     child: Material(
                                       elevation: 25.0,
                                         shape:const CircleBorder(),
                                       child: Container(
                                        width: _w * 0.23,
                                        height: _w * 0.23,
                                        decoration:const BoxDecoration(
                                            color: white,
                                          shape: BoxShape.circle,
                                        ),
                                                             ),
                                     ),
                                   ),
                                 
                                  Positioned(top: 40.0,right: 20.0,child: Container(width: _w,alignment: Alignment.centerRight,child: Icon(Feather.x,color: white.withOpacity(0.7),))),
                                ],
                              ),
                            ),
                    
                          Container(
                            margin:const EdgeInsets.only(left: 20,bottom: 20.0),
                            
                            child:const Text('Inter-City Delivery',style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                          ),
                    
                    
                           Container(
                            margin:const EdgeInsets.only(left: 20),
                            
                            child: Text('This setting by far is used for inter-city parcel delivery, where the parcels are sent to the main branch office of the selected courier service for further processing and packaging.\n\n NOTE: This may significantly delay the delivery time of the parcel.The delivery can take up to 24hrs. But also significantly reduce the cost of delivery.Not all courier service companies offer this service.',style: TextStyle(fontSize: 12.5, color: customFadedColor))
                          ),
                    
                         
                          ],
                        ),
                      ),
                    ),
                  ],
                );

}


  Widget parcelDeliveryRequestWidget(){
  return  Container(
          width: _w,height: _h,
          padding:const EdgeInsets.only(top: 100.0),
          child:
         Column(
          children: [
           
            SizedBox(
              width: _w * 0.9,
              height: _h * 0.45,

              child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                        
                      ),
            child: Material(
              elevation: 35.0,
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                padding:const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  
                  children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(65 / 2 ),
                        child: SizedBox(
                          width: 65,
                          height: 65,
                          child: Image.asset('assets/images/test_parcel_3.jpg',fit: BoxFit.cover)),
                      ),

                   const   SizedBox(height: 15.0),

                  const Text('Takeshi Kim',style: TextStyle(color: white, fontSize: 17.5,fontWeight: FontWeight.bold)),

                 const SizedBox(height: 25.0),
                     Text('Senior UI Designer',style: TextStyle(color: white.withOpacity(0.7), fontSize: 14.5,fontWeight: FontWeight.bold)),
                      const   SizedBox(height: 10.0,),
                      SizedBox(
                        width: _w * 0.5,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(Ionicons.pin_sharp,color:  white.withOpacity(0.5),size: 15.0),

                            
                             Text(' Los Angeles, CA',style: TextStyle(color: white.withOpacity(0.5), fontSize: 12.5,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                       const   SizedBox(height: 20.0,),

                        SizedBox(
                          width: _w * 0.5,
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text('35 Posts',style: TextStyle(color: white.withOpacity(0.85), fontSize: 11.5,fontWeight: FontWeight.bold)),
                              Container(
                                height: 8.0,
                                width: 1.50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.5),
                                  color: white.withOpacity(0.5)
                                ),
                                
                              ),
                              Text('295 Followers',style: TextStyle(color: white.withOpacity(0.85), fontSize: 11.5,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),

                       const SizedBox(height: 20.0),

                        CustomAnimation<TimelineValue<AnimPros>>(
                            tween: createTween(),
                            duration: Duration(milliseconds: 500),
                            control: CustomAnimationControl.mirror,
                          builder: (context, child,value) =>
                             
                            SizedBox(
                              width: _w * 0.7,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                        
                                   Transform.scale(
                                     scale: value.get(AnimPros.scale),
                                     child: Material(
                                      elevation: value.get(AnimPros.elevation),
                                      shape:const CircleBorder(),
                                                                     child: Container(
                                      width: 65,
                                      height: 65,
                                      decoration: BoxDecoration(
                                        color: white,
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 1.0,color:const Color(0xFF565663).withOpacity(0.7))
                                      ),
                                      child:const Icon(Feather.x, color: errorColor,size: 25.0)),
                                                ),
                                   ),
                               
                                 
                                  Transform.scale(
                                    scale: value.get(AnimPros.scale),
                                    child: Material(
                                      elevation: value.get(AnimPros.elevation),
                                      shape:const CircleBorder(),
                                    child: Container(
                                      width: 65,
                                      height: 65,
                                      decoration: BoxDecoration(
                                        color: white,
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 1.0,color:Color(0xFF565663).withOpacity(0.7))
                                      ),
                                      child:Icon(Feather.check, color: Colors.green[400],size: 25.0)),
                                                ),
                                  ),
                               
                               
                                ],
                              ),
                            )
                          
                        ),
                         
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                      colors: [const Color(0xFF565663).withOpacity(0.7),const Color(0xFFa8adc1)],
                      stops:const [0.3,0.7],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                  ),
                                          
                     ),
                                        
                                       ),
            ),
                     ),
            ),
          ],
        ),);


}


  Widget deliveryPersonelWidget({required UserModel deliveryPersonel , int index = 0, bool isLast = false}) {

      var image = Random().nextInt(5);
    return Container(
      
       padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(bottom: isLast ? _h * 0.1: 0.0),
       child:Container(
         padding: EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
         border: Border(bottom: BorderSide(width: 0.1, color: Color(0xFFa3a3a3)),
       ),),
         child: Row(
           children: [
             ClipRRect(borderRadius: BorderRadius.circular(15.0),child: Container(
          width: 75,
          height: 75,
         
          child: Image.asset('assets/images/test_parcel_${image == 0 ? 1 : image}.jpg'  ,fit: BoxFit.cover)),),

             Container(
               margin: EdgeInsets.only(left: 20.0),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text('Yussif Muniru',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: black)),
                    Row(
                      children: [
                        Container(
                        
                          margin: EdgeInsets.symmetric(vertical: 7.5),
                          child: Text('Accra ',style: TextStyle(color: Color(0xFFa4a4a4), fontSize: 12.5)),
                        ),
                        Container(
                          width: 3.0,
                          height: 3.0,
                          decoration: BoxDecoration(
                             color: Color(0xFFa4a4a4),
                            shape: BoxShape.circle
                          ),

                         ),

                          Container(
                         
                          margin: EdgeInsets.symmetric(vertical: 7.5,horizontal: 5.0),
                          child: Text('Royal Motorobike ',style: TextStyle(color: Color(0xFFa4a4a4), fontSize: 12.5)),
                          ),

                           Container(
                          width: 3.0,
                          height: 3.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFa4a4a4),
                            shape: BoxShape.circle
                          ),),

                           Container(
                         
                          margin: EdgeInsets.symmetric(vertical: 7.5,horizontal: 5.0),
                          child: Text(Constants.CEDI_SYMBOL + " ${Random().nextInt(1000)} K",style: TextStyle( color: true ? black :Color(0xFFa4a4a4), fontSize: 11.5,fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),

                    Container(
                      
                      child: Row(
                     
                        children: [
                             Icon(AntDesign.star,size: 13.0,color: logoMainColor),
                          Container(
                            margin: EdgeInsets.only(left: 2.0, ),
                            child: Text(' 4.6 ',style: TextStyle(color: logoMainColor, fontSize: 11.5),),),
                          
                            Container(
                            margin: EdgeInsets.only(left: 3.0),
                            child: Text('(1.2k parcels)',style: TextStyle(color: Color(0xFFa4a4a4), fontSize: 11.5,fontWeight: FontWeight.bold)),
                          ),
                          
                           

                           
                          
                        ],
                      )

                    ),
                
               ],),
             )
           ],
         ),
       ),
    );
  }

 ListView activityTypeWidgets(){
  return  ListView(
          scrollDirection: Axis.horizontal,
          children: [
              const  SizedBox(width: 20.0,),
              getActivityTypeWidget('Send Parcel','Put your destination',(){},MaterialCommunityIcons.source_commit_start_next_local,isActive: true), 
              
                    
                  ]
                );
}


 Widget parcelPickUpAndDestinationLocationWidget (){
  return   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                   const   Icon(Feather.x, size: 20.0,),

                 const SizedBox(height: 15.0,),
                      Material(
                        color: white,
                        elevation: 10,borderRadius: BorderRadius.circular(5.0),
                      child: 
                      Container(
                        width: _w * 0.95,
                         height: _h * 0.18,
                         color: white,
                       //  margin:const EdgeInsets.only(top: 20.0),
                        padding:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.5),
                        child: Row(children: [
                          Column(
                            children: [
                              Container(decoration: BoxDecoration(color: white,shape: BoxShape.circle,border: Border.all(width: 6.0, color: black), ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                               Container(width:1.5,height:_w * 0.15,decoration: BoxDecoration(color: black.withOpacity(0.8),borderRadius: BorderRadius.circular(4.0)),),
                               Container(decoration: BoxDecoration(shape: BoxShape.circle,color: white,border: Border.all(width: 6.0, color: black) ),child: Container(width: 3.0, height: 3.0,decoration:const BoxDecoration(shape: BoxShape.circle, color: white))),
                            ],
                          ),

                        const  SizedBox(width: 10.0,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pickup',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 10.5,fontWeight: FontWeight.bold)),
                          const    SizedBox(height: 5.0),
                          const   Text('Neon Cafe, 23/A Park Avenue',style: TextStyle( fontSize: 13.5,fontWeight: FontWeight.bold)),

                          Container(margin:const EdgeInsets.symmetric(vertical: 10.0),width: _w * 0.67,child: Divider(thickness: 1, color:  customFadedColor.withOpacity(0.07),)),

                           Text('Drop Off',style: TextStyle(color: customFadedColor.withOpacity(0.5), fontSize: 10.5,fontWeight: FontWeight.bold)),
                          const    SizedBox(height: 5.0),
                          const   Text('Rex House, 769 Isadore',style: TextStyle( fontSize: 13.5,fontWeight: FontWeight.bold)),       

                          ],),

                        const  SizedBox(width: 10.0),

                        Container(margin:const EdgeInsets.only(bottom: 15.0),padding:const EdgeInsets.all(4.0),decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF0091FF).withOpacity(0.05)),child:Transform.rotate(angle: 3.14 * 0.3,child: const Icon(MaterialIcons.swap_calls, color: Color(0xFF0091FF),size: 15.0)))

                        ],),

                      ),),



         const SizedBox(height: 250.0),
                      Material(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(width: _w * 0.9,padding:const EdgeInsets.symmetric(vertical: 20.0),alignment: Alignment.center,decoration: BoxDecoration(color: black,  borderRadius: BorderRadius.circular(15.0),), child:const Text('Continue',style:  TextStyle(color: white, fontSize: 12.5, fontWeight: FontWeight.bold)),),
                      ),

                      const SizedBox(height:20.0),
                       Stack(
                         clipBehavior: Clip.none,
                         children: [
                           Material(
                             elevation: 30.0,
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(width: _w * 0.5,padding:const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),alignment: Alignment.center,decoration: BoxDecoration(color: white,  borderRadius: BorderRadius.circular(10.0),), child:Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     const Text('Rex House',style:  TextStyle( fontSize: 12.5, fontWeight: FontWeight.bold)),
                                   const  SizedBox(height: 2.5),
                                     Text('769 Isadore isle Suite',style:  TextStyle(color: customFadedColor.withOpacity(0.45),fontSize: 10.5, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                Icon(SimpleLineIcons.arrow_right,color: customFadedColor,size: 12.0 ),
                              ],
                            ),),
                      ),
                        

                         Positioned(
                           bottom: -5.0,
                           left: 20.0,
                           child: Transform.rotate(
                             angle: 3.14 * 0.2,
                             child: Material(
                                  borderRadius: BorderRadius.circular(3.5),
                                  color: white,
                                  child:SizedBox(width: 15.0,height: 15.0),
                                  ),
                           ),
                         )
                        
                         ],
                       ),
                    ]
                  ) ;
}



Widget getActivityTypeWidget(String title, String desc,VoidCallback onTap,IconData icon,{isActive = false}){
  return 
  InkWell(
    onTap: onTap,
    child: Row(
        children: [
          Material(
            borderRadius: BorderRadius.circular(15.0),
            elevation: 15,
            color: white,
            child: Container(
              width: _w * 0.95,
              height: _w * 0.36,
              padding: const EdgeInsets.only(left: 10.0,top: 10.0,),
              decoration: BoxDecoration(
                  color: white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: false ? Row(
                children: [

                      InkWell(
                        onDoubleTap: (){
                          setState(() {
                            _addedToFavorites = !_addedToFavorites;
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                width: _w * 0.2,
                                height: _w * 0.15,
              
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(width: 2.0, color: white)
                                ),
                                margin:const EdgeInsets.only(bottom: 20.0,right: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.asset('assets/images/parcel_size_1.png',fit: BoxFit.cover)),
                              ),
                      
                          Positioned(
                            top: 10.0,
                            child: Column(
                            children: [
                              Icon(_addedToFavorites ? MaterialIcons.favorite  : MaterialIcons.favorite_border,color: black,size: 15.0),
          
                              SizedBox(height: 5.0),
                            Text('Double Tap',style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold,color: black)),
          
                            ],
                          ))
                          ],
                        ),
                      ),

                     Container(width: .5,height:_h * 0.15,margin:const EdgeInsets.only(right: 15.0,bottom: 10),decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.5), color:false ? black : customFadedColor.withOpacity(0.4)), ),         

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text('Ibrahim Tanko',style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.0),
                         Text('Spintex Road | Batsonaa Total filling Station',style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: customFadedColor.withOpacity(0.5))),
                         const SizedBox(height: 5.0),
                           Row(
                             children: [
                               SmoothStarRating(
                                  rating: 4.3,
                                  size: 13.0,
                                  color:const Color(0xFFffdf00),
                                  borderColor: const Color(0xFFffdf00),
                                  defaultIconData: Feather.star,
                                    ),
                              Text(' 4.3',style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: customFadedColor.withOpacity(0.5))),
                             ],
                           ),

                           SizedBox(height: 5.0,),
                           Text('${Constants.CEDI_SYMBOL} 34.00',style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5.0,),
                          Text('Parcel Size 3 - 1 Matellic Artefac',style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: customFadedColor.withOpacity(0.5))),
                         const Expanded(child: SizedBox()),
   SizedBox(
     width: _w * 0.66,
     child: Row(
       children: [
         SizedBox(),
         const Expanded(child: SizedBox()),
         Container(width: 75.0,height: 20.0,decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(8.5),bottomRight: Radius.circular(10)),color: black ) ,child: Text('16/Nov/2021',style: TextStyle(color: white,fontSize: 11.5))),
       ],
     ),
   ),                                         

                    ],),

                   

                ],
                ) :  Column(
                children: [
                false ? 
                Stack(
  children: [
  
        
              PlayAnimation<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, child,value) {
                  return true ? 
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Material(
                          elevation: 30.0,
                          
                        ),
                        Container(
                                    width: 65,
                                    height: 65,
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors:isActive ? [Colors.black.withOpacity(0.7),Colors.black ] : [customFadedColor.withOpacity(0.7),customFadedColor ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops:const [0.3, 1]),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(

                                    icon,
                                    color: white,
                                    size: 30

                                    ),
                                  ),
                      ],
                    )
                    :
                  //  Material(
                  //   elevation:  0.5 * value,
                  //   color: logoBackgroundColor,
                  //   shape:const CircleBorder(),
                  //   child: 
                    Container(
                      margin: EdgeInsets.only(left: 100.0,top: 300.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                      decoration: BoxDecoration(
                        // color:true ? logoMainColor : logoBackgroundColor,
                        gradient: LinearGradient(
                          colors: [black.withOpacity(0.8),black],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops:const [0.1,.9]

                        ),
                        shape: BoxShape.circle,
                        border: Border.all(width: 0.75, color:false ? logoBackgroundColor :  Colors.grey.withOpacity(0.4)) ,
                      ),
                      child: InkWell(
                                onTap: (){
                                  setState(() {
                                        _showSortWidget = !_showSortWidget;
                                  });
                                  
                                },
                                child: Container(
                                  child: Icon(AntDesign.filter,size: 18,color: logoMainColor)
                                ),
                              ),
                        
                      
                    )
                  
                  //)
                  ;
                }
              ),


  
      
      
  ],
)
        
          :    
          
                        Card(
                        elevation: 30,
                        color: black,
                        //shadowColor: black.withOpacity(0.1),
                        shape:const CircleBorder(),
                        child: Container(
                          width: 65,
                          height: 65,
                          padding: const EdgeInsets.only(right: 10.0,left: 10.0,top: 15.0,bottom:15.0 ),
                          decoration:const BoxDecoration(
                            shape: BoxShape.circle,
                            color: black
                          ),
                          child:const Icon(
                           MaterialCommunityIcons.source_commit_start_next_local,
                            color: white,
                            size: 30 ),
                        ),
                      ),
  
  
               const   Expanded(child: SizedBox()),
               //const SizedBox(height: 10.0),
                      Text(title,style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, )),
                   const   SizedBox(height: 3.5),
               isActive ?   Text(desc,style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold,color: customFadedColor )) : MirrorAnimation<double>(builder: (context, child,value) => Transform.scale(scale: 1.3 * value,child: Text(desc,style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold,color: customFadedColor ))),curve: Curves.easeInOut,duration:const Duration(milliseconds: 700), tween: Tween(begin: 0.8,end: 1.0) ),
  
                            ]
                          ),
                        ),
                      ),
                   
                  const SizedBox(width: 10)
                    ],
                  ),
  );



}


Widget raisedCircularMaterialButton(){
  return   Stack(
            children: [
            
                  
                        PlayAnimation<double>(
                         tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, child,value) {
                            return true ? 
                              Column(
                                children: [
                                  Material(
                                    elevation: 10.0,
                                    
                                  ),
                                  Container(
                                              width: 51,
                                              height: 51,
                                              padding: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [Colors.black.withOpacity(0.7),Colors.black ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    stops: [0.3, 1]),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(

                                                MaterialCommunityIcons.source_commit_start_next_local,
                                             color: white,
                                             size: 30

                                              ),
                                            ),
                                ],
                              )
                             :
                            //  Material(
                            //   elevation:  0.5 * value,
                            //   color: logoBackgroundColor,
                            //   shape:const CircleBorder(),
                            //   child: 
                              Container(
                                margin: EdgeInsets.only(left: 100.0,top: 300.0),
                                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                                decoration: BoxDecoration(
                                 // color:true ? logoMainColor : logoBackgroundColor,
                                  gradient: LinearGradient(
                                    colors: [black. withOpacity(0.8),black],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops:const [0.1,.9]

                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 0.75, color:false ? logoBackgroundColor :  Colors.grey.withOpacity(0.4)) ,
                                ),
                                child: InkWell(
                                          onTap: (){
                                            setState(() {
                                                 _showSortWidget = !_showSortWidget;
                                            });
                                           
                                          },
                                          child: Container(
                                            child: Icon(AntDesign.filter,size: 18,color: logoMainColor)
                                          ),
                                        ),
                                 
                                
                              )
                           
                            //)
                            ;
                          }
                        ),


            
               
                
            ],
          );
       
       

}

Widget sortItemWidget(title, subtitle,iconData,onTap,{ bool isSelected = false, required onChanged(sortOrder), bool isDesc = false}){


  return   InkWell(
    onTap: onTap,
    child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              width: _w * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:isSelected ? white  : logoBackgroundColor,
              ),
              margin: EdgeInsets.only(bottom: 10.0),
              child: PlayAnimation<double>(
              tween: Tween(begin: 0.0 , end: 1.0),
                builder: (context, snapshot,value) {
                  return Material(
                     borderRadius: BorderRadius.circular(10),
                    color:isSelected ? white  : logoBackgroundColor,
                    elevation: isSelected ? 2.0 * value:  0.0 * value,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                      child: Row(
                        children: [
                        Container(
                          child:Icon(iconData,color: logoMainColor,size: 17.0)
                          ),
                          
                            Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(title,style: TextStyle(color: logoMainColor,fontSize: 12.5,fontWeight: FontWeight.bold)),
                        SizedBox(height: 3.5),
                          Text(subtitle,style: TextStyle(color:fadedHeadingsColor,fontSize: 10.5,fontWeight: FontWeight.bold)),
                        ],
                        ),
                        ),
                        Expanded(child: SizedBox()),
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 700),
                            curve: Curves.easeInOut,
                            opacity: isSelected ? 1.0 : 0.0,
                            child: Container(
                              margin: EdgeInsets.only(right: 10.0),
                              child: IconToggle(unselectedIcon:Entypo.chevron_thin_up,unselectedColor:  logoMainColor ,selectedIcon: Entypo.chevron_thin_down,selectedColor: logoMainColor,onChanged:onChanged,selected: isDesc,duration:Duration(milliseconds: 700),size: 17.5),
                            ),
                          ),
                      ],),
                    ),
                  );
                }
              ),
            ),
  );
                        
 
                                
}



}



enum AnimPros{elevation,scale}

  //latLng = const LatLng( 5.7070694, -0.2018629);

        MyUser response = MyUser.fromMap({
   "geocoded_waypoints" : [
      {
         "geocoder_status" : "OK",
         "place_id" : "ChIJX1NiQzmd3w8R6D88LlRJz_4",
         "types" : [
            "establishment",
            "food",
            "grocery_or_supermarket",
            "point_of_interest",
            "store"
         ]
      },
      {
         "geocoder_status" : "OK",
         "place_id" : "ChIJOxUMLXid3w8R82Zhu0a55RI",
         "types" : [ "establishment", "gym", "health", "point_of_interest" ]
      }
   ],
   "routes" : [
      {
         "bounds" : {
            "northeast" : {
               "lat" : 5.709982500000001,
               "lng" : -0.1998838
            },
            "southwest" : {
               "lat" : 5.7070694,
               "lng" : -0.2018629
            }
         },
         "copyrights" : "Map data ©2021",
         "legs" : [
            {
               "distance" : {
                  "text" : "0.7 km",
                  "value" : 700
               },
               "duration" : {
                  "text" : "4 mins",
                  "value" : 224
               },
               "end_address" : "Pantang Abokobi Rd, Adenta Municipality, Ghana",
               "end_location" : {
                  "lat" : 5.7090697,
                  "lng" : -0.2018629
               },
               "start_address" : "Pan city, Pantang Abokobi Rd, Ghana",
               "start_location" : {
                  "lat" : 5.709982500000001,
                  "lng" : -0.2005515
               },
               "steps" : [
                  {
                     "distance" : {
                        "text" : "0.2 km",
                        "value" : 204
                     },
                     "duration" : {
                        "text" : "1 min",
                        "value" : 81
                     },
                     "end_location" : {
                        "lat" : 5.7082837,
                        "lng" : -0.1998838
                     },
                     "html_instructions" : "Head \u003cb\u003esouth-east\u003c/b\u003e",
                     "polyline" : {
                        "points" : "kfza@ldf@`A]fA[`AWRGPIPKHCRGp@I"
                     },
                     "start_location" : {
                        "lat" : 5.709982500000001,
                        "lng" : -0.2005515
                     },
                     "travel_mode" : "DRIVING"
                  },
                  {
                     "distance" : {
                        "text" : "0.2 km",
                        "value" : 184
                     },
                     "duration" : {
                        "text" : "1 min",
                        "value" : 42
                     },
                     "end_location" : {
                        "lat" : 5.707180999999999,
                        "lng" : -0.2003024
                     },
                     "html_instructions" : "Turn \u003cb\u003eright\u003c/b\u003e",
                     "maneuver" : "turn-right",
                     "polyline" : {
                        "points" : "w{ya@f`f@j@jClCo@@?^G"
                     },
                     "start_location" : {
                        "lat" : 5.7082837,
                        "lng" : -0.1998838
                     },
                     "travel_mode" : "DRIVING"
                  },
                  {
                     "distance" : {
                        "text" : "0.1 km",
                        "value" : 111
                     },
                     "duration" : {
                        "text" : "1 min",
                        "value" : 35
                     },
                     "end_location" : {
                        "lat" : 5.7073957,
                        "lng" : -0.2011812
                     },
                     "html_instructions" : "Turn \u003cb\u003eright\u003c/b\u003e",
                     "maneuver" : "turn-right",
                     "polyline" : {
                        "points" : "{tya@zbf@Tx@?H?JIVc@n@SV"
                     },
                     "start_location" : {
                        "lat" : 5.707180999999999,
                        "lng" : -0.2003024
                     },
                     "travel_mode" : "DRIVING"
                  },
                  {
                     "distance" : {
                        "text" : "0.2 km",
                        "value" : 201
                     },
                     "duration" : {
                        "text" : "1 min",
                        "value" : 66
                     },
                     "end_location" : {
                        "lat" : 5.7090697,
                        "lng" : -0.2018629
                     },
                     "html_instructions" : "Turn \u003cb\u003eright\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003eDestination will be on the right\u003c/div\u003e",
                     "maneuver" : "turn-right",
                     "polyline" : {
                        "points" : "gvya@jhf@m@LuA`@y@Tm@NaBp@"
                     },
                     "start_location" : {
                        "lat" : 5.7073957,
                        "lng" : -0.2011812
                     },
                     "travel_mode" : "DRIVING"
                  }
               ],
               "traffic_speed_entry" : [],
               "via_waypoint" : []
            }
         ],
         "overview_polyline" : {
            "points" : "kfza@ldf@hCy@tA_@`Aa@p@Ij@jCnCo@^GTx@?H?JIVw@fAcCn@gBd@aBp@"
         },
         "summary" : "",
         "warnings" : [],
         "waypoint_order" : []
      }
   ],
   "status" : "OK"
});


       
 