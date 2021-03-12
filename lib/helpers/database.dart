import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';

class DataBase{
  var status ;
  var token ;
  var msg ;

  static urlstatename(){
    return "http://watten.enjjaz.net/";
  }

  loginData(String email , String password) async{
    String myUrl = "${urlstatename()}api/login";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "email": "$email",
          "password" : "$password"
        } ) ;

    var data = jsonDecode(response.body);

    status = data['status'];
    if(status){
      _save(data["access_token"],data['user']['name'],data['user']['email'],data['user']['img'],data['user']['id']);
    }else{
      msg= data['msg'];
    }
  }

  forgot(String email) async{
    String myUrl = "${urlstatename()}/resetpassword";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "email": "$email",
        } ) ;

    var data = jsonDecode(response.body);

    status = data['status'];
    if(status){
      print(data);
      msg= '${data['items']}';

    }else{
      msg= data['msg'];
    }
  }


  registerData(String name ,String email , String password, String password_confirmation, String phone) async{

    String myUrl = "${urlstatename()}/register";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "name": "$name",
          "email": "$email",
          "phone":"$phone",
          "password":"$password",
          "password_confirmation":"$password_confirmation"
        } ) ;

    var data = jsonDecode(response.body);
    status = data['status'];

    if(status){
      _save(data["access_token"],data['user']['name'],data['user']['email'],data['user']['img'],data['user']['id']);
    }else{
      msg= data['msg'];
    }
  }

  add_order(String academy_id , String count) async{
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;

    String myUrl = "${urlstatename()}api/add_order?token="+value;
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json',
        },
        body: {
          "academy_id": "$academy_id",
          "count" : "$count"
        } ) ;
    print(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      status = data['status'];
      if (status) {
        msg = data['msg'];
      } else {
        msg = data['msg'];
      }
    }
    else{
      status = false;
      msg ='يوجد خطأ ما!!';
    }
  }


  update_auth( String email , String name,String full_name,String phone,String address,String password, String password_confirmation,) async{
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;

    String myUrl = "${urlstatename()}/auth/update";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json',
          "Authorization": "Bearer " +value,
        },
        body: {
          "email": "$email",
          "name" : "$name",
          "full_name" : "$full_name",
          "phone" : "$phone",
          "address" : "$address",
          "password" : "$password",
          "password_confirmation" : "$password_confirmation"
        } ) ;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      status = data['status'];
      if (status) {
        msg = data['msg'];
      } else {
        msg = data['msg'];
      }
    }
    else{
      print(response.body);
    }
  }

  customer_add( String email , String name,String full_name,String phone,String address,String password, String password_confirmation,) async{
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;

    String myUrl = "${urlstatename()}/customer_add";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json',
          "Authorization": "Bearer " +value,
        },
        body: {
          "email": "$email",
          "name" : "$name",
          "full_name" : "$full_name",
          "phone" : "$phone",
          "address" : "$address",
          "password" : "$password",
          "password_confirmation" : "$password_confirmation"
        } ) ;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      status = data['status'];
      if (status) {
        msg = data['msg'];
      } else {
        msg = data['msg'];
      }
    }
    else{
      print(response.body);
    }
  }


  _save(String token,String username,String email,String img,int userid) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key,value);

    prefs.setString('username',username);
    prefs.setString('email',email);
    prefs.setString('img',img);

    final key3 = 'userid';
    final value3 = userid;
    prefs.setInt(key3,value3);

    prefs.setBool('auth',true);
  }

  void toast_error(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white
    );
  }

  void toast_success(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        gravity: ToastGravity.TOP,
        textColor: Colors.white
    );
  }

}