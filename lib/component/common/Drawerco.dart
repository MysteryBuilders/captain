import 'dart:io';
import 'dart:ui';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/database.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/login_model.dart';
import 'package:captain/model/main_model.dart';
import 'package:captain/model/academies_model.dart';
import 'package:captain/pages/aboutus_screen.dart';
import 'package:captain/pages/academies_screen.dart';
import 'package:captain/pages/contactus_screen.dart';
import 'package:captain/pages/players_screen.dart';
import 'package:captain/pages/profile.dart';
import 'package:captain/pages/web_screen.dart';
import 'package:captain/provider/model_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class Drawerc extends StatefulWidget {
  final  Settings  settings;
  final String imageUrl;
  final String aboutUs;
  final List<Cities> cities;
  const Drawerc({Key key, @required this.settings, @required this.imageUrl, @required this.aboutUs,@required this.cities}): super(key: key);

  @override
  _DrawercState createState() => _DrawercState();
}

class _DrawercState extends State<Drawerc> {
  ScreenUtil screenUtil = ScreenUtil();
  SharedPref sharedPref = SharedPref();
  Login_model login_model;
  final InAppReview _inAppReview = InAppReview.instance;
  String _appStoreId = '';
  String _microsoftStoreId = '';
  bool _isAvailable;
  var _n;
  var _apptoken;
  var _user='';
  var email='';
  var img=DataBase.urlstatename()+'/upload/no-image.png';
  bool isLogIn = false;

  // read() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.get('auth') ?? false;
  //
  //
  //   final apptoken = prefs.get('apptoken') ?? 0;
  //
  //   if(value){
  //     setState(() {
  //       _n = 1;
  //       _apptoken=apptoken;
  //       _user=prefs.get('username');
  //       email=prefs.get('email');
  //       img=prefs.get('img');
  //     });
  //   }
  //   else{
  //     setState(() {
  //       _n = 0;
  //       _apptoken=apptoken;
  //     });
  //   }
  // }

  String userName = "";
  String userEmail="";
  String userImage ="";

  @override
  initState(){
readProfile();


  }
  Future<void> _requestReview() async {
     if (await _inAppReview.isAvailable()) {
     Future.delayed(const Duration(seconds: 2), () {
       _inAppReview.requestReview();
     });
     }else{
       print('app Not available');
     }
  }
  void readProfile() async{
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inAppReview
          .isAvailable()
          .then(
            (bool isAvailable) => setState(
              () => _isAvailable = isAvailable && !Platform.isAndroid,
        ),
      )
          .catchError((_) => setState(() => _isAvailable = false));
    });
    isLogIn = await sharedPref.readBool(kKeepMeLoggedIn);
    if(isLogIn){

      var userJson = await sharedPref.read(kUser);
      userName = await sharedPref.readString(kUserName);
      userImage = await sharedPref.readString(KImage);
      print('userJson is $userJson');

      setState(() {
        login_model =  Login_model.fromJson(userJson);
        isLogIn = true;
        userEmail = login_model.payload.user.email;

        print('userName-->${userName}');
        print('userEmail-->${userEmail}');
        print('userImage-->${userImage}');
      });


    }else{
      setState(() {
        userName = "";
        userEmail = "";
        userImage ="";
        isLogIn = false;
      });
    }
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      Drawer(

        child: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent[700].withAlpha(150).withOpacity(.2),
            ),
        child:
        ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: BlurryContainer(
            bgColor: const Color(0xFF002087).withAlpha(5).withOpacity(.5),
              child:  ListView(
                padding: EdgeInsets.zero,
                    children: <Widget>[
                      Container(
                        child:isLogIn?
                        Column(
                          children: [
                            SizedBox(height: 5,),
                            Center(
                              child: Column(
                                children: [

                                  Container(
                                    width: width,
                                    height: 100.h,
                                    child:
                                    Center(
                                      child: CachedNetworkImage(
                                        imageUrl: widget.imageUrl+userImage,
                                        imageBuilder: (context, imageProvider) => Container(
                                          height: 84.h,
                                          width: 84.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Center(
                                              child: SizedBox(
                                                  height: 50.h,
                                                  width: 50.h,
                                                  child: new CircularProgressIndicator()),
                                            ),

                                        errorWidget: (context, url, error) => SizedBox(
                                            height: 84.h,
                                            width: 84.h,
                                            child: Image.asset('images/user.png',fit: BoxFit.scaleDown,)),

                                      ),
                                    ),
                                  )
                                  ,
                                  Text(
                                    '${userName}',
                                    style: GoogleFonts.cairo(
                                      fontSize: 16,
                                      color: Colors.white,
                                      letterSpacing: -0.32,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${userEmail}',
                                    style: GoogleFonts.cairo(
                                      fontSize: 16,
                                      color: Colors.white,
                                      letterSpacing: -0.32,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15,),
                          ],
                        ): Container(
                          height: 60.h,
                        ),
                      ),



                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AcademiesScreen(cities: widget.cities,)));

                        },
                        child:
                        SizedBox(
                          height: 40.0,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 50,),
                              Container(
                                  alignment: Alignment(0.24, 0.0),
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFFF2C046),
                                  ),
                                  child: Icon(FontAwesomeIcons.userEdit,color: Colors.white,size: 15,),
                                ),
                              SizedBox(width: 10,),
                              Text(
                                'الأكاديميات',
                                style: GoogleFonts.cairo(
                                  fontSize: 18.0,
                                  color: const Color(0xFFF2C046),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PlayerScreen.id);
                        },
                        child:
                        SizedBox(
                          height: 40.0,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 50,),
                              Container(
                                alignment: Alignment(0.24, 0.0),
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFF2C046),
                                ),
                                child: Icon(FontAwesomeIcons.userEdit,color: Colors.white,size: 15,),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'الملفات الشخصية للاعبين',
                                style: GoogleFonts.cairo(
                                  fontSize: 18.0,
                                  color: const Color(0xFFF2C046),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        child: isLogIn?

                        InkWell(

                          onTap: () {

                            if(login_model!= null){
                              profileActivity(context);

                            }else{
                              Navigator.pushNamed(context, '/login');
                            }

                          },
                          child:
                          SizedBox(
                            height: 40.0,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 50,),
                                Container(
                                  alignment: Alignment(0.24, 0.0),
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFFF2C046),
                                  ),
                                  child: Icon(FontAwesomeIcons.userEdit,color: Colors.white,size: 15,),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  'الملف الشخصي',
                                  style: GoogleFonts.cairo(
                                    fontSize: 18.0,
                                    color: const Color(0xFFF2C046),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ):
                            Container()
                      ),

                      InkWell(
                        onTap: () {

                          Navigator.of(context).pushNamed(ContactUs.id);
                        },
                        child:
                        SizedBox(
                          height: 40.0,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 50,),
                              Container(

                                alignment: Alignment.center,
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFF2C046),
                                ),
                                child: Icon(FontAwesomeIcons.commentDots,color: Colors.white,size: 15,),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'اتصل بنا',
                                style: GoogleFonts.cairo(
                                  fontSize: 18.0,
                                  color: const Color(0xFFF2C046),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('aboutus');
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutUsScreen(aboutUs: widget.aboutUs,)));


                        },
                        child:
                        SizedBox(
                          height: 40.0,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 50,),
                              Container(
                                alignment: Alignment.center,
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFF2C046),
                                ),
                                child: Icon(FontAwesomeIcons.question,color: Colors.white,size: 15,),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'من نحن',
                                style: GoogleFonts.cairo(
                                  fontSize: 18.0,
                                  color: const Color(0xFFF2C046),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          share();
                        },
                        child:
                        SizedBox(
                          height: 40.0,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 50,),
                              Container(
                                alignment: Alignment.center,
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFF2C046),
                                ),
                                child: Icon(FontAwesomeIcons.shareAlt,color: Colors.white,size: 15,),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'شارك التطبيق',
                                style: GoogleFonts.cairo(
                                  fontSize: 18.0,
                                  color: const Color(0xFFF2C046),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {

                          _requestReview();
                        },
                        child:
                        SizedBox(
                          height: 40.0,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 50,),
                              Container(
                                alignment: Alignment.center,
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFF2C046),
                                ),
                                child: Icon(Icons.star,color: Colors.white,size: 15,),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'تقييم التطبيق',
                                style: GoogleFonts.cairo(
                                  fontSize: 18.0,
                                  color: const Color(0xFFF2C046),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap:(){
                          if(isLogIn){
                            logout();
                          }else{
                            Navigator.pushNamedAndRemoveUntil(context,'/splash' ,(route) => false);
                          }

                        },
                        child:
                        SizedBox(
                          height: 40.0,
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 50,),
                              Container(
                                alignment: Alignment.center,
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFF2C046),
                                ),
                                child: Icon(Icons.logout,color: Colors.white,size: 15,),
                              ),
                              SizedBox(width: 10,),
                              Text(isLogIn?
                                'تسجيل الخروج':'تسجيل الدخول',
                                style: GoogleFonts.cairo(
                                  fontSize: 18.0,
                                  color: const Color(0xFFF2C046),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                      Divider(
                        indent: 25,
                        endIndent: 25,
                        color:const Color(0xffffffff) ,
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebSiteScreen(url: widget.settings.facebook,title: 'تويتر',)));


                              },
                              child: Container(
                                alignment: Alignment(0.04, 0.01),
                                width: 37.0,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Image.asset('images/twitter.png'),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebSiteScreen(url: widget.settings.instagram,title: 'انستقرام',)));


                              },
                              child: Container(
                                alignment: Alignment(0.04, 0.01),
                                width: 37.0,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Image.asset('images/instagram.png'),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebSiteScreen(url: widget.settings.facebook,title: 'فيس بوك',)));


                              },
                              child: Container(
                                alignment: Alignment(0.04, 0.01),
                                width: 37.0,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Image.asset('images/facebook.png'),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 25,),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white,width: 2),
                            ),
                            child: Center(
                              child: Icon(Icons.close,size: 20,color: Colors.white,),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),

          ),
        )
        )
    );
  }

  _logouts() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    prefs.remove(key);
    prefs.remove('auth');
    Navigator.pushNamed(context, '/login');
  }
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }

  void logout() async{
    SharedPref sharedPref = SharedPref();
    await sharedPref.clear();

    Navigator.pushNamedAndRemoveUntil(context,'/splash' ,(route) => false);
  }
  void _launchURL(String _url) async{
    print(_url);
    bool canLaunchUrl ;
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);


    await canLaunch(_url) ? canLaunchUrl: !canLaunchUrl;
    if( canLaunchUrl){
      await launch(_url) ;
      modelHud.changeIsLoading(false);
    }else{

    } modelHud.changeIsLoading(false);

  }
  Future profileActivity(BuildContext context) async {

    Map results = await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
      return new Profile();
    }));

    if (results != null && results.containsKey(kUserName)) {

      setState(() {

        userName = results[kUserName];
        userImage = results[KImage];
        print('userName --> ${userName}');
        print('userImage --> ${userImage}');


      });




    }
  }

}
