import 'package:captain/helpers/database.dart';
import 'package:captain/model/CoachModel.dart';
import 'package:captain/provider/CoachProvider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CoachController{


  static Future <CoachModel> getdatafeature(BuildContext context) async{
    var url=DataBase.urlstatename()+'api/last_coach?page=${Provider.of<CoachProvider>(context, listen: false).page}'
        '&name=${Provider.of<CoachProvider>(context, listen: false).name}'
        '&country_code=${Provider.of<CoachProvider>(context, listen: false).country_code}'
        '&count=${Provider.of<CoachProvider>(context, listen: false).count}';
    final response = await http.get(url,
        headers: {
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body);
      for(var x in json['items']) {
        CoachModel data=CoachModel.fromJson(x);
        Provider.of<CoachProvider>(context, listen: false).add(data);
      }
    }
    else{
      Navigator.pushNamed(context, '/login');
    }
  }

}