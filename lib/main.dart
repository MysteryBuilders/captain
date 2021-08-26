import 'dart:convert';
import 'package:captain/provider/service_locator.dart';
import 'package:http/http.dart' as http;
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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:captain/helpers/AppLocalizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/constants.dart';
import 'localization/localization_methods.dart';
import 'localization/set_localization.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async{
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String mToken = sharedPreferences.getString(kSaveFireBaseToken)??"";
  if(mToken == ""){
    String toke = await FirebaseMessaging.instance.getToken();
    print('token --> ${toke}');
    sharedPreferences.setString(kSaveFireBaseToken, toke);
  }


  print('Token Saved!');
  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

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

  String _token;


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
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      }
    });
    // getToken().then((value) {
    //
    // });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });



  }
  Stream<String> _tokenStream;

  void setToken(String token) {
    print('FCM Token: $token');
    setState(() {
      _token = token;
    });
  }
  Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  int _messageCount = 0;

  /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
  String constructFCMPayload(String token) {
    _messageCount++;
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': _messageCount.toString(),
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#$_messageCount) was created via FCM!',
      },
    });
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
                return  ScreenUtilInit(builder: (){
                  return MultiProvider(
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
                  );
                });
            }
          });




    }
  }
}