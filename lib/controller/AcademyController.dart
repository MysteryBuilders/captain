import 'package:captain/helpers/database.dart';
import 'package:captain/model/AcademyModel.dart';
import 'package:captain/provider/AcademyProvider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AcademyController{


  static Future <AcademyModel> getdatafeature(BuildContext context) async{
    var url=DataBase.urlstatename()+'api/academy?page=${Provider.of<AcademyProvider>(context, listen: false).page}'
        '&name=${Provider.of<AcademyProvider>(context, listen: false).name}'
        '&id=${Provider.of<AcademyProvider>(context, listen: false).id}'
        '&city_id=${Provider.of<AcademyProvider>(context, listen: false).city_id}'
        '&cat_id=${Provider.of<AcademyProvider>(context, listen: false).cat_id}'
        '&count=${Provider.of<AcademyProvider>(context, listen: false).count}';
    final response = await http.get(url,
        headers: {
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body);
      for(var x in json['items']) {
        AcademyModel data=AcademyModel.fromJson(x);
        Provider.of<AcademyProvider>(context, listen: false).add(data);
      }
    }
    else{
      Navigator.pushNamed(context, '/login');
    }
  }

}