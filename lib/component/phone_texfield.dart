

import 'package:captain/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final String mText;
  BuildContext context;

  String _errorMessage(String str){
    switch(str){
      case 'Full Name':

        return 'Full Name Is Empty!';

    }
  }

  PhoneTextField({Key key, @required this.hint,@required this.icon,@required this.onClick, this.mText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    this.context = context;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController myController = TextEditingController()..text = mText;

    return Container(





      child:

      Stack(


        children: [

          TextFormField(


            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.phone ,
            onSaved: onClick,
            textInputAction: TextInputAction.next,

            minLines: 1,
            maxLines: 1,


            validator: validateName,
            cursorColor: Color(0xFF000000),

            decoration:
            InputDecoration(

                contentPadding: EdgeInsets.all(14.w),
                isDense: true,

                hintText: hint,

                labelStyle: TextStyle(color: kLightGrayColor),
                filled: true,



                fillColor: Color(0xFFDBE4FF),
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
          Positioned.directional( textDirection :  Directionality.of(context)
              , child: Container(height:48.h ,width: 8.w,
                color: Color(0xFF002087),
              )),

          Container(
            height: 48.h,
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                width: 39.0.w,
                height: 22.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0.h),
                  color: const Color(0xFF002087),
                ),
                child:
                Center(
                  child: Text(
                    '+965',
                    style: GoogleFonts.cairo(
                      fontSize: screenUtil.setSp(13),
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }

  String validateName(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{8}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "???? ???????? ???? ?????? ????????????";
    }
    else if (!regExp.hasMatch(value)) {
      return "???? ???????? ???? ?????? ????????????";
    }
    return null;
  }

}