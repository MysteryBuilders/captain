

import 'dart:async';

import 'package:captain/api/api_client.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/login_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}
String mToken="";
String mIsLog ;
bool isLoggedIn = false;
Login_model login_model;
class _SplashState extends State<Splash> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _firebaseMessaging =FirebaseMessaging.instance;

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     // _showItemDialog(message);
    //   },
    //   // onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     // _navigateToItemDetail(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     // _navigateToItemDetail(message);
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    // _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
    //
    //
    //
    getFireBaseToken().then((value){
      mToken = value[kSaveFireBaseToken];
      isLoggedIn = value[kKeepMeLoggedIn];
      print(isLoggedIn);

      if(mToken == null || mToken == ""){
        _firebaseMessaging.getToken().then((value) {
          mToken = value;
          print(value);




        }
        ).whenComplete((){
          saveFireBaseToken(mToken).then((value){
            setState(() {

              if(isLoggedIn){
                mIsLog = "1";
                refreshToken().then((value) {
                  saveUser(value).then((value){
                    if(value){
                      Navigator.of(context).pushReplacementNamed(Home.id);
                    }

                  });

                });

              }else{
                mIsLog = "0";
              }

            });

          });
        });
      }else{
        setState(() {

          if(isLoggedIn){
            mIsLog = "1";
         refreshToken().then((value) {
           login_model = value;
           saveUser(value).then((value){

             if(value){
               Navigator.of(context).pushReplacementNamed(Home.id);
             }

           });

         });

          }else{
            mIsLog = "0";
          }

        });
      }
    });



  }
  Future<bool> saveUser(Login_model login_model)async{
    SharedPref sharedPref = SharedPref();
    await sharedPref.save(kUser, login_model);
    return true;
  }
  Future<bool> saveFireBaseToken(String mToken) async{
  SharedPref sharedPref = SharedPref();
  await sharedPref.saveString(kSaveFireBaseToken, mToken);
  return true;


  }
  Future<Map> getFireBaseToken() async{
  SharedPref sharedPref = SharedPref();
  String mToken = await sharedPref.readString(kSaveFireBaseToken);
  bool isLogin = await sharedPref.readBool(kKeepMeLoggedIn);
  Map map = Map();
  map[kKeepMeLoggedIn]= isLogin;
  map[kSaveFireBaseToken]= mToken;
  return map;
  }
  Future<bool> isLogIn()async{
    SharedPref sharedPref = SharedPref();
    bool isLogin = await sharedPref.readString(kKeepMeLoggedIn);
    return isLogin;
  }
ScreenUtil screenUtil = ScreenUtil();
  @override

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF002087),




      body:
      Column(

        children: [
          Expanded(flex:1,child: Container()),
          Expanded(flex: 3,
              child:Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('images/logo.png',height: 120.h,width: 116.h,),

                Text(
                        'كن لاعباً بصفات القائد',
                        style: GoogleFonts.cairo(
                          fontSize: 20.0,
                          color: Colors.white,
                          letterSpacing: -0.4,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    SizedBox(height: 10.h,),

                  ],
                ),
              )
          ),
          Expanded(flex: 6,
              child: Stack(
                children: [
                  Image.asset('images/lite.png'),
                  Positioned.directional(
                    textDirection:  Directionality.of(context),
                    start: 0,
                    end: 0,
                    bottom: 0,
                    child:Image.asset('images/Luncherpsd.png',fit: BoxFit.scaleDown,)
                  )


                ],
              )),
          Expanded( flex:2,
              child:
              mIsLog == null?Container():
              mIsLog == "0"?
              Container(
                height: 90.h,
                child:  Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child:  Container(
                              padding: EdgeInsets.all(10.h),

                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 1,color: Colors.grey)
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text(
                                  'تسجيل الدخول',
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.0,
                                    color: const Color(0xFF002087),
                                    letterSpacing: -0.3,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),

                          Expanded(

                            flex: 1,
                            child:  Container(
                              padding: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 1,color: Colors.grey)
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text(
                                  'تسجيل العضوية',
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.0,
                                    color: const Color(0xFF002087),
                                    letterSpacing: -0.3,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {

                          Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.h),

                          color: const Color(0xFF002087),
                          child:Text(
                            'تسجيل العضوية لاحقا',
                            style: GoogleFonts.cairo(
                              fontSize: 15.0,
                              color: Colors.white,
                              letterSpacing: -0.3,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ) ,
                        ),
                      ),
                    ),
                  ],
                ),
              ): login_model == null?
              Container(
                height: 90,
                child: CircularProgressIndicator(),
                alignment: FractionalOffset.center,
              ): Container(
                height: 90,

              )


          )


          // ListView(
          //   padding: EdgeInsets.zero,
          //   physics: NeverScrollableScrollPhysics(),
          //   children: [
          //     SizedBox(height: 90,),
          //     Image.asset('images/logo.png',width: 116,height: 119,),
          //     SizedBox(height: 20,),
          //     Text(
          //       'كن لاعباً بصفات القائد',
          //       style: GoogleFonts.cairo(
          //         fontSize: 20.0,
          //         color: Colors.white,
          //         letterSpacing: -0.4,
          //         fontWeight: FontWeight.w600,
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //     SizedBox(height: 40,),
          //
          //     Container(
          //       child:
          //       Stack(
          //         alignment: Alignment.bottomCenter,
          //         children: [
          //           Column(
          //             //crossAxisAlignment: CrossAxisAlignment.center,
          //             verticalDirection: VerticalDirection.up,
          //             children: [
          //               SizedBox(height: 70,),
          //               Image.asset('images/lite.png'),
          //             ],
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             verticalDirection: VerticalDirection.up,
          //             children: [
          //               Container(
          //                 height: 70.h,
          //                   width: width,
          //                   child: Image.asset('images/Luncherpsd.png',fit: BoxFit.scaleDown,)),
          //
          //             ],
          //           )
          //         ],
          //       )
          //       ,
          //     ),
          //   ],
          // ),
        ],
      ),

    );
  }
  Future<Login_model> refreshToken() async{
    CaptinService captinService = CaptinService();
    Login_model login_model = await captinService.refreshToke();
    return login_model;
  }
}
