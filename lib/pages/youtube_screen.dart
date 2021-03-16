import 'package:captain/component/gradient_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class YouTubeScreen extends StatefulWidget {
  static String id = 'YouTubeScreen';
   String youtubeId;
  YouTubeScreen({Key key,@required this.youtubeId}): super(key: key);
  @override
  _YouTubeScreenState createState() => _YouTubeScreenState();
}

class _YouTubeScreenState extends State<YouTubeScreen> {

  YoutubePlayerController _controller;



  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    String videoId;
    videoId = YoutubePlayer.convertUrlToId(widget.youtubeId);
     _controller = YoutubePlayerController(
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,


      ),
      initialVideoId: videoId,

    );
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),

      body:
      Column(
        children: [
          Expanded(child: GradientAppBar(screenUtil: screenUtil,title:'الفيديوهات')
            ,flex: 1,),
          Expanded(
            flex: 9,
            child:
            Container(
              child: Center(
                child: YoutubePlayer(controller: _controller,
                showVideoProgressIndicator: true,


   ),
              ),
            ),
          ),
        ],
      ),
    );

  }
  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

}
