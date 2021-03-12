import 'package:captain/component/AcademyComponent.dart';
import 'package:captain/controller/AcademyCatController.dart';
import 'package:captain/controller/AcademyController.dart';
import 'package:captain/helpers/database.dart';
import 'package:captain/model/CityModel.dart';
import 'package:captain/provider/AcademyCatProvider.dart';
import 'package:captain/provider/AcademyProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:async/async.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class AcademyByCategory extends StatefulWidget {
  String name;
  AcademyByCategory({this.name});
  @override
  _AcademyByCategoryState createState() => _AcademyByCategoryState();
}

class _AcademyByCategoryState extends State<AcademyByCategory> {
  int _value=0;
  List<CityModel> city=[];
  Future getdatafeature(BuildContext context) async{
    setState(() {
      city.add(CityModel(id: 0,name: 'المحافظات'));
    });
    var url=DataBase.urlstatename()+'api/city';
    final response = await http.get(url,
        headers: {
          "Accept": "application/json",
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body);
      for(var x in json['items']) {
        CityModel data=CityModel.fromJson(x);
        setState(() {
          city.add(data);
        });

      }
      print(city);
    }
    else{
      Navigator.pushNamed(context, '/login');
    }
  }
  @override
  void initState() {
    super.initState();
    getdatafeature(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 3 / 100),
        children: [
          SizedBox(height: 30,),
          Row(
            children: [
              SizedBox(width: 7,),
              Text(
                '${widget.name}',
                style: GoogleFonts.cairo(
                  fontSize: 18.0,
                  color: const Color(0xFF002087),
                  letterSpacing: -0.36,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(child: SizedBox()),
              IconButton(icon: Icon(Icons.arrow_back_sharp,color: Colors.black,size: 19,),
                  onPressed: (){Navigator.pop(context);}
              )
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Container(
                  height: 31.0,
                  width: MediaQuery.of(context).size.width*35/100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0xFFF2C046),
                  ),
                  child:Center(
                      child: new Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.grey[200],
                        ),
                        child:
                        DropdownButton(
                            value: _value,
                            items:  city.map((map){
                              return DropdownMenuItem(
                                child: Text(
                                  '${map.name}',
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    letterSpacing: -0.3,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                value: map.id,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                              });
                              Provider.of<AcademyProvider>(context, listen: false).removeAll();
                              Provider.of<AcademyProvider>(context, listen: false).set_city_id('${value}');
                              AcademyController.getdatafeature(context);
                            }),
                      )
                  )

              ),
              SizedBox(width: 7,),

            ],
          ),
          SizedBox(height: 10,),
          AcademyComponent(),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
