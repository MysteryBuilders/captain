import 'dart:io';

import 'package:captain/component/gradient_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebSiteScreen extends StatefulWidget {
  static String id = 'WebSiteScreen';
  String url;
  String title;

  WebSiteScreen({Key key,@required this.url,@required this.title}): super(key: key);
  @override
  _WebSiteScreenState createState() => _WebSiteScreenState();
}

class _WebSiteScreenState extends State<WebSiteScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  bool isLoading=true;
  InAppWebViewController webView;
  final _key = UniqueKey();

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
              // WebView(
              //   key: _key,
              //   initialUrl: widget.url,
              //   javascriptMode: JavascriptMode.unrestricted,
              //   onPageFinished: (finish) {
              //     setState(() {
              //       isLoading = false;
              //     });
              //   },
              // ),
              InAppWebView(
                initialUrl: widget.url,
                initialHeaders: {},
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      debuggingEnabled: true,
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
                  if (url.contains('')) {


                  }
                },
              ),

              isLoading ? Center( child: CircularProgressIndicator(),)
                  : Stack(),
            ],
          )
          )
        ],
      ),
    );
  }
}
