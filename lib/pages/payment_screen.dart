import 'dart:io';

import 'package:captain/component/gradient_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Expanded(child: GradientAppBar(screenUtil: screenUtil,title:widget.title)
            ,flex: 1,),
          Expanded(flex:9,child:Stack(
            children: <Widget>[
            InAppWebView(
            initialUrl: widget.url,
    initialHeaders: {},
    initialOptions: InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
    debuggingEnabled: true,
        preferredContentMode: UserPreferredContentMode.MOBILE,
    userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0"
    ),
    ),
    onWebViewCreated: (InAppWebViewController controller) {
    webView = controller;
    },
    onLoadStart: (InAppWebViewController controller, String url) {
    isLoading = false;
    },
    onLoadStop: (InAppWebViewController controller, String url) async {
    isLoading = true;
    print(url);
    if (url.contains('merchantTxnId')) {
      Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);


    }
    },
    ),

            ],
          )
          )
        ],
      ),
    );
  }
}
