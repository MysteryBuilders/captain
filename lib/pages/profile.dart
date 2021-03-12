import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain/api/api_client.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/database.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/error_profile_model.dart';
import 'package:captain/model/login_model.dart';
import 'package:captain/model/profile_model.dart';
import 'package:captain/model/register_error.dart';
import 'package:captain/model/update_profile_model.dart';
import 'package:captain/provider/model_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:async/async.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScreenUtil screenUtil = ScreenUtil();
  SharedPref sharedPref = SharedPref();
  Login_model login_model;
  DataBase dataBase = new DataBase();
  String msgStatus = '';
  int s=1;
  File _image = null;
  var _img;
  String userName = "";
  String userEmail="";
  String userImage ="";
  String userPhone ="";
  String baseImageUrl;
  String userPassword;


  final picker = ImagePicker();
  Future _getImageFromGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    Navigator.pop(context);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future _getImageFromCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    Navigator.pop(context);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

      } else {
        print('No image selected.');
      }
    });
  }
  Future<Map>  getBasicInfo() async{
    Map map = Map();




      String imageUrl = await sharedPref.readString(KBaseImageUrl);
      String password = await sharedPref.readString(kUserPassword);
    map[KBaseImageUrl] = imageUrl;
    map[kUserPassword] = password;

      return map;


    }



  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  NAlertDialog nAlertDialog;
  // _onPressed() async{
  //   setState(() {
  //     s = 0;
  //   });
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.get('token') ?? 'null';
  //   String myUrl = DataBase.urlstatename()+'api/auth/update?token='+value;
  //
  //   var uri = Uri.parse(myUrl);
  //   var request = http.MultipartRequest("POST", uri);
  //   request.headers['Accept']='application/json';
  //   request.fields['name'] = _nameController.text;
  //   request.fields['email'] = _emailController.text;
  //   request.fields['password'] = _passwordController.text;
  //   request.fields['phone'] = _phoneController.text;
  //   if(_image != null) {
  //     var stream = http.ByteStream(_image.openRead());
  //     var length = await _image.length();
  //     request.files.add(http.MultipartFile("img", stream.cast(), length,
  //         filename: path.basename(_image.path)));
  //   }
  //   http.Response response = await http.Response.fromStream(await request.send());
  //
  //   var data = convert.jsonDecode(response.body);
  //   var status = data['status'];
  //
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       s = 1;
  //     });
  //     dataBase.toast_success('تمت العملية بنجاح');
  //
  //   }else{
  //     setState(() {
  //       s = 1;
  //     });
  //     dataBase.toast_success('يوجد خطأ حاول مرة أخرى');
  //   }
  // }
  CaptinService captinService = CaptinService();
  ProfileModel profileModel = null;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override

  void initState() {
    super.initState();
    getProfile().then((value){

        profileModel = value;


    }).whenComplete(() {
      getBasicInfo().then((value){
        setState(() {

          userName = profileModel.payload.name;
          userEmail = profileModel.payload.email;
          userImage = profileModel.payload.img;
          userPhone = profileModel.payload.phone;
          baseImageUrl = value[KBaseImageUrl];

          userPassword = value[kUserPassword];
          _nameController.text = userName;
          _emailController.text = userEmail;
          _phoneController.text = userPhone;
          _passwordController.text = userPassword;
          print('userName-->${userName}');
          print('userEmail-->${userEmail}');
          print('userImage-->${userImage}');
        });

      });
    });

  }
  Future<ProfileModel> getProfile() async{
    ProfileModel pModel = await captinService.getProfile();
    return pModel;

  }
  Future<NAlertDialog> showPickerDialog(BuildContext context)async {
    nAlertDialog =   await NAlertDialog(
        dialogStyle: DialogStyle(titleDivider: true,borderRadius: BorderRadius.circular(10)),

    content: Padding(child: Text("اختار الصورة"),
    padding: EdgeInsets.all(10),),
    actions: <Widget>[
    FlatButton(child: Text("كاميرا"),onPressed: () {

      _getImageFromCamera(context);
    }),
    FlatButton(child: Text("الوسائط المتعددة"),onPressed: () {
      _getImageFromGallery(context);
    }),

    ],
    );
    return nAlertDialog;

  }
  bool isVisble = true;
  bool selectImage = false;

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:
      baseImageUrl == null?
      Container(
        child: CircularProgressIndicator(),
        alignment: FractionalOffset.center,
      ):

      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: ListView(

          children: [
            Container(
                height: 239,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [const Color(0xFFF2C046),const Color(0xFFE4AF3D),const Color(0xFFC78B2B)],begin: Alignment.topRight,
                    end: Alignment.bottomLeft,),
                ),

                child:

                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: (){Navigator.pop(context);},
                        child: Padding(padding: EdgeInsets.all(15),
                            child: Icon(Icons.arrow_back_ios_outlined,size: 17,color: Colors.white,)
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child:Padding(padding: EdgeInsets.only(top: 6),
                      child:  Text(
                        'تعديل الملف الشخصي',
                        style: GoogleFonts.cairo(
                          fontSize: 18.0,
                          color: Colors.white,
                          letterSpacing: -0.36,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      )

                    ),

                    Align(
                      alignment: Alignment.center,
                      child: // Group: Group 157

                      SizedBox(
                        width: 108.0,
                        height: 104.0,
                        child: Stack(
                          children: <Widget>[
                            _image == null?
                            CachedNetworkImage(
                              imageUrl: baseImageUrl+userImage,
                              imageBuilder: (context, imageProvider) => Container(
                                height: 84.h,
                                width: 84.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            )
                            :

                      Container(
                      width: 84.w,
                      height: 84.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(_image),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),


                            Positioned(
                              right: 0,
                              top: 7.0,
                              child: InkWell(
                                onTap:(){
                                  showPickerDialog(context).then((value){
                                    value.show(context);
                                  });
                              },
                                child:  Container(
                                    alignment: Alignment(0.05, 0.0),
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF717171),
                                      border: Border.all(
                                        width: 2.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Icon(Icons.image,color: Colors.white,size: 12,)
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                )

            ),
            SizedBox(height: 20,),

            Stack(

              children: [

                Align(
                    alignment: Alignment.center,
                    child:Column(
                      children: [
                        SizedBox(height: 5,),

                        Container(
                          height:330,
                          width: MediaQuery.of(context).size.width*80/100,
                          decoration: BoxDecoration(
                            boxShadow: [
                              new BoxShadow(
                                color:  const Color(0xFFE3E3E3).withOpacity(.90),
                                blurRadius: 15.0,
                              ),
                            ],
                          ),
                          child: new Card(
                              child: Column(
                                children: [
                                  Container(
                                    height: 55,
                                    margin:  EdgeInsets.only(right: 30.0),
                                    child:TextField(
                                      controller: _nameController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          labelText: ' الاسم الكامل',
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                              fontSize: 13
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(padding:EdgeInsets.symmetric(horizontal: 15),
                                    child: Divider(color: Colors.grey,),
                                  ),
                                  Container(
                                    height: 55,
                                    margin:  EdgeInsets.only(right: 30.0),
                                    child:TextField(
                                      enabled: false,
                                      controller: _emailController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          labelText: 'البريد الإلكتروني',
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                              fontSize: 13
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(padding:EdgeInsets.symmetric(horizontal: 15),
                                    child: Divider(color: Colors.grey,),
                                  ),
                                  Container(
                                      height: 55,
                                      margin:  EdgeInsets.only(right: 30.0),
                                      child:Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width*58/100,
                                            child: TextField(
                                              controller: _phoneController,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  labelText: 'رقم الهاتف',
                                                  border: InputBorder.none,
                                                  labelStyle: TextStyle(
                                                      fontSize: 13
                                                  )
                                              ),
                                            ),
                                          ),

                                          Container(
                                            width: 39.0,
                                            height: 22.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4.0),
                                              color: const Color(0xFFE3E3E3),
                                            ),
                                            child: Center(
                                              child:
                                              Text(
                                                '+965',
                                                style: GoogleFonts.cairo(
                                                  fontSize: 13.0,
                                                  color: const Color(0xFF717171),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                  Padding(padding:EdgeInsets.symmetric(horizontal: 15),
                                    child: Divider(color: Colors.grey,),
                                  ),
                                  Container(
                                      height: 55,
                                      margin:  EdgeInsets.only(right: 30.0),
                                      child:Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width*58/100,
                                            child:  TextField(
                                              controller: _passwordController,
                                              keyboardType: TextInputType.text,
                                              enabled: false,
                                              obscureText: isVisble,
                                              decoration: InputDecoration(
                                                  labelText: 'كلمة المرور',
                                                  border: InputBorder.none,
                                                  labelStyle: TextStyle(
                                                      fontSize: 13
                                                  )
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                isVisble = !isVisble;
                                              });
                                            },
                                            child: Container(
                                              width: 39.0,
                                              height: 22.0,
                                              child: Center(
                                                  child:
                                                  Icon(Icons.remove_red_eye,size: 15,color: Color(0xFF717171),)
                                              ),
                                            ),
                                          ),

                                        ],
                                      )
                                  ),
                                  Padding(padding:EdgeInsets.symmetric(horizontal: 15),
                                    child: Divider(color: Colors.grey,),
                                  ),

                                ],
                              )
                          ),
                        ),
                        SizedBox(height: 25,),
                        InkWell(
                          onTap: (){
                            validation(context);
                          },

                          child:
                          Container(
                              height: 43.0,
                              width: MediaQuery.of(context).size.width*45/100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22.0),
                                color: const Color(0xFFF2C046),
                              ),
                              child: Center(
                                child: Text(
                                  'حفظ التغييرات',
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                          ),
                        )

                      ],
                    )


                ),


              ],
            ),

          ],
        ),
      ),
    );
  }

  void validation(BuildContext context) async{
    String mPhoneEntered = _phoneController.text;
    String mNameEntered = _nameController.text;
    String mEmail = _emailController.text;
    dynamic response;

    final modelHud = Provider.of<ModelHud>(context,listen: false);
    // modelHud.changeIsLoading(true);
    if(!validatePhone(mPhoneEntered)){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('من فضلك ضع رقم الهاتف')));


    }else if(mNameEntered.trim() == ""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('من فضلك ضع الاسم')));

    }else{
      modelHud.changeIsLoading(true);
  response  =await    captinService.updateProfile(mNameEntered, mEmail, mPhoneEntered, _image);
  modelHud.changeIsLoading(false);
      bool success = response['success'];
  if(success){
    UpdateProfileModel   updateProfileModel = UpdateProfileModel.fromJson(response);

    SharedPref sharedPref = SharedPref();
    await sharedPref.saveString(kUserName, updateProfileModel.payload.name);
    await sharedPref.saveString(KImage, updateProfileModel.payload.img);
    print('name --> ${updateProfileModel.payload.name}');
    print('image --> ${updateProfileModel.payload.img}');
   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('لقد تم حفظ البيانات بنجاح')));
    Navigator.of(context).pop({kUserName: updateProfileModel.payload.name,
      KImage:updateProfileModel.payload.img});


  }else{
    print(response);
    ErrorProfileModel login_error = ErrorProfileModel.fromJson(Map<String, dynamic>.from(response));
    String message="";
    print(login_error.payload);

    for(int i =0;i<login_error.payload.phone.length;i++){
      message += login_error.payload.phone[i]+",";
    }
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(login_error.message)));



  }


    }



  }
  bool validatePhone(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{8}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return false;
    }
    else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
