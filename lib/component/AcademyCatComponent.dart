import 'package:captain/helpers/loader.dart';
import 'package:captain/pages/academybycategory.dart';
import 'package:captain/provider/AcademyCatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademyCatComponent extends StatefulWidget {
  @override
  _AcademyCatComponentState createState() => _AcademyCatComponentState();
}

class _AcademyCatComponentState extends State<AcademyCatComponent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AcademyCatProvider>(builder: (context, data, child) {
      var d = data.items.isNotEmpty ? data.items.first : null;
      return d == null ? Loader() :
      ListView.builder(
          itemCount: data == null ? 0 : data.items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap:()=>Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AcademyByCategory(name: '${data.items[index].name}',))),
              child: Container(
                  width: 90,
                  child:
                  Column(children: <Widget>[

                    Container(
                      alignment: Alignment.center,
                      width: 66.0,
                      height: 54.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.0),
                        color: const Color(0xFF002087),
                      ),
                      child: Container(
                        width: 33.59,
                        height: 33.59,
                        child: Image.network(
                          '${data.items[index].img}', fit: BoxFit.cover,),
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(top: 5),
                        child: Wrap(
                          children: [
                            Text(
                              '${data.items[index].name}',
                              style: GoogleFonts.cairo(
                                fontSize: 11.0,
                                color: const Color(0xFF002087),
                                letterSpacing: -0.28,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )


                    )
                  ],
                  )
              ),
            );
          }
      );
    }
    );
  }
  }