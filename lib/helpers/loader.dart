import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  Color col=Color(0xff199b97);
  Loader({this.col});
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            alignment: AlignmentDirectional.center,
            child: new Container(
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: new SizedBox(
                      height: 40.0,
                      width: 40.0,
                      child: new CircularProgressIndicator(
                        backgroundColor: widget.col,
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
