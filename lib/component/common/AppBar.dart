import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class app_bar extends StatefulWidget {
  String title;
  app_bar({this.title});
  @override
  _app_barState createState() => _app_barState();
}

class _app_barState extends State<app_bar> {
  @override
    Widget build(BuildContext context) {
      return AppBar(
        title: Text(
          '${widget.title}',
          style: GoogleFonts.cairo(
            fontSize: 18.0,
            color: Colors.white,
            letterSpacing: -0.36,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [const Color(0xFFF2C046),const Color(0xFFE4AF3D),const Color(0xFFC78B2B)],begin: Alignment.bottomRight,
     end: Alignment.topLeft,),
          ),
        ),
        // gradient: LinearGradient(colors: [const Color(0xFFF2C046),const Color(0xFFE4AF3D),const Color(0xFFC78B2B)],begin: Alignment.bottomRight,
        //   end: Alignment.topLeft,),
        centerTitle: true,
        leading: Container(),
        actions: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child:  Center(
                    child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: 20,)
                )
            ),
          SizedBox(width: 10,),

        ],

      );
    }
}
