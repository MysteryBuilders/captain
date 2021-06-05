import 'package:captain/component/common/AppBar.dart';
import 'package:captain/controller/AcademyController.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/database.dart';
import 'package:captain/helpers/loader.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/academy_data.dart';

import 'package:captain/model/main_model.dart';
import 'package:captain/pages/orderdata.dart';
import 'package:captain/provider/AcademyProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
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
                      'اختر عدد الأطفال',
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
                  child: new Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
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
                                      "${mBaseImageUrl}${widget.mAcademy.images[index].img}",
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
                      );
                    },

                    itemCount:  widget.mAcademy.images.length,
                    itemWidth: MediaQuery
                        .of(context)
                        .size
                        .width * 93 / 100,
                  ),
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
                  Padding(
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
                          Text(
                            '4.5',
                            style: GoogleFonts.cairo(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 3,),
                          Icon(Icons.star,color: Colors.black,size: 12,)
                        ],
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
                  Column(
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
                        'غير مساهم',
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
                  Text(
                    'محافظة ${widget.mAcademy.city.name}، ${widget.mAcademy.address}',
                    style: GoogleFonts.cairo(
                      fontSize: 18.0,
                      color: Colors.black,
                      letterSpacing: -0.32,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
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
                  child:  Html(
                    // customTextAlign: (_) => TextAlign.right,
                    // defaultTextStyle: GoogleFonts.cairo(
                    //   fontSize: 13.0,
                    //   color: const Color(0xFF002087),
                    //   letterSpacing: -0.26,
                    //   fontWeight: FontWeight.w700,
                    // ),
                    data: '${widget.mAcademy.content}',
                  ),
                ),
              ),

            ],
          )

    );
  }
}
