import 'dart:io';

import 'package:captain/component/gradient_appbar.dart';
import 'package:captain/provider/model_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'home.dart';
class PaymentScreen extends StatefulWidget {
  static String id = 'WebSiteScreen';
  String url;
  String title;

  PaymentScreen({Key key,@required this.url,@required this.title}): super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  bool isLoading=true;
  final _key = UniqueKey();
  InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.

  }
  @override
  Widget build(BuildContext context) {
    final modelHud = Provider.of<ModelHud>(context,listen: false);

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Expanded(child: GradientAppBar(screenUtil: screenUtil,title:widget.title)
            ,flex: 1,),
          Expanded(flex:9,child:
          ModalProgressHUD(
            inAsyncCall: Provider.of<ModelHud>(context).isLoading,
            child:
            Stack(
              children: <Widget>[
              InAppWebView(

                initialUrlRequest:
                URLRequest(url: Uri.parse(widget.url)),


    initialOptions: InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(


        preferredContentMode: UserPreferredContentMode.MOBILE,

    ),
    ),
    onWebViewCreated: (InAppWebViewController controller) {
    webView = controller;
    },


    onLoadStart: (InAppWebViewController controller, Uri url) {
      modelHud.changeIsLoading(true);
    },
    onLoadStop: (InAppWebViewController controller, Uri url) async {
      modelHud.changeIsLoading(false);
    print(url);
    if (url.toString().contains('merchantTxnId')) {
      Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);


    }
    },
    ),

              ],
            ),
          )
          )
        ],
      ),
    );
  }
}
