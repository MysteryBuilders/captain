import 'dart:convert';

import 'package:captain/api/api_client.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/database.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/helpers/utilities.dart';
import 'package:captain/model/login_error.dart';
import 'package:captain/model/login_model.dart';
import 'package:captain/model/save_token_model.dart';
import 'package:captain/pages/forgetpassword_screen.dart';
import 'package:captain/provider/model_hud.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'home.dart';
class Login extends StatefulWidget {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DataBase dataBase = new DataBase();
  String msgStatus = '';
  int s=1;
  CaptinService captinService = CaptinService();
  Map<String,dynamic> response;
  SharedPref sharedPref = SharedPref();
  bool isVisible = true;

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  void login(BuildContext context) async{
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);
    if(widget._globalKey.currentState.validate()){
      widget._globalKey.currentState.save();
    }
    String  email =_emailController.text.trim().toLowerCase();
    String password = _passwordController.text.trim().toLowerCase();
    if(!Utilities.validateEmail(email) || password.trim().isEmpty){
      modelHud.changeIsLoading(false);
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('من فضلك تحقق من البيانات الخاصة بك')));

    }else{

      response = await captinService.login(email.trim(), password.trim());

      bool success = response['success'];
      modelHud.changeIsLoading(false);
      if(success == true){
        print('response ${response.toString()}');
        Login_model   login_model = Login_model.fromJson(response);
print('userName${ login_model.toJson()}');
        if(success) {
      await sharedPref.save(kUser, login_model);
      await sharedPref.saveBool(kKeepMeLoggedIn, true);
      await sharedPref.saveString(kUserPassword, password);
      await sharedPref.saveString(kUserName, login_model.payload.user.name);
      await sharedPref.saveString(KImage, login_model.payload.user.img);
      SaveTokenModel saveTokenModel = await captinService.saveToken();
      bool isSuccess = saveTokenModel.success;

          modelHud.changeIsLoading(false);
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('مرحبا بك ')));
      Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
        }else{
          modelHud.changeIsLoading(false);
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('خطأ في بيانات الدخول')));
        }
      }else{
        modelHud.changeIsLoading(false);
        Login_error login_error = Login_error.fromJson(Map<String, dynamic>.from(response));
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(login_error.message)));

      }





    }


  }
  _onPressed(){
    // setState(() {
    //   s=0;
    // });
    // setState(() {
    //   dataBase.loginData(_emailController.text.trim().toLowerCase(),
    //       _passwordController.text).whenComplete((){
    //     if(dataBase.status ){
    //       setState(() {
    //         s=1;
    //       });
    //       dataBase.toast_success('مرحبا بك');
    //       Navigator.pushReplacementNamed(context, '/home');
    //     }else{
    //       setState(() {
    //         s=1;
    //       });
    //       msgStatus = dataBase.msg;
    //       dataBase.toast_error(msgStatus);
    //     }
    //   });

    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:

      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child:

        Form(
         key: widget._globalKey,
          child: ListView(
            children: [
              Container(
                  height: 190,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [const Color(0xFFC78B2B),const Color(0xFFE4AF3D),const Color(0xFFF2C046)],begin: Alignment.bottomRight,
                      end: Alignment.topLeft,),
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
                              child:
                              Container(
                                  alignment: Alignment.center,
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child:Icon(Icons.arrow_forward,size: 17,color: Color(0xFFE4AF3D),)
                              )
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(.9,.6),
                        child: Container(
                          width: MediaQuery.of(context).size.width*60/100,
                          height: 149,
                          child:  Image.asset('images/lite.png',fit: BoxFit.cover,),
                        ) ,
                      ),
                      Align(
                        alignment: Alignment(.5,.4),
                        child:Text(
                          'تسجيل الدخول إلي حسابك',
                          style: GoogleFonts.cairo(
                            fontSize: 24.0,
                            color: Colors.white,
                            letterSpacing: -0.48,
                            fontWeight: FontWeight.w700,
                            height: 1.75,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  )

              ),
              SizedBox(height: 60,),

              Stack(

                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child:Column(
                      children: [
                        Container(
                          width: 6.0,
                          height: 61.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: const Color(0xFFF2C046),
                          ),
                        ),
                        SizedBox(height: 300,),
                        Container(
                          width: 6.0,
                          height: 110.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: const Color(0xFFF2C046),
                          ),
                        ),
                      ],
                    ),


                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 125),
                      width: 6.0,
                      height: 92.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: const Color(0xFFF2C046),
                      ),
                    ),
                  ),

                  Align(
                      alignment: Alignment.center,
                      child:Column(
                        children: [
                          SizedBox(height: 90,),

                          Container(
                            height:150,
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
                                    Divider(color: Colors.grey,),
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
                                                obscureText: isVisible,
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
                                                  isVisible = !isVisible;
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
                                  ],
                                )
                            ),
                          ),
                           GestureDetector(
                             onTap: (){
                               ForgetPassword(context);
                             },
                            child: Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*40/100),
                            child:  Text(
                              'نسيت كلمة المرور',
                              style: GoogleFonts.cairo(
                                fontSize: 14.0,
                                color: const Color(0xFF717171),
                                letterSpacing: -0.28,
                                fontWeight: FontWeight.w600,
                                height: 3.0,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            ),
                          ),
                          SizedBox(height: 25,),
                          InkWell(

                            child:
                            Container(
                                height: 43.0,
                                width: MediaQuery.of(context).size.width*45/100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22.0),
                                  color: const Color(0xFFF2C046),
                                ),
                                child:
                                GestureDetector(
                                  onTap: (){
                                    login(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      'تسجيل الدخول',
                                      style: GoogleFonts.cairo(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
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
      ),
    );
  }
  Future ForgetPassword(BuildContext context) async {

    Map results = await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
      return new ForgetPasswordScreen();
    }));
    if (results != null && results.containsKey('email')) {
      setState(() {
        print(results['email']);
        print(results['password']);
        _emailController.text = results['email'];
        _passwordController.text = results['password'];

      });


    }

  }
}
