

import 'package:captain/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParentCivilId extends StatelessWidget {
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

  ParentCivilId({Key key, @required this.hint,@required this.icon,@required this.onClick, this.mText,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController myController = TextEditingController()..text = mText;

    return Column(

      children: [

        SizedBox(
          height:40.h,
          width: width,

          child: TextFormField(




            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.number ,
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
        ),
      ],
    );

  }
  String validateName(String value) {

    if (!VerifyCivilId(value)) {
      return "";
    }

    return null;
  }
  bool VerifyCivilId(String civilId)
  {
    if (civilId.trim().length == 0){
      return false;
    }else {
      bool output = false;
      int outLongValue = int.parse(civilId);
      if (civilId.length == 12) {
        int c1 = int.parse(civilId.substring(0, 1));
        int c2 = int.parse(civilId.substring(1, 2));
        int c3 = int.parse(civilId.substring(2, 3));
        int c4 = int.parse(civilId.substring(3, 4));
        int c5 = int.parse(civilId.substring(4, 5));
        int c6 = int.parse(civilId.substring(5, 6));
        int c7 = int.parse(civilId.substring(6, 7));
        int c8 = int.parse(civilId.substring(7, 8));
        int c9 = int.parse(civilId.substring(8, 9));
        int c10 = int.parse(civilId.substring(9, 10));
        int c11 = int.parse(civilId.substring(10, 11));
        int total = 11 - (((c1 * 2) + (c2 * 1) + (c3 * 6) + (c4 * 3) + (c5 * 7) +
            (c6 * 9) + (c7 * 10) + (c8 * 5) + (c9 * 8) + (c10 * 4) + (c11 * 2)) % 11);
        int c12 = int.parse(civilId.substring(11, 12));
        if (c12 == total) {
          output = true;
        } else {
          output = false;
        }

      }

      return output;
    }
  }
}