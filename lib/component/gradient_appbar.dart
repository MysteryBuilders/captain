import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class GradientAppBar extends StatelessWidget {
  const GradientAppBar({
    Key key,
    @required this.screenUtil,
    @required this.title
  }) : super(key: key);

  final ScreenUtil screenUtil;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
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
                title,
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
      ),);
  }
}