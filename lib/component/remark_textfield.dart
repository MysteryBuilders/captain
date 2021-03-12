

import 'package:captain/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemarkTextField extends StatelessWidget {
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

  RemarkTextField({Key key, @required this.hint,@required this.icon,@required this.onClick, this.mText,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController myController = TextEditingController()..text = mText;

    return Column(

      children: [

        SizedBox(
          height:80.h,
          width: width,

          child: TextFormField(




            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.multiline ,
            onSaved: onClick,
            textInputAction: TextInputAction.next,
            maxLines: 5,
            minLines: 2,







            cursorColor: Color(0xFF000000),

            decoration:
            InputDecoration(

                errorStyle: TextStyle(height: 0),

                isDense: true,




                hintText: hint,
                hintStyle: TextStyle(
                    color: Color(0xFF002087)
                ),



                labelStyle: TextStyle( color: Color(0xFF002087)),
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

}