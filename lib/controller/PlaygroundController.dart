import 'package:captain/helpers/database.dart';
import 'package:captain/model/PlaygroundModel.dart';
import 'package:captain/provider/PlaygroundProvider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PlaygroundController{


  static Future <PlaygroundModel> getdatafeature(BuildContext context) async{
    var url=DataBase.urlstatename()+'api/playground?page=${Provider.of<PlaygroundProvider>(context, listen: false).page}'
        '&name=${Provider.of<PlaygroundProvider>(context, listen: false).name}'
        '&count=${Provider.of<PlaygroundProvider>(context, listen: false).count}';
    final response = await http.get(url,
        headers: {
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body);
      for(var x in json['items']) {
        PlaygroundModel data=PlaygroundModel.fromJson(x);
        Provider.of<PlaygroundProvider>(context, listen: false).add(data);
      }
    }
    else{
      Navigator.pushNamed(context, '/login');
    }
  }

}