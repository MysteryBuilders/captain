import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain/component/common/AppBar.dart';
import 'package:captain/controller/AcademyController.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/database.dart';
import 'package:captain/helpers/loader.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/academy_data.dart';

import 'package:captain/model/main_model.dart';
import 'package:captain/pages/orderdata.dart';
import 'package:captain/pages/photo_screen.dart';
import 'package:captain/pages/webview_screen.dart';
import 'package:captain/provider/AcademyProvider.dart';
import 'package:captain/provider/call_services.dart';
import 'package:captain/provider/service_locator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AcademyDetail extends StatefulWidget {
  Data mAcademy;
  AcademyDetail({Key key,@required this.mAcademy}): super(key: key);
  @override
  _AcademyDetailState createState() => _AcademyDetailState();
}

class _AcademyDetailState extends State<AcademyDetail> {



int count = 1;
SharedPref sharedPref = SharedPref();
String mBaseImageUrl ="";
bool isloggedIn = false;
int _current =0;
final CarouselController _controller = CarouselController();
final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

@override
void initState() {
  // TODO: implement initState
  super.initState();
  getDefaultPathUrl().then((value){
    setState(() {
      mBaseImageUrl = value[KBaseImageUrl];
      isloggedIn = value[kKeepMeLoggedIn];
    });

  });



}
Future<Map> getDefaultPathUrl() async{
  String imageUrl = await sharedPref.readString(KBaseImageUrl);
  bool isLoggedIn = await sharedPref.readBool(kKeepMeLoggedIn);
  Map map = Map();
  map[KBaseImageUrl] = imageUrl;
  map[kKeepMeLoggedIn] = isLoggedIn;
return  map;
}
ScreenUtil screenUtil = ScreenUtil();
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: PreferredSize(
            child:  app_bar(title: 'تفاصيل الأكاديمية',),
            preferredSize: Size.fromHeight(55)),
        bottomNavigationBar: Container(
          height: 121.0,
          color: const Color(0xFF002087),
          child:

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 252,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'اختر عدد اللاعبين',
                      style: GoogleFonts.cairo(
                        fontSize: 17.0,
                        color: Colors.white,
                        letterSpacing: -0.34,
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    InkWell(
                      onTap: (){
                        if(count>1){
                          count--;
                          setState(() {

                          });
                        }
                      },
                      child:  Container(
                          alignment: Alignment.center,
                          width: 26.0,
                          height: 26.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.remove,color: const Color(0xFF002087),size: 18,)
                      ),
                    ),

                    Text(
                      '${count}',
                      style: GoogleFonts.cairo(
                        fontSize: 20.0,
                        color: Colors.white,
                        letterSpacing: -0.4,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          count++;
                        });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 26.0,
                          height: 26.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.add,color: const Color(0xFF002087),size: 18,)
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 12,),
              InkWell(
                onTap: (){
                  if(isloggedIn){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderData(mAcademy: widget.mAcademy,count: count,)));
                  }else{
                    Navigator.pushNamedAndRemoveUntil(context,'/splash' ,(route) => false);
                  }

                },
                child:
                Container(
                  width: 138.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color(0xFFF2C046),
                  ),
                  child: Center(
                    child: Text(
                      'حجز الخدمة',
                      style: GoogleFonts.cairo(
                        fontSize: 14.0,
                        color: const Color(0xFF002087),
                        letterSpacing: -0.28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ),
              )


            ],
          ),
        ),

        body:mBaseImageUrl == null?  Container(
          child: CircularProgressIndicator(),
          alignment: FractionalOffset.center,
        )
         : ListView(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 3 / 100),
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 14),
                child: Container(
                  height: 180,
                  child:   CarouselSlider(

                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 10),



                        height: double.infinity,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        disableCenter: true,
                        pauseAutoPlayOnTouch: true
                        ,




                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }
                    ),
                    items: widget.mAcademy.images.map((item) =>
                        Stack(

                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                  return new PhotoScreen(imageProvider: NetworkImage(
                                    '${mBaseImageUrl}${item.img}',
                                  ),);
                                }));

                              },


                              child:
                              Column(
                                children: [

                                  Expanded(
                                    flex:4,
                                    child: Container(
                                      width: width,

                                      child:
                                      CachedNetworkImage(
                                        width: width,

                                        fit: BoxFit.fill,
                                        imageUrl:'${mBaseImageUrl}${item.img}',
                                        imageBuilder: (context, imageProvider) => Container(
                                            width: width,


                                            decoration: BoxDecoration(



                                              image: DecorationImage(


                                                  fit: BoxFit.fill,
                                                  image: imageProvider),
                                            )
                                        ),
                                        placeholder: (context, url) =>
                                            Column(
                                              children: [
                                                Expanded(
                                                  flex: 9,
                                                  child: Container(
                                                    height: height,
                                                    width: width,


                                                    alignment: FractionalOffset.center,
                                                    child: SizedBox(
                                                        height: 50.h,
                                                        width: 50.h,
                                                        child: new CircularProgressIndicator()),
                                                  ),
                                                ),
                                              ],
                                            ),


                                        errorWidget: (context, url, error) => Container(
                                            height: height,
                                            width: width,
                                            alignment: FractionalOffset.center,
                                            child: Icon(Icons.image_not_supported)),

                                      ),
                                      // Image.network(
                                      //
                                      //
                                      // '${kBaseUrl}${mAdsPhoto}${item.photo}'  , fit: BoxFit.fitWidth,
                                      //   height: 600.h,),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ] ,
                        )).toList(),

                  ),

                  // new Swiper(
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return
                  //       Stack(
                  //         children: <Widget>[
                  //           Center(
                  //             child: Container(
                  //                 height: 175,
                  //                 decoration: BoxDecoration(
                  //                   color: const Color(0xfff2f2f2).withOpacity(0.5),
                  //
                  //                   borderRadius: BorderRadius.circular(10),
                  //
                  //                 ),
                  //                 child:
                  //                 ClipRRect(
                  //                   borderRadius: BorderRadius.circular(8.0),
                  //                   child: Image.network(
                  //                     "${mBaseImageUrl}${widget.mAcademy.images[index].img}",
                  //                     width: MediaQuery
                  //                         .of(context)
                  //                         .size
                  //                         .width * 94 / 100,
                  //                     fit: BoxFit.fill,
                  //                   ),
                  //
                  //                 )
                  //
                  //             ),
                  //           ),
                  //
                  //         ]
                  //     );
                  //   },
                  //
                  //   itemCount:  widget.mAcademy.images.length,
                  //   itemWidth: MediaQuery
                  //       .of(context)
                  //       .size
                  //       .width * 93 / 100,
                  // ),
                ),
              ),

              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Text(
                    '${widget.mAcademy.name}',
                    style: GoogleFonts.cairo(
                      fontSize: 20.0,
                      color: const Color(0xFF002087),
                      letterSpacing: -0.4,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: (){
                      _service.call(widget.mAcademy.phone.toString());
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child:Container(
                        width: 59.0,
                        height: 33.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.0),
                          color: const Color(0xFFF2C046),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Icon(Icons.phone,
                             color: Color(0xFF000000),
    ),

                            SizedBox(width: 3,),
                           
                          ],
                        ),
                      ),

                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Text(
                    'رسوم الإشتراك',
                    style: GoogleFonts.cairo(
                      fontSize: 16.0,
                      color: Colors.black,
                      letterSpacing: -0.32,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 15,),
                  Opacity(
                    opacity: 0,
                    child: Column(
                      children: [
                        Text(
                          '${widget.mAcademy.price}',
                          style: GoogleFonts.cairo(
                            fontSize: 24.0,
                            color: const Color(0xFF717171),
                            letterSpacing: -0.48,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'مساهم',
                          style: GoogleFonts.cairo(
                            fontSize: 14.0,
                            color: const Color(0xFF717171),
                            letterSpacing: -0.48,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '${widget.mAcademy.priceN}',
                        style: GoogleFonts.cairo(
                          fontSize: 24.0,
                          color: const Color(0xFF717171),
                          letterSpacing: -0.48,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'رسوم الإشتراك',
                        style: GoogleFonts.cairo(
                          fontSize: 14.0,
                          color: const Color(0xFF717171),
                          letterSpacing: -0.48,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                ],
              ),
//               Row(
//                 children: <Widget>[
//                   SizedBox(width: 15,),
//                   widget.mAcademy.gender !='ذكر' ?
//                   Container(
//                     alignment: Alignment(-0.04, -1.0),
//                     width: 101.0,
//                     height: 33.0,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(18.0),
//                       color: const Color(0xFFDBE4FF),
//                       border: Border.all(
//                         width: 1.0,
//                         color: const Color(0xFF002087),
//                       ),
//                     ),
//                     child:
//                     SizedBox(
//                       width: 47.11,
//                       height: 30.0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Align(
//                               alignment: Alignment(0.0, 0.2),
//                               child: Image.asset('images/woman.png')
//                           ),
//                           Text(
//                             'إناث',
//                             style: GoogleFonts.cairo(
//                               fontSize: 16.0,
//                               color: const Color(0xFF002087),
//                               letterSpacing: -0.32,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ):SizedBox(),
//                   SizedBox(width: 15,),
//                   widget.mAcademy.gender !='أنثى' ?
//                   Container(
//                     alignment: Alignment(-0.04, -1.0),
//                     width: 101.0,
//                     height: 33.0,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(18.0),
//                       color: const Color(0xFFDBE4FF),
//                       border: Border.all(
//                         width: 1.0,
//                         color: const Color(0xFF002087),
//                       ),
//                     ),
//                     child:
// // Group: Group 258
//
//                     SizedBox(
//                       width: 53.21,
//                       height: 30.0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Align(
//                               alignment: Alignment(0.0, 0.2),
//                               child: Image.asset('images/man.png')
//                           ),
//                           Text(
//                             'ذكور',
//                             style: GoogleFonts.cairo(
//                               fontSize: 16.0,
//                               color: const Color(0xFF002087),
//                               letterSpacing: -0.32,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ):SizedBox(),
//                 ],
//               ),
//               SizedBox(height: 12,),
              Row(
                children: [
                  SizedBox(width: 12,),
                  Icon(Icons.location_on,color: Colors.black,size: 18,),
                  SizedBox(width: 10,),

                  GestureDetector(
                    onTap: (){
                      launchURL(widget.mAcademy.lat.toString(),widget.mAcademy.lng.toString());

                    },
                    child: Text(
                      'منطقة ${widget.mAcademy.city.name}، ${widget.mAcademy.address}',
                      style: GoogleFonts.cairo(
                        fontSize: 18.0,
                        color: Colors.black,
                        letterSpacing: -0.32,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(height: 12,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 12),
                child:  Container(
                  height: 69.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBE4FF),
                    border: Border.all(
                      width: 0.7,
                      color: const Color(0xFF002087),
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 139.0,
                          height: 28.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(8.0),
                            ),
                            color: const Color(0xFF002087),
                          ),
                          child: Text(
                            ' أوقات العمل',
                            style: GoogleFonts.cairo(
                              fontSize: 14.0,
                              color: Colors.white,
                              letterSpacing: -0.28,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 7,),
                      Center(
                        child: Text(
                          '${widget.mAcademy.timeWork}',
                          style: GoogleFonts.cairo(
                            fontSize: 13.0,
                            color: const Color(0xFF002087),
                            letterSpacing: -0.26,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Padding(padding: EdgeInsets.only(right: 12),
                  child: Text(
                    'نبذة عن الأكاديمية',
                    style: GoogleFonts.cairo(
                      fontSize: 16.0,
                      color: Colors.black,
                      letterSpacing: -0.32,
                      fontWeight: FontWeight.w700,
                    ),
                  )
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                child:  Container(
                  child:
                  HtmlWidget(


                    "${widget.mAcademy.content}",
                    textStyle: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontSize: screenUtil.setSp(
                            12)

                    ),
                  ),


                ),
              ),

            ],
          )

    );
  }
launchURL(String lat,String lng) async {



   final String googleMapslocationUrl = "https://www.google.com/maps/search/?api=1&query=${lat},${lng}";



  final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

  if (await canLaunch(encodedURl)) {
    await launch(encodedURl);
  } else {
    print('Could not launch $encodedURl');
    throw 'Could not launch $encodedURl';
  }
}

}
