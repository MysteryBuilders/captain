import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain/component/gradient_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
class ShowImageScreen extends StatefulWidget {
  static String id = 'ShowImageScreen';
  String mImageUrl;
  ShowImageScreen({Key key,@required this.mImageUrl}): super(key: key);
  @override
  _ShowImageScreenState createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    //Here is the question: how to get the width of this imageProvider?

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Expanded(child: GradientAppBar(screenUtil: screenUtil,title:'الصور')
            ,flex: 1,),
          Expanded(
            flex: 9,
            child: Container(
              color: Color(0xFFFFFFFF),
              child: CachedNetworkImage(
                  imageUrl: widget.mImageUrl,
                  imageBuilder: (context, imageProvider) => PhotoView(

                    imageProvider: imageProvider,

                  ),
                errorWidget: (context, url, error) => Icon(Icons.image_not_supported),
              ),
            ),
          ),

        ],

      ),
    );
  }
}
