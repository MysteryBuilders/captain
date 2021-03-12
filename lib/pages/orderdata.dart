import 'dart:io';

import 'package:captain/api/api_client.dart';
import 'package:captain/component/FatherNameTextField.dart';
import 'package:captain/component/MeasureSizeRenderObject.dart';
import 'package:captain/component/age_textfield.dart';
import 'package:captain/component/box_number.dart';
import 'package:captain/component/civilid_textfiled.dart';
import 'package:captain/component/paerent_civilid.dart';
import 'package:captain/component/parent_phone_number.dart';
import 'package:captain/component/player_name_textfield.dart';
import 'package:captain/component/remark_textfield.dart';
import 'package:captain/helpers/order_model.dart';
import 'package:captain/model/academy_data.dart';
import 'package:captain/model/child_model.dart';
import 'package:captain/model/parent_model.dart';
import 'package:captain/pages/payment_screen.dart';
import 'package:captain/provider/model_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ndialog/ndialog.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';
class OrderData extends StatefulWidget {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Data mAcademy;
  int count;
  OrderData({Key key,@required this.mAcademy,@required this.count}): super(key: key);
  @override
  _OrderDataState createState() => _OrderDataState();
}

class _OrderDataState extends State<OrderData> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScreenUtil screenUtil = ScreenUtil();
  String _fullName='';
  NAlertDialog nAlertDialog;
  String _civilId ='';



  String _age='';
  String _parentPhoneNumber='';
  String _parentCivilId='';
  String _parentBox='';
  String _parentRemarks='';
  String _parentName='';
  File _image = null;
  var myChildSize = Size.zero;
  File _parentImage = null;
  bool parentImageSelected = false;
  final picker = ImagePicker();
  Future _getImageFromGallery(BuildContext context,int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    Navigator.pop(context);

      if (pickedFile != null) {

        if(!parentImageSelected) {

          _image = File(pickedFile.path);
          Files[index] = _image;
          print('file path -->${Files[index].path}');
        }else{
          _parentImage = File(pickedFile.path);
          parentImageSelected = false;
        }
      } else {
        print('No image selected.');
      }

  }
  List civilIds ;
  List names;
  List<File> Files ;
  List ages ;
  Future _getImageFromCamera(BuildContext context,int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    Navigator.pop(context);

      if (pickedFile != null) {
        if(!parentImageSelected) {
          _image = File(pickedFile.path);
          Files[index] = _image;

        }else{
          _parentImage = File(pickedFile.path);
          parentImageSelected = false;

        }

      } else {
        print('No image selected.');
      }

  }
  Future<NAlertDialog> showPickerDialog(BuildContext context,int index)async {
    nAlertDialog =   await NAlertDialog(
      dialogStyle: DialogStyle(titleDivider: true,borderRadius: BorderRadius.circular(10)),

      content: Padding(child: Text("اختار صورة الهوية"),
        padding: EdgeInsets.all(10),),
      actions: <Widget>[
        FlatButton(child: Text("كاميرا"),onPressed: () {

          _getImageFromCamera(context,index);
        }),
        FlatButton(child: Text("الوسائط المتعددة"),onPressed: () {
          _getImageFromGallery(context,index);
        }),

      ],
    );
return nAlertDialog;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
     civilIds = List(widget.count);
     names = List(widget.count);
     Files  = List(widget.count);
     ages = List(widget.count);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:  Color(0xFFFFFFFF),
      appBar: 
      AppBar(
          automaticallyImplyLeading:false,
        backgroundColor: Color(0xFFFFFFFF),
        title:  Container(
          alignment: AlignmentDirectional.centerStart,
          child: Text(

            'بيانات الطلب',

           style: GoogleFonts.cairo(
              fontSize: screenUtil.setSp(18, allowFontScalingSelf: true),
              color: const Color(0xFF002087),
              letterSpacing: -0.36,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),


        actions:[
      Transform.rotate(
      angle: 180 * math.pi / 180,
        child: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25.w,),
        onPressed: (){Navigator.pop(context);}),
      )
          ],
      ),
      body:

      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child:
        Form(
          key: widget._globalKey,
          child: ListView(
            padding: EdgeInsets.zero,
            physics: AlwaysScrollableScrollPhysics(),
            children: [

              ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,

                itemCount:widget.count,
              itemBuilder: (context,index){
                return


                  Container(
                  margin: EdgeInsets.all(10.w),
                  height: 220.h,
                  width: width,
                  child:


                  Stack(
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 9.w),
                        child:  Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0.h),
                              color: const Color(0xFFF2C046).withOpacity(0.53)
                          ),
                          child: Column(
                            children: [
                              Expanded(flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10.h),

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.h),bottomRight:Radius.circular(8.h) ),
                                        color:  Color(0xFFF2C046)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                                      child: Text(
                                        'بيانات اللاعب',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: screenUtil.setSp(14,allowFontScalingSelf: true),
                                          fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(flex: 1,
                                  child:
                                  Container(


                                    margin:

                                    EdgeInsets.only(bottom: 4.h,right: 40.w,left: 40.h),
                                    child:


                                    PlayerNameTextField(hint:"الإسم الكامل",onClick: (value){
                                       names[index]= value;

                                    },
                                    ),
                                  )),
                              Expanded(flex: 1,
                                  child:  Container(


                                    margin:

                                    EdgeInsets.only(bottom: 4.h,right: 40.w,left: 40.h),
                                    child:


                                    CivilIdTextField(hint:" الرقم المدني",onClick: (value){
                                      civilIds[index]= value;

                                    },
                                    ),
                                  )),
                              Expanded(flex: 1,
                                  child:  Container(


                                    margin:

                                    EdgeInsets.only(bottom: 4.h,right: 40.w,left: 40.h),
                                    child:


                                    AgeTextField(hint:" العمر",onClick: (value){
                                      ages[index]  = value;

                                    },
                                    ),
                                  )),
                              Expanded(flex: 1,
                                  child:

                                  GestureDetector(
                                    onTap: (){
                                      showPickerDialog(context,index).then((value){
                                        value.show(context);
                                      });


                                    },
                                    child: Container(
                                     margin: EdgeInsets.only(bottom: 4.h,right: 40.w,left: 40.h,top: 4.h),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(20.h)),
                                            color:  Color(0xFF002087)
                                        ),
                                        child: Stack(
                                          children: [
                                           Positioned.directional(
                                        textDirection :  Directionality.of(context),
                                             top: 0,
                                             bottom: 0,
                                             start: 0,
                                             child: Padding(
                                               padding:  EdgeInsets.all(8.0.w),
                                               child: Image.asset('images/take_photo.png',width: 30.w, height: 30.h,),
                                             ),
                                           ),
                                      Positioned.directional(

                                        textDirection :  Directionality.of(context),
                                        top: 0.0,
                                        bottom:0.0,
                                        start: 0.0,
                                        end: 0.0,
                                        child: Center(
                                          child: Text(
                                            'صورة الهوية',
                                            style: TextStyle(
                                              color:Color(0xFFF2C046),
                                              fontWeight: FontWeight.w500,
                                              fontSize: screenUtil.setSp(14,allowFontScalingSelf: true)
                                            ),
                                          ),
                                        ),

                                      )

                                          ],
                                        ),
                                      ),

                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),

                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child:   Container(
                          width: 20.0.w,
                          height: 20.0.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child:   Container(
                          width: 20.0.w,
                          height: 20.0.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:  Color(0xFFFFFFFF),
                          ),
                        ),
                      ),





                    ],
                  ),
                );
              },)
              ,SizedBox(height: 10.h,),
              Container(
                margin: EdgeInsets.all(10.w),
                height: 440.h,
                width: width,
                child:


                Stack(
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 9.w),
                  child:  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0.h),
                        color: const Color(0xFFDBE4FF)
                    ),
                    child: Column(
                      children: [
                        Expanded(flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10.h),

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.h),bottomRight:Radius.circular(8.h) ),
                                  color:  Color(0xFF002087)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Text(
                                  'ولي الأمر',
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: screenUtil.setSp(14,allowFontScalingSelf: true),
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ),
                            )),
                        Expanded(flex: 1,
                            child:
                            Container(


                              margin:

                              EdgeInsets.only(bottom: 4.h,right: 40.w,left: 40.h),
                              child:


                              FatherNameTextField(hint:"اسم ولي الامر",onClick: (value){
                                _parentName= value;

                              },
                              ),
                            )),
                        Expanded(flex: 1,
                            child:
                            Container(


                              margin:

                              EdgeInsets.only(bottom: 4.h,right: 40.w,left: 40.h),
                              child:


                              ParentPhoneNumberTextField(hint:"رقم الهاتف",onClick: (value){
                                _parentPhoneNumber= value;

                              },
                              ),
                            )),
                        Expanded(flex: 1,
                            child:  Container(


                              margin:

                              EdgeInsets.only(bottom: 4.h,right: 40.w,left: 40.h),
                              child:


                              ParentCivilId(hint:" الرقم المدني",onClick: (value){
                                _parentCivilId= value;

                              },
                              ),
                            )),
                        Expanded(flex: 1,
                            child:  Container(


                              margin:

                              EdgeInsets.only(bottom: 4.h,right: 40.w,left: 40.h),
                              child:


                              BoxNumberTextField(hint:" رقم الصندوق",onClick: (value){
                                _parentBox= value;

                              },
                              ),
                            )),
                        Expanded(flex: 2,
                            child:  Container(


                              margin:

                              EdgeInsets.only(bottom: 4.h,right: 40.w,left: 40.h),
                              child:


                              RemarkTextField(hint:" ملاحظات",onClick: (value){
                                _parentBox= value;

                              },
                              ),
                            )),
                        Expanded(flex: 2,
                            child:  Container(


                              margin:

                              EdgeInsets.only(bottom: 4.h,right: 40.w,left: 40.h),
                              child:
                              Text("سيتم اعتماد سعر المساهم في حالة إدخال رقم صندوق"
                              "وسيتم تدقيق الطلب من المسؤول وفي حالة عدم تطابق البيانات سيعتبر الطلب غير مفعل",
                                style: TextStyle(
                                  color: Color(0xFFFF0000),
                                  fontSize: screenUtil.setSp(11),
                                  fontWeight: FontWeight.normal
                                ),
                              )


                              ,
                            )),
                        Expanded(flex: 1,
                            child:

                            GestureDetector(
                              onTap: (){
                                parentImageSelected = true;
                                showPickerDialog(context,-1).then((value) {
                                  value.show(context);
                                });


                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 4.h,right: 40.w,left: 40.h,top: 4.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20.h)),
                                      color:  Color(0xFF002087)
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned.directional(
                                        textDirection :  Directionality.of(context),
                                        top: 0,
                                        bottom: 0,
                                        start: 0,
                                        child: Padding(
                                          padding:  EdgeInsets.all(8.0.w),
                                          child: Image.asset('images/take_photo.png',width: 30.w, height: 30.h,),
                                        ),
                                      ),
                                      Positioned.directional(

                                        textDirection :  Directionality.of(context),
                                        top: 0.0,
                                        bottom:0.0,
                                        start: 0.0,
                                        end: 0.0,
                                        child: Center(
                                          child: Text(
                                            'صورة الهوية',
                                            style: TextStyle(
                                                color:Color(0xFFF2C046),
                                                fontWeight: FontWeight.w500,
                                                fontSize: screenUtil.setSp(14,allowFontScalingSelf: true)
                                            ),
                                          ),
                                        ),

                                      )

                                    ],
                                  ),
                                ),

                              ),
                            )),
                      ],
                    ),
                  ),
                ),

                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child:   Container(
                    width: 20.0.w,
                    height: 20.0.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child:   Container(
                    width: 20.0.w,
                    height: 20.0.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:  Color(0xFFFFFFFF),
                    ),
                  ),
                ),





              ],
                ),
              ),
              SizedBox(height: 10.h,),
              GestureDetector(
                onTap: (){
                  validate(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 70.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.h),
                        color: const Color(0xFFF2C046)
                    ),


                  padding:  EdgeInsets.all(10.0.h),
                  alignment: AlignmentDirectional.center,
                  child: Text(
                   'التوجه للدفع'
                    ,style: TextStyle(
                    color: Color(0xFF002087),
                    fontSize: screenUtil.setSp(14,allowFontScalingSelf: true),
                    fontWeight: FontWeight.normal,

                  ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void validate(BuildContext context) async{

    final modelHud = Provider.of<ModelHud>(context,listen: false);

    if(widget._globalKey.currentState.validate()){

        widget._globalKey.currentState.save();
        bool isvalid = true;
        for(int i=0;i<Files.length;i++){
          File file = Files[i];
          if(file == null){
            isvalid = false;
            print('isvalid ${isvalid}');
            break;

          }

        }
        if(!isvalid){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('من فضلك ضع صورة الهوية الخاصة بالطفل')));


        }else{

          if(_parentImage == null){
            print(_parentImage);
            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('من فضلك ضع صورة الهوية الخاصة بولي الامر')));

          }else{
            modelHud.changeIsLoading(true);
            print('names ==> ${names.length}');
            print('civilIds ==> ${civilIds.length}');
            print('ages ==> ${ages.length}');
            print('files ==> ${Files.length}');
            List<ChildModel>  childrenList = List();
            for(int i =0;i<widget.count;i++){
              print(Files[i].path);
              ChildModel childModel = ChildModel(names[i], civilIds[i], Files[i], ages[i]);
              childrenList.add(childModel);
            }
            ParentModel parentModel = ParentModel(_parentName, _parentCivilId, _parentImage, _parentPhoneNumber, _parentBox, _parentRemarks);
            CaptinService captinService = CaptinService();
           dynamic  response = await captinService.sumbitOrder(widget.mAcademy.id.toString(), widget.count.toString(), childrenList, parentModel);
            bool success = response['success'];
            modelHud.changeIsLoading(false);
            if(success){
              OrderModel orderModel = OrderModel.fromJson(response);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentScreen(url:orderModel.payload.paymentUrl ,title: 'الدفع',)));

            }else{
              print(response);
            }


            print('success --> ${success}');

          }
        }






    }


  }
}
