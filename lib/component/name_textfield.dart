

import 'package:captain/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameTextField extends StatelessWidget {
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

   NameTextField({Key key, @required this.hint,@required this.icon,@required this.onClick, this.mText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController myController = TextEditingController()..text = mText;

    return Container(




      child:

      Stack(


        children: [

          Container(

            child: TextFormField(


                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text ,
                onSaved: onClick,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                minLines: 1,





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
          ),
          Positioned.directional( textDirection :  Directionality.of(context)
              , child: Container(height:48.h ,width:8.w,
                color: Color(0xFF002087),
              ))
        ],
      ),
    );

  }
  String validateName(String value) {

    if (value.length == 0) {
      return "???? ???????? ???? ??????????";
    }

    return null;
  }

}