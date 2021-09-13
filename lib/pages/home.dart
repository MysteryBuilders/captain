import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain/api/api_client.dart';
import 'package:captain/component/AcademyComponent.dart';
import 'package:captain/component/CoachComponent.dart';
import 'package:captain/component/PlaygroundComponent.dart';
import 'package:captain/component/common/Drawerco.dart';
import 'package:captain/controller/AcademyController.dart';
import 'package:captain/controller/CoachController.dart';
import 'package:captain/controller/PlaygroundController.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/database.dart';
import 'package:captain/helpers/loader.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/login_model.dart';
import 'package:captain/model/main_model.dart';
import 'package:captain/pages/academies_screen.dart';
import 'package:captain/pages/academydetail.dart';
import 'package:captain/pages/players_screen.dart';
import 'package:captain/pages/webview_screen.dart';
import 'package:captain/provider/AcademyProvider.dart';
import 'package:captain/provider/CoachProvider.dart';
import 'package:captain/provider/PlaygroundProvider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:provider/provider.dart';

import 'notification_screen.dart';

class Home extends StatefulWidget {

  static String id = 'HomeScreen';
  @override
  _HomeState createState() => _HomeState();
}
bool isLoggedIn = false;
class _HomeState extends State<Home> {
MainModel mainModel = null;
CaptinService captinService = CaptinService();
String imageBaseUrl;
SharedPref sharedPref = SharedPref();
int _current = 0;


  void initState() {
    super.initState();
    getMainFile();

  }
  void getMainFile() async {
    SharedPref pref = SharedPref();


    bool isLogin  =  await pref.readBool(kKeepMeLoggedIn);
print(isLogin);
    String email ="";
    if(isLogin){
      var userJson = await pref.read(kUser);
      print('userJson is $userJson');
      Login_model   user =  Login_model.fromJson(userJson);
      email = user.payload.user.email;

       print(user.success);
    }
    captinService.mainModel(email).then((value){
      imageBaseUrl = value.payload.pathPrefix;


      sharedPref.saveString(KBaseImageUrl,imageBaseUrl);

      setState(() {
        print(value);
        mainModel = value;
        isLoggedIn = isLogin;


      });

    });





  }





  Widget Image_Carousel (List<Slides> slider) {
    return new Container(
      height: 180,
      child: new Swiper(
        autoplay: true,
        duration: 3000,

        itemBuilder: (BuildContext context, int index) {
          return
            GestureDetector(
              onTap: (){
                String url = slider[index].url.toString();
                if(url != "null") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          WebViewScreen(url: slider[index].url,
                              title: slider[index].content)));
                }

              },
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                        height: 175,
                        decoration: BoxDecoration(
                          color: const Color(0xfff2f2f2).withOpacity(0.5),

                          borderRadius: BorderRadius.circular(10),

                        ),
                        child:
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            '${imageBaseUrl}${slider[index].img}',
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 94 / 100,
                            fit: BoxFit.fill,
                          ),

                        )

                    ),
                  ),

                ]
          ),
            );
        },

        itemCount: slider.length,
        itemWidth: MediaQuery
            .of(context)
            .size
            .width * 93 / 100,
      ),
    );


  }
  ScreenUtil screenUtil = ScreenUtil();

  @override

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _drawerKey,
      drawer: Container(
        width: MediaQuery.of(context).size.width,
        child: mainModel == null ?
        Container():
        Drawerc(settings: mainModel.payload.settings,imageUrl: imageBaseUrl,aboutUs: mainModel.payload.settings.aboutUs,cities: mainModel.payload.cities,)

      ),
      appBar: AppBar(
        title: Text(
          'الرئيسية',
          style: GoogleFonts.cairo(
            fontSize: 18.0,
            color: Colors.white,
            letterSpacing: -0.36,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),

        centerTitle: true,
        leading:  InkWell(
          onTap: () => _drawerKey.currentState.openDrawer(),
          child:Row(
            children: [
              SizedBox(width: 10,),
              Container(
                  height:38,
                  width:38,
                  decoration: BoxDecoration(
                      color:  Colors.white,
                      shape: BoxShape.circle
                  ),
                  child:Center(
                    child: Icon(Icons.menu,color: Color(0xFFE4AF3D),size: 20,),
                  )
              ),
            ],
          )

        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, NotificationScreen.id);
            },
            child:  Container(
                height:38,
                width:38,
                decoration: BoxDecoration(
                    color:  Colors.white,
                    shape: BoxShape.circle
                ),
                child:Center(
                    child: Icon(Icons.notifications,color: Color(0xFFE4AF3D),size: 20,)
                )
            ),
          ),
          SizedBox(width: 10,),

        ],
      ),

      body:
      mainModel == null?
      Container(
        child: CircularProgressIndicator(),
        alignment: FractionalOffset.center,
      )


      :
      ListView(

        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 3 / 100),
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 14),
            child:  Image_Carousel(mainModel.payload.slides),
          ),

          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: 118.0,
                height: 28.0,
                margin: EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xFF002087),
                  ),
                ),
                child: Text(
                  'الأكاديميات المتاحة',
                  style: GoogleFonts.cairo(
                    fontSize: 14.0,
                    color: const Color(0xFF002087),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(child:
              SizedBox(width: 30,),

              ),
              InkWell(
                onTap: () {},
                child:
                SizedBox(
                  width: 65.0,
                  height: 26.0,
                  child: Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){

                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AcademiesScreen(cities: mainModel.payload.cities,)));

                        },
                        child: Container(
                          width: 65.0,
                          height: 25.0,
                          margin: EdgeInsets.only(left: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: const Color(0xFF002087),
                          ),
                          child:  Text(
                            'الكل',
                            style: GoogleFonts.cairo(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
          ListView.separated(
              scrollDirection: Axis.vertical,


              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemBuilder: (context,index){
                return

                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AcademyDetail(mAcademy: mainModel.payload.academies[index],)));

                    },
                    child: Container(

                    width: screenUtil.screenWidth,
                    child: Container(
                      height:220,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color:  const Color(0xFFE3E3E3).withOpacity(.90),
                            blurRadius: 15.0,
                          ),
                        ],
                      ),
                      child: new Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(6),
                                child:Container(
                                    height: 127,
                                    width: screenUtil.screenWidth,
                                    child:Image.network('${imageBaseUrl}${mainModel.payload.academies[index].img}',fit: BoxFit.cover,)
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(right: 9),
                                  child:Text(
                                    '${mainModel.payload.academies[index].name}',
                                    style: GoogleFonts.cairo(
                                      fontSize: 18.0,
                                      color: const Color(0xFF002087),
                                    ),
                                  )
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 9),
                                    child:
                                    Text(
                                      ' ${mainModel.payload.academies[index].priceN} د.ك',
                                      style: GoogleFonts.cairo(
                                        fontSize: 16.0,
                                        color: const Color(0xFF717171),
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Expanded(child:
                                  SizedBox(width: 30,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 9),
                                    child:Container(
                                      width: 50.0,
                                      height: 24.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1.0),
                                        color: const Color(0xFFF2C046),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '4.5',
                                            style: GoogleFonts.cairo(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Icon(Icons.star,color: Colors.black,size: 7,)
                                        ],
                                      ),
                                    ),

                                  )
                                ],
                              )

                            ],
                          )
                      ),
                    ),

                ),
                  );
              },
              separatorBuilder: (context,index){
                return Container(height: 10.h,
                  color: Color(0xFFFFFFFF),);
              }, itemCount: mainModel.payload.academies.length),


          // AcademyComponent(imageUrl: imageBaseUrl,academies: mainModel.payload.academies,),
          SizedBox(height: 10,),



          // Row(
          //   children: [
          //     Container(
          //       width: 118.0,
          //       height: 28.0,
          //       margin: EdgeInsets.only(right: 14),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         border: Border.all(
          //           width: 1.0,
          //           color: const Color(0xFF002087),
          //         ),
          //       ),
          //       child: Text(
          //         'ملفات اللاعبين و المدربين',
          //         style: GoogleFonts.cairo(
          //           fontSize: 14.0,
          //           color: const Color(0xFF002087),
          //         ),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //     Expanded(child:
          //     SizedBox(width: 30,),
          //
          //     ),
          //     InkWell(
          //       onTap: () {
          //         Navigator.pushNamed(context, PlayerScreen.id);
          //       },
          //       child:
          //       SizedBox(
          //         width: 65.0,
          //         height: 26.0,
          //         child: Stack(
          //           children: <Widget>[
          //             Container(
          //               width: 65.0,
          //               height: 25.0,
          //               margin: EdgeInsets.only(left: 14),
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(4.0),
          //                 color: const Color(0xFF002087),
          //               ),
          //               child:  Text(
          //                 'الكل',
          //                 style: GoogleFonts.cairo(
          //                   fontSize: 14.0,
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //                 textAlign: TextAlign.center,
          //               ),
          //             ),
          //
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // CoachComponent(imageUrl: imageBaseUrl, players: mainModel.payload.players,),

        ],
      )





    );
  }
}
