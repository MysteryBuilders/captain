

import 'package:captain/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentPhoneNumberTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final String mText;
  final Size size;
  BuildContext context;

  String _errorMessage(String str){
    switch(str){
      case 'Full Name':

        return 'Full Name Is Empty!';

    }
  }

  ParentPhoneNumberTextField({Key key, @required this.hint,@required this.icon,@required this.onClick, this.mText,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    this.context = context;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController myController = TextEditingController()..text = mText;

    return Column(

      children: [

        SizedBox(
          height:40.h,
          width: width,

          child:
          Stack(
            children: [
              TextFormField(




                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.phone ,
                onSaved: onClick,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                minLines: 1,






                validator: validateName,
                cursorColor: Color(0xFF000000),

                decoration:
                InputDecoration(
                    errorStyle: TextStyle(height: 0),


                    isDense: true,




                    hintText: hint,
                    hintStyle: TextStyle(
                        color: Color(0xFF002087)
                    ),



                    labelStyle: TextStyle( color: Color(0xFFF2C046)),
                    filled: true,
                    contentPadding: EdgeInsets.all(10.h),


                    fillColor: Color(0xFFFFFFFF),
                    enabledBorder:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.h),
                        borderSide: BorderSide(

                            color: Color(0x00000000)
                        )
                    ),
                    focusedBorder:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.h),
                        borderSide: BorderSide(
                            color: Color(0x00000000)
                        )
                    )
                    // OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(20),
                    //     borderSide: BorderSide(
                    //         color: Colors.white
                    //     )
                    // )
                    ,
                    border:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.h),
                        borderSide: BorderSide(
                            color: Color(0xFFFF0000)
                        )
                    )


                  // OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(20),
                  //     borderSide: BorderSide(
                  //         color: Colors.red
                  //     )
                ),


              ),
              Container(

                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    width: 39.0.w,
                    height: 22.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0.h),
                      color: const Color(0xFFE3E3E3),
                    ),
                    child:
                    Center(
                      child: Text(
                        '+965',
                        style: GoogleFonts.cairo(
                          fontSize: screenUtil.setSp(13,allowFontScalingSelf: true),
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

  }
  String validateName(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{8}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "";
    }
    else if (!regExp.hasMatch(value)) {
      return "";
    }
    return null;
  }

}