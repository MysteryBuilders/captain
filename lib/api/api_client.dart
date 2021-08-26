import 'dart:convert';
import 'dart:io';

import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/order_model.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/main.dart';
import 'package:captain/model/academies_category_model.dart';
import 'package:captain/model/academies_model.dart';
import 'package:captain/model/child_model.dart';
import 'package:captain/model/login_error.dart';
import 'package:captain/model/login_model.dart';
import 'package:captain/model/main_model.dart';
import 'package:captain/model/notification_model.dart';
import 'package:captain/model/parent_model.dart';
import 'package:captain/model/player_model.dart';
import 'package:captain/model/profile_model.dart';
import 'package:captain/model/question_model.dart';
import 'package:captain/model/register_model.dart';
import 'package:captain/model/reset_password_model.dart';
import 'package:captain/model/save_token_model.dart';
import 'package:captain/model/update_profile_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CaptinService {
  static String TAG_BASE_URL= "https://captain23.com/api/v1/";
  Future<dynamic> login(String email ,String password) async{
    Map<String, dynamic> map = {'email': email,
    'password':password};
    print(map);
   dynamic resp;


      var dio = Dio();

      FormData formData = new FormData.fromMap(map);
      print(formData.fields);
    try {
      var response = await dio.post(TAG_BASE_URL + "login",
          options: Options(contentType: 'multipart/form-data'),

          data: formData);
      print(response.data);

      if (response.statusCode == 200) {
        resp = response.data;
        print('resp --> ${resp}');

      }
    }on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      resp =e.response.data;



    }
    return resp;


  }
  Future<dynamic> register(String name ,String phone,String email,String password,String confirmPassword) async{
    Map<String, dynamic> map = {'name': name,
      'phone':phone,'email':email,
    'password':password,
    'password_confirmation':confirmPassword};
    dynamic resp;
    var dio = Dio();

    FormData formData = new FormData.fromMap(map);
    print(formData.fields);
    try {
      var response = await dio.post(TAG_BASE_URL + "register",
          options: Options(contentType: 'multipart/form-data'),

          data: formData);
      print(response.data);

      if (response.statusCode == 200) {
        resp = response.data;

      }
    }on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      resp =e.response.data;



    }
    return resp;


  }

  Future<dynamic> resetPassword(String email )async{
    Map<String, dynamic> map = {'email': email};
    dynamic resp;
    var dio = Dio();

    FormData formData = new FormData.fromMap(map);
    print(formData.fields);

    try {
      var response = await dio.post(TAG_BASE_URL + "reset",
          options: Options(contentType: 'multipart/form-data'),

          data: formData);
      print(response.data);

      if (response.statusCode == 200) {
        resp = response.data;

      }
    }on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      resp =e.response.data;



    }
    return resp;


  }

  Future<MainModel> mainModel(String email )async{
    Map<String, dynamic> map = {'email': email};
    MainModel main_model;
    var dio = Dio();

    FormData formData = new FormData.fromMap(map);
    print(formData.fields);
    var  response = await dio.get(TAG_BASE_URL+"main?email=${email}");
    print(response.data);
    if(response.statusCode == 200){

      main_model = MainModel.fromJson(Map<String, dynamic>.from(response.data));

    }
    print(main_model.success);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('main', json.encode(main_model));
    return main_model;


  }
  Future<AcademiesModel> academies(int page)async{

    AcademiesModel academiesModel;
    var dio = Dio();


    var  response = await dio.get(TAG_BASE_URL+"academies?page=${page}");
    print(response.data);
    if(response.statusCode == 200){

      academiesModel = AcademiesModel.fromJson(Map<String, dynamic>.from(response.data));

    }
    print(academiesModel.success);
    return academiesModel;


  }
  Future<PlayerModel> players(int page)async{

    PlayerModel playerModel;
    var dio = Dio();


    var  response = await dio.get(TAG_BASE_URL+"players?page=${page}");
    print(response.data);
    if(response.statusCode == 200){

      playerModel = PlayerModel.fromJson(Map<String, dynamic>.from(response.data));

    }
    print(playerModel.success);
    return playerModel;


  }
  Future<AcademiesCategoryModel> academiesCategory(int cityId,int page )async{
    Map<String, dynamic> map = {'city_id': cityId,
    'page':page};
    AcademiesCategoryModel academiesCategoryModel;
    var dio = Dio();

    FormData formData = new FormData.fromMap(map);
    print(formData.fields);
    var  response = await dio.post(TAG_BASE_URL+"academies/filter",options: Options(contentType: 'multipart/form-data'),

        data: formData);
    print(response.data);
    if(response.statusCode == 200){

      academiesCategoryModel = AcademiesCategoryModel.fromJson(Map<String, dynamic>.from(response.data));

    }
    print(academiesCategoryModel.payload.data.length);
    return academiesCategoryModel;


  }
  Future<QuestionModel> question(String playerId,String name,String email,String phone,String subject )async{
    Map<String, dynamic> map = {'id':playerId,
      'subject': 'استفسار',
      'msg':subject,
      'name':name,
      'email':email,
    'phone':phone};
    QuestionModel academiesCategoryModel;
    var dio = Dio();

    FormData formData = new FormData.fromMap(map);
    print(formData.fields);
    var  response = await dio.post(TAG_BASE_URL+"players/inquiry",options: Options(contentType: 'multipart/form-data'),

        data: formData);
    print(response.data);
    if(response.statusCode == 200){

      academiesCategoryModel = QuestionModel.fromJson(Map<String, dynamic>.from(response.data));

    }
    print(academiesCategoryModel.success);
    return academiesCategoryModel;


  }
  Future<ProfileModel> getProfile()async{
    SharedPref sharedPref = SharedPref();
    var userJson = await sharedPref.read(kUser);
    Login_model login_model =  Login_model.fromJson(userJson);
    var token = login_model.payload.accessToken;



    ProfileModel profileModel;
    var dio = Dio();
    // dio.options.headers["Authorization"] = "Bearer ${token}";
    dio.options.contentType = 'application/json';
    // dio.options.headers[HttpHeaders.authorizationHeader] ="Bearer ${token}";


    var  response = await dio.get(TAG_BASE_URL+"profile?token="+token );
    print(response.data);
    if(response.statusCode == 200){

      profileModel = ProfileModel.fromJson(Map<String, dynamic>.from(response.data));

    }
    print(profileModel.success);
    return profileModel;


  }
  Future<SaveTokenModel> saveToken(String token,String fireBaseToken)async{


    Map<String, dynamic> map = {'token':fireBaseToken};


    SaveTokenModel saveTokenModel;
    var dio = Dio();
    // dio.options.headers["Authorization"] = "Bearer ${token}";
    dio.options.contentType = 'application/json';
    // dio.options.headers[HttpHeaders.authorizationHeader] ="Bearer ${token}";

    FormData formData = new FormData.fromMap(map);
    print(formData.fields);
    var  response = await dio.post(TAG_BASE_URL+"save-token?token="+token,options: Options(contentType: 'multipart/form-data'),

        data: formData);

    print(response.data);
    if(response.statusCode == 200){

      saveTokenModel = SaveTokenModel.fromJson(Map<String, dynamic>.from(response.data));

    }
    print(saveTokenModel.success);
    return saveTokenModel;


  }
  Future<NotificationModel> notifications(int page)async{
    SharedPref sharedPref = SharedPref();
    var userJson = await sharedPref.read(kUser);
    var fireBaseToken = await sharedPref.readString(kSaveFireBaseToken);
    Login_model login_model =  Login_model.fromJson(userJson);
    var token = login_model.payload.accessToken;



    NotificationModel notificationModel;
    var dio = Dio();
    // dio.options.headers["Authorization"] = "Bearer ${token}";
    dio.options.contentType = 'application/json';
    // dio.options.headers[HttpHeaders.authorizationHeader] ="Bearer ${token}";


    var  response = await dio.get(TAG_BASE_URL+"notifications?page="+page.toString()+"&token="+token);


    print(response.data);
    if(response.statusCode == 200){

      notificationModel = NotificationModel.fromJson(Map<String, dynamic>.from(response.data));

    }
    print(notificationModel.success);
    return notificationModel;


  }
  Future<dynamic> updateProfile(String name,String email,String Phone,File image )async{
    SharedPref sharedPref = SharedPref();
    var userJson = await sharedPref.read(kUser);
    Login_model login_model =  Login_model.fromJson(userJson);
    var token = login_model.payload.accessToken;



    UpdateProfileModel updateProfileModel;
    dynamic resp;
    try {
      var dio = Dio();

      // dio.options.headers["Authorization"] = "Bearer ${token}";
      dio.options.contentType = 'application/json';
      // dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer ${token}";
      String fileName = image.path
          .split('/')
          .last;
      FormData formData = FormData.fromMap({
        "img":
        await MultipartFile.fromFile(image.path, filename: fileName),
        "phone": Phone,
        "email": email,
        "name": name,
        "full_name": name,
        "facebook": ""
      });

      var response = await dio.post(TAG_BASE_URL + "profile?token="+token, data: formData);
      print(response.data);
      if (response.statusCode == 200) {
        resp = response.data;
      }

    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      resp =e.response.data;



    }
    return resp;


  }
  Future<dynamic> sumbitOrder(String id,String qty,List<ChildModel> childModelList,ParentModel parentModel )async{
    SharedPref sharedPref = SharedPref();
    var userJson = await sharedPref.read(kUser);
    Login_model login_model =  Login_model.fromJson(userJson);
    var token = login_model.payload.accessToken;

    Map<String, dynamic> map = Map();
    map['academy_id'] = id;
    map['qty'] = qty;
    map['parent[name]']= parentModel.name;
    map['parent[civil_no]']= parentModel.civilId;
    map['parent[phone]']= parentModel.phone;
    // map['parent[box_no]']= parentModel.boxNo;
    map['parent[note]']= parentModel.note;
    String parentFileName = parentModel.image.path
        .split('/')
        .last;
    map['parent[img]']=  await MultipartFile.fromFile(parentModel.image.path, filename: parentFileName);

    for(int i =0;i<childModelList.length;i++){
      map['players[${i}][name]']= childModelList[i].name;
      map['players[${i}][civil_no]']= childModelList[i].civilId;
      map['players[${i}][age]']= childModelList[i].age;
      map['players[${i}][clothes]']= childModelList[i].dressNo;
      bool isSibiling = childModelList[i].isSiblings;
      if(isSibiling){
        map['players[${i}][is_brother]']= 1;
      }else{
        map['players[${i}][is_brother]']=0;
      }
      String childFileName = childModelList[i].image.path
          .split('/')
          .last;
      map['players[${i}][img]']=  await MultipartFile.fromFile(childModelList[i].image.path, filename: childFileName);

    }
    FormData formData = new FormData.fromMap(map);
    OrderModel orderModel;

    dynamic resp;
    try {
      var dio = Dio();

      // dio.options.headers["Authorization"] = "Bearer ${token}";
      dio.options.contentType = 'application/json';
      // dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer ${token}";


      var response = await dio.post(TAG_BASE_URL + "academies/order?token="+token, data: formData);
      print(response.data);
      if (response.statusCode == 200) {
        orderModel = OrderModel.fromJson(Map<String, dynamic>.from(response.data));
        resp = response.data;
      }

    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      resp =e.response.data;



    }
    return resp;


  }
  Future<Login_model> refreshToke()async{
    SharedPref sharedPref = SharedPref();
    var userJson = await sharedPref.read(kUser);
    var fireBaseToken = await sharedPref.readString(kSaveFireBaseToken);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String loginData = sharedPreferences.getString(kUser);
    final body = json.decode(loginData);
    Login_model   loginModel = Login_model.fromJson(body);

    var token = loginModel.payload.accessToken;



    Login_model model;
    var dio = Dio();
    // dio.options.headers["Authorization"] = "Bearer ${token}";
    dio.options.contentType = 'application/json';
    // dio.options.headers[HttpHeaders.authorizationHeader] ="Bearer ${token}";


    var  response = await dio.post(TAG_BASE_URL+"refresh?token="+token);


    print(response.data);
    if(response.statusCode == 200){

      model = Login_model.fromJson(Map<String, dynamic>.from(response.data));

    }
    print(model.success);
    return model;


  }
}