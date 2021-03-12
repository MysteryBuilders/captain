import 'package:captain/helpers/database.dart';
import 'package:captain/model/AcademyCatModel.dart';
import 'package:captain/provider/AcademyCatProvider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AcademyCatController{


  static Future <AcademyCatModel> getdatafeature(BuildContext context) async{
    var url=DataBase.urlstatename()+'api/academy';
    final response = await http.get(url,
        headers: {
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body);
      for(var x in json['items']) {
        AcademyCatModel data=AcademyCatModel.fromJson(x);
        Provider.of<AcademyCatProvider>(context, listen: false).add(data);
      }
    }
    else{
      Navigator.pushNamed(context, '/login');
    }
  }

}