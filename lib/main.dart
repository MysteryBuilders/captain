import 'package:captain/helpers/AppLanguage.dart';
import 'package:captain/pages/Splash.dart';
import 'package:captain/pages/aboutus_screen.dart';
import 'package:captain/pages/academies_countries.dart';
import 'package:captain/pages/academies_screen.dart';
import 'package:captain/pages/academy.dart';
import 'package:captain/pages/academybycategory.dart';
import 'package:captain/pages/academydetail.dart';
import 'package:captain/pages/contactus_screen.dart';
import 'package:captain/pages/forgetpassword_screen.dart';
import 'package:captain/pages/home.dart';
import 'package:captain/pages/login.dart';
import 'package:captain/pages/notification_screen.dart';
import 'package:captain/pages/payment_screen.dart';
import 'package:captain/pages/photo_view.dart';
import 'package:captain/pages/player_details_screen.dart';
import 'package:captain/pages/players_screen.dart';
import 'package:captain/pages/profile.dart';
import 'package:captain/pages/register.dart';
import 'package:captain/pages/web_screen.dart';
import 'package:captain/pages/youtube_screen.dart';
import 'package:captain/provider/AcademyCatProvider.dart';
import 'package:captain/provider/AcademyProvider.dart';
import 'package:captain/provider/CoachProvider.dart';
import 'package:captain/provider/PlaygroundProvider.dart';
import 'package:captain/provider/model_hud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:provider/provider.dart';
import 'package:captain/helpers/AppLocalizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/constants.dart';
import 'localization/localization_methods.dart';
import 'localization/set_localization.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() {



    return _MyAppState();
  }

}


class _MyAppState extends State<MyApp> {
  String messageTitle = "Empty";
  String notificationAlert = "alert";


  Locale _local;
  void setLocale(Locale locale) {
    setState(() {
      _local = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {

        this._local = locale;
        print('LanguageCode = ${_local.languageCode}');
      });
    }).whenComplete((){
      setDefaultLang('ar');
    });
    super.didChangeDependencies();
  }
  void setDefaultLang(String code) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString(LANG_CODE, code);

  }

  String _messageText = "Waiting for message...";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    if (_local == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return FutureBuilder(
          future: Firebase.initializeApp(),

          builder: (context,snapshot){
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }else{
                return  ScreenUtilInit(

                  allowFontScaling: true,
                  builder:() =>

                      MultiProvider(
                        providers: [
                          ChangeNotifierProvider<ModelHud>(create: (context) => ModelHud()),

                        ],
                        child: MaterialApp(
                          theme: ThemeData(
                              fontFamily: 'Cairo',
                              accentColor: kSecondaryColor,
                              primaryColor: kSecondaryColor



                          ) ,




                          locale: _local,

                          supportedLocales: [
                            Locale('en', 'US'),
                            Locale('ar', 'KW')
                          ],
                          localizationsDelegates: [
                            SetLocalization.localizationsDelegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          localeResolutionCallback: (deviceLocal, supportedLocales) {
                            for (var local in supportedLocales) {
                              print(supportedLocales.first.countryCode);
                              if (local.languageCode == deviceLocal.languageCode &&
                                  local.countryCode == deviceLocal.countryCode) {
                                return deviceLocal;
                              }
                            }
                            print(supportedLocales.first.countryCode);
                            return supportedLocales.first;
                          }
                          ,
                          debugShowCheckedModeBanner: false,
                                      home: Splash(),
                    routes: {
                      '/splash':(context)=>Splash(),
                      Home.id:(context)=>Home(),
                      '/register':(context)=>Register(),
                      '/login':(context)=>Login(),
                      '/profile':(context)=>Profile(),
                      '/academy':(context)=>Academy(),
                      '/academybycategory':(context)=>AcademyByCategory(),
                      '/academydetail':(context)=>AcademyDetail(),
                      ForgetPasswordScreen.id:(context)=>ForgetPasswordScreen(),
                      ContactUs.id:(context)=>ContactUs(),
                      AboutUsScreen.id:(context)=>AboutUsScreen(),
                      AcademiesScreen.id:(context)=>AcademiesScreen(),
                      PlayerScreen.id:(context)=>PlayerScreen(),
                      AcademiesCountriesScreen.id:(context)=>AcademiesCountriesScreen(),
                      PlayerDetailsScreen.id:(context)=>PlayerDetailsScreen(),
                      ShowImageScreen.id:(context)=>ShowImageScreen(),
                      YouTubeScreen.id:(context)=>YouTubeScreen(),
                      WebSiteScreen.id:(context)=>WebSiteScreen(),
                      NotificationScreen.id:(context)=>NotificationScreen(),
                      PaymentScreen.id:(context)=>PaymentScreen(),
                    },


                        ),
                      )
              );
            }
          });




    }
  }
}