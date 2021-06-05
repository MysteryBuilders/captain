import 'package:captain/component/email_textfield.dart';
import 'package:captain/component/gradient_appbar.dart';
import 'package:captain/component/info_edittext.dart';
import 'package:captain/component/name_textfield.dart';
import 'package:captain/component/phone_texfield.dart';
import 'package:captain/provider/model_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
class ContactUs extends StatefulWidget {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'ContactUsScreen';
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  ScreenUtil screenUtil = ScreenUtil();
  String _fullName='';
  String _email ='';
  String _phone ='';
  String _note ='';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFFFFFF),
      body:

      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child:
        Form(
          key: widget._globalKey,
          child: Column(


            children: [
            Expanded(
              flex: 1,
              child:
              GradientAppBar(screenUtil: screenUtil,title:'اتصل بنا'),
            ),
              Expanded(
                flex: 9,

                  child: Container(
                    margin: EdgeInsets.all(20.w),
                    color: Color(0xFFFFFFFF),
                    child: ListView(
                      children: [

                        NameTextField(hint:"الاسم",onClick: (value){
                          _fullName= value;

                        },
                        ),

                        SizedBox(height: 10.h,),

                        EmailTextField(hint:"البريد الالكتروني ",onClick:(value){
_email = value;
                        }),
                        SizedBox(height: 10.h,),
                        PhoneTextField(hint:"رقم الهاتف",onClick: (value){
                          _phone= value;

                        },
                        ),
                        SizedBox(height: 10.h,),
                        InfoEditText(hint:"أدخل استفسارك…",onClick: (value){
                          _note= value;

                        },
                        ),
                        SizedBox(height: 20.h,),

                        GestureDetector(
                          onTap: (){
                            sendData(context);
                          },

                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                              height: 40.h,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0.w),
                                color: const Color(0xFFF2C046),
                              ),
                              child:
                              Center(
                                child: Text(
                                  'إرسال',
                                  style: GoogleFonts.cairo(
                                    fontSize: screenUtil.setSp(13),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                          ),
                        )

                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void sendData(BuildContext context) {
    final modelHud = Provider.of<ModelHud>(context,listen: false);

    if(widget._globalKey.currentState.validate()){
      widget._globalKey.currentState.save();
    }

  }
}


