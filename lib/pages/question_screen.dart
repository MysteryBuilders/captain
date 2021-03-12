import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain/api/api_client.dart';
import 'package:captain/component/email_textfield.dart';
import 'package:captain/component/gradient_appbar.dart';
import 'package:captain/component/info_edittext.dart';
import 'package:captain/component/name_textfield.dart';
import 'package:captain/component/phone_texfield.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/player_data.dart';
import 'package:captain/model/question_model.dart';
import 'package:captain/provider/model_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
class QuestionPlayerScreen extends StatefulWidget {
  static String id = 'QuestionPlayerScreen';
  PlayerData player;
  String mBaseImageUrl;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  QuestionPlayerScreen({Key key,@required this.player,this.mBaseImageUrl}): super(key: key);
  @override
  _QuestionPlayerScreenState createState() => _QuestionPlayerScreenState();
}

class _QuestionPlayerScreenState extends State<QuestionPlayerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ScreenUtil screenUtil = ScreenUtil();
  CaptinService captinService = CaptinService();

  SharedPref mSharedPrefs = SharedPref();
  String _fullName='';
  String _email ='';
  String _phone ='';
  String _note ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFFFFFF),
      body:
      Column(
        children: [
          Expanded(child: GradientAppBar(screenUtil: screenUtil,title:'إستفسار')
            ,flex: 1,),
          Expanded(child:
          ModalProgressHUD(
            inAsyncCall: Provider.of<ModelHud>(context).isLoading,
            child:
            Form(
              key: widget._globalKey,
              child: Container(
                margin: EdgeInsets.all(10.h),
                child: ListView(
                    scrollDirection: Axis.vertical,



                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Container(
                      height: 100.h,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Container(
                            width: 90.w,
                            height: 90.w,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,


                            ),child:

                          CachedNetworkImage(
                            imageUrl: widget.mBaseImageUrl+widget.player.img,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 90.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50.w)),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                          ),
                          ),
                          Column(
                            children: [
                              Expanded(
                                flex: 1,

                                child:

                                Container(
                                  margin: EdgeInsets.only(bottom: 4.h),

                                  decoration: BoxDecoration(
                                    color: Color(0xFFDBE4FF),
                                    borderRadius: BorderRadius.circular(5.w),


                                  ) ,
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal:30.0.w),
                                    child: Text(
                                      widget.player.cat.name,
                                      style: TextStyle(
                                          color: Color(0xFF002087),
                                          fontSize: screenUtil.setSp(18,allowFontScalingSelf: true),
                                          fontWeight: FontWeight.normal


                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(child: Container(
                                margin: EdgeInsets.only(bottom: 4.h),

                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal:30.0.w),
                                  child: Text(
                                    widget.player.name,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(18,allowFontScalingSelf: true),
                                        fontWeight: FontWeight.bold


                                    ),
                                  ),
                                ),
                              ),flex: 1,),
                              Expanded(child:      Container(
                                margin: EdgeInsets.only(bottom: 4.h),

                                decoration: BoxDecoration(
                                  color: Color(0xFFF2C046),
                                  borderRadius: BorderRadius.circular(30.w),


                                ) ,
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal:30.0.w),
                                  child: Text(
                                    'إستفسار',
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(18,allowFontScalingSelf: true),
                                        fontWeight: FontWeight.normal


                                    ),
                                  ),
                                ),
                              ),flex: 1,),
                            ],
                          )
                        ],

                      ),
                    ),
                    SizedBox(height: 6.h,),
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
                                fontSize: screenUtil.setSp(13,allowFontScalingSelf: true),
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                      ),
                    )
                  ],


                ),
              ),
            ),
          ),flex: 9,)
        ],
      ),

    );
  }
  void sendData(BuildContext context) async {
    final modelHud = Provider.of<ModelHud>(context,listen: false);

    if(widget._globalKey.currentState.validate()){
      widget._globalKey.currentState.save();
      modelHud.changeIsLoading(true);
      String playerId = widget.player.id.toString();
      QuestionModel questionModel =  await captinService.question(playerId,_fullName, _email, _phone, _note);
      modelHud.changeIsLoading(false);

      if(questionModel.success){

        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('لقد تم ارسال استفسارك بنجاح  ')));
        Navigator.pop(context);


      }else{
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('لقد تعذر ارسال استفسارك  ')));


      }



    }

  }
}
