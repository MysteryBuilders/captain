import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
class AboutUsScreen extends StatefulWidget {
  static String id = 'aboutUsScreen';
  final String aboutUs;
  const AboutUsScreen({Key key, @required this.aboutUs}): super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(

              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [const Color(0xFFF2C046),const Color(0xFFE4AF3D),const Color(0xFFC78B2B)],begin: Alignment.topRight,
                  end: Alignment.bottomLeft,),
              ),
              child: Stack(
                children: [
                  Positioned.directional(
                    textDirection :  Directionality.of(context),
                    end: 6.w,
                    top: 10.h,
                    bottom: 0,
                    child: InkWell(
                      onTap: (){Navigator.pop(context);},
                      child: Padding(padding: EdgeInsets.all(10.w),
                          child: Icon(Icons.arrow_back_ios_outlined,size: 17.w,color: Colors.white,)
                      ),
                    ),


                  ),
                  Center(
                    child:
                    Padding(
                      padding:  EdgeInsets.only(top: 10.h),
                      child: Text(
                        'من نحن',
                        style: GoogleFonts.cairo(
                          fontSize: screenUtil.setSp(16),
                          color: Colors.white,
                          letterSpacing: -0.36,
                          fontWeight: FontWeight.w700,
                        ),

                      ),
                    ),
                  )
                ],
              ),),
          ),
          Expanded(flex: 9,
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [const Color(0xFFF2C046),const Color(0xFFE4AF3D),const Color(0xFFC78B2B)],begin: Alignment.topRight,
                      end: Alignment.bottomLeft,),
                  ),

                child: Column(
                  children: [
                    Expanded(
                      flex:3,
                      child: Container(
                        color: Color(0xFFFFFFFF),

                        width: width,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/about_us_image.png',height: 100.h,width: 100.w,),
                              Padding(

                                padding:  EdgeInsets.all( 10.0.h),
                                child: Text('Captain 23',style:
                                  TextStyle(
                                    color: Color(0xFF002087),
                                    fontSize: screenUtil.setSp(20),
                                    fontWeight: FontWeight.bold
                                  ),),
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: 6,
                        child: Container(
                          margin: EdgeInsets.all(20.h),
                          child: ListView(
                            children: [
                              HtmlWidget(



                                widget.aboutUs,
                                textStyle: TextStyle(
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenUtil.setSp(15)

                                ),
                              ),
                            ],
                          ),

                    ))

                  ],

                ) ,
              ))
        ],
      ),
    );
  }
}
