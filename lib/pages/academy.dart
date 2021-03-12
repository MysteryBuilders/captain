import 'package:captain/component/AcademyCatComponent.dart';
import 'package:captain/component/AcademyComponent.dart';
import 'package:captain/component/CoachComponent.dart';
import 'package:captain/component/PlaygroundComponent.dart';
import 'package:captain/component/common/AppBar.dart';
import 'package:captain/component/common/Drawerco.dart';
import 'package:captain/controller/AcademyCatController.dart';
import 'package:captain/controller/AcademyController.dart';
import 'package:captain/controller/CoachController.dart';
import 'package:captain/controller/PlaygroundController.dart';
import 'package:captain/helpers/database.dart';
import 'package:captain/helpers/loader.dart';
import 'package:captain/provider/AcademyCatProvider.dart';
import 'package:captain/provider/AcademyProvider.dart';
import 'package:captain/provider/CoachProvider.dart';
import 'package:captain/provider/PlaygroundProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:provider/provider.dart';

class Academy extends StatefulWidget {
  @override
  _AcademyState createState() => _AcademyState();
}

class _AcademyState extends State<Academy> {
  List data;

  var path=DataBase.urlstatename();

  void initState() {
    super.initState();
    this.getJsonData();
    Provider.of<AcademyCatProvider>(context, listen: false).removeAll();
    AcademyCatController.getdatafeature(context);
    Provider.of<AcademyProvider>(context, listen: false).removeAll();
    AcademyController.getdatafeature(context);
  }

  Future<String> getJsonData() async {
    var url=DataBase.urlstatename()+'api/slide_academy';
    final response = await http.get(url);

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      //    print(convertDataToJson);
      data = convertDataToJson['items'];
    });
    return "Success";
  }

  Widget Image_Carousel () {
    return new Container(
      height: 180,
      child: data == null ? Loader() : new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Stack(
              children: <Widget>[
                Center(
                  child: Container(
                      height: 175,
                      decoration: BoxDecoration(
                        color: const Color(0xfff2f2f2).withOpacity(0.5),

                        borderRadius: BorderRadius.circular(10),

                      ),
                      child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          "${path}/upload/img/thum/${data[index]['img']}",
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 94 / 100,
                          fit: BoxFit.fill,
                        ),

                      )

                  ),
                ),

              ]
          );
        },

        itemCount: data == null ? 0 : data.length,
        itemWidth: MediaQuery
            .of(context)
            .size
            .width * 93 / 100,
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
          child:  app_bar(title: 'الأكاديميات',),
          preferredSize: Size.fromHeight(55)),

      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 3 / 100),
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 14),
            child:  Image_Carousel(),
          ),

          SizedBox(height: 10,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                  'أنواع الرياضات',
                  style: GoogleFonts.cairo(
                    fontSize: 20.0,
                    color: Colors.black,
                    letterSpacing: -0.4,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                )
          ),
          SizedBox(height: 5,),


          Container(
            height: 100,
            child: AcademyCatComponent(),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
             child: Text(
                  'آخر الأكاديميات المضافة',
                  style: GoogleFonts.cairo(
                    fontSize: 20.0,
                    color: Colors.black,
                    letterSpacing: -0.4,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
          ),

          AcademyComponent(),
          SizedBox(height: 10,),
        ],
      ),

    );
  }
}
