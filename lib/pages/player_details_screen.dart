import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/player_data.dart';
import 'package:captain/model/player_model.dart';
import 'package:captain/pages/photo_view.dart';
import 'package:captain/pages/question_screen.dart';
import 'package:captain/pages/youtube_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class PlayerDetailsScreen extends StatefulWidget {
  static String id = 'PlayerDetailsScreen';
  PlayerData player;

  PlayerDetailsScreen({Key key,@required this.player}): super(key: key);

  @override
  _PlayerDetailsScreenState createState() => _PlayerDetailsScreenState();
}

class _PlayerDetailsScreenState extends State<PlayerDetailsScreen> {
  ScreenUtil screenUtil = ScreenUtil();

  String mBaseImageUrl ='';
  bool playerInfoVisible = true;
  bool playerMediaVisible = false;
  bool isloggedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getBaseImageUrl().then((value){
    //   setState(() {
    //
    //     // mBaseImageUrl = value;
    //
    //   });
    getBaseImageUrl().then((value) {

      setState(() {
        mBaseImageUrl = value[KBaseImageUrl];
        isloggedIn = value[kKeepMeLoggedIn];

      });


    });




  }
  Future<Map> getBaseImageUrl() async{
    SharedPref sharedPref = SharedPref();
    String imageUrl = await sharedPref.readString(KBaseImageUrl);
    bool isLoggedIn = await sharedPref.readBool(kKeepMeLoggedIn);
    Map map = Map();
    map[KBaseImageUrl] = imageUrl;
    map[kKeepMeLoggedIn] = isLoggedIn;
    return  map;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar:  AppBar(
        automaticallyImplyLeading:false,
        backgroundColor: Color(0xFFFFFFFF),
        title:  Container(
          alignment: AlignmentDirectional.centerStart,
          child: Text(

            'تفاصيل اللاعب',

            style: GoogleFonts.cairo(
              fontSize: screenUtil.setSp(18),
              color: const Color(0xFF002087),
              letterSpacing: -0.36,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),


        actions:[
          Transform.rotate(
            angle: 180 * math.pi / 180,
            child: IconButton(icon: Icon(Icons.arrow_back_ios,color: Color(0xFF002087),size: 25.w,),
                onPressed: (){Navigator.pop(context);}),
          )
        ],
      ),
      body: Stack(
        children: [

          Container(
            margin: EdgeInsets.all(10.w),
            child: mBaseImageUrl==''?
            Container(
              child: CircularProgressIndicator(),
              alignment: FractionalOffset.center,
            ): ListView(
              scrollDirection: Axis.vertical,



              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Container(
                  height: 100.h,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    new Container(
                    width: 90.w,
                    height: 90.w,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,


                    ),child:

                    CachedNetworkImage(
                      imageUrl: mBaseImageUrl+widget.player.img,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 90.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.w)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    ),
                    ),
                      Column(
                        children: [
                          Expanded(
                            flex: 1,

                            child:

                            Container(
                              margin: EdgeInsets.only(bottom: 4.h),

                              decoration: BoxDecoration(
                                color: Color(0xFFDBE4FF),
                                borderRadius: BorderRadius.circular(5.w),


                              ) ,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal:30.0.w),
                                child: Text(
                                  widget.player.cat.name,
                                  style: TextStyle(
                                    color: Color(0xFF002087),
                                    fontSize: screenUtil.setSp(18),
                                    fontWeight: FontWeight.normal


                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(child: Container(
margin: EdgeInsets.only(bottom: 4.h),

                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal:30.0.w),
                              child: Text(
                                widget.player.name,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: screenUtil.setSp(18),
                                    fontWeight: FontWeight.bold


                                ),
                              ),
                            ),
                          ),flex: 1,),
                          Expanded(child:
                          GestureDetector(
                            onTap: (){
                              if(isloggedIn){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionPlayerScreen(player:widget.player,mBaseImageUrl: mBaseImageUrl,)));
                              }else{
                                Navigator.pushNamedAndRemoveUntil(context,'/splash' ,(route) => false);
                              }

                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 4.h),

                              decoration: BoxDecoration(
                                color: Color(0xFFF2C046),
                                borderRadius: BorderRadius.circular(30.w),


                              ) ,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal:30.0.w),
                                child: Text(
                                  'إستفسار',
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: screenUtil.setSp(18),
                                      fontWeight: FontWeight.normal


                                  ),
                                ),
                              ),
                            ),
                          ),flex: 1,),
                        ],
                      )
                    ],

                  ),
                ),
                SizedBox(height: 6.h,),
                Container(
                  height: 46.h,
                  width: width,
                  decoration:  BoxDecoration(
                    color: Color(0xFFE3E3E3),
                    borderRadius: BorderRadius.circular(25.w),



                  ),
                  child: Container(
                    margin: EdgeInsets.all(5.h),


                    child: Row(
                      children: [

                        Expanded(flex: 1,

                            child:
                            GestureDetector(
    onTap: (){
    if(!playerMediaVisible){

    setState(() {
      playerInfoVisible = false;
      playerMediaVisible = true;
      print('playerMediaVisible ${playerMediaVisible}');
    });
    }
    },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsetsDirectional.only(start: 6.h),
                                decoration: playerMediaVisible? BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(25.w),



                                ):BoxDecoration(),
                                child:    Text('صور و فيديوهات '   ,
                                  style: TextStyle(
                                      color: Color(0xFF002087),
                                      fontSize: screenUtil.setSp(16),
                                      fontWeight: FontWeight.w600
                                  ),) ,



                              ),
                            ) ),
                        Expanded(flex: 1,
                            child:
                            GestureDetector(
                              onTap: (){
                                if(!playerInfoVisible){

                                  setState(() {
                                    playerInfoVisible = true;
                                    playerMediaVisible = false;
                                    print('playerInfoVisible ${playerInfoVisible}');
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsetsDirectional.only(end: 6.h),
                                decoration: playerInfoVisible ? BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(25.w),



                                ): BoxDecoration(),
                                child:
                                Text('بيانات اللاعب '   ,
                                style: TextStyle(
                                  color: Color(0xFF002087),
                                  fontSize: screenUtil.setSp(16),
                                  fontWeight: FontWeight.w600
                                ),) ,


                              ),
                            ) ),
                      ],
                    ),
                  ),

                ),
                SizedBox(height: 4.h,),

                Container(
                  child: playerInfoVisible?

                  Container(
                    child: ListView(

                      scrollDirection: Axis.vertical,


                      shrinkWrap: true,
                      physics:  NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          height: 85.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFDBE4FF),
                            borderRadius: BorderRadius.circular(5.w),


                          ) ,
                          child: Container(
                            margin: EdgeInsets.all(10.h),
                            child:
                            Row(
                              children: [
                                Expanded(
                                  flex:1,
                                  child: Column(
                                    children: [
                                      Expanded(flex:1,
                                          child: Row(

                                        children: [
                                          Expanded(
                                            flex:1,
                                            child: Text('المركز',
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontWeight: FontWeight.w600,
                                              fontSize: screenUtil.setSp(12)
                                            ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(widget.player.center,
                                              style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: screenUtil.setSp(12)
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          )
                                        ],
                                      )),
                                      Expanded(flex:1,
                                          child: Row(

                                            children: [
                                              Expanded(
                                                flex:1,
                                                child: Text('القدم',
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: screenUtil.setSp(12)
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(widget.player.foot == '0'?'أيسر':'يمني',
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: screenUtil.setSp(12)
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              )
                                            ],
                                          )),
                                      Expanded(flex:1,
                                          child: Row(

                                            children: [
                                              Expanded(
                                                flex:1,
                                                child: Text('الطول',
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: screenUtil.setSp(12)
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text('${double.tryParse(widget.player.length.toString())/100}م',
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: screenUtil.setSp(12)
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              )
                                            ],
                                          )),

                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex:1,
                                  child: Column(
                                    children: [
                                      Expanded(flex:1,
                                          child: Row(

                                            children: [
                                              Expanded(
                                                flex:1,
                                                child: Text('الجنسية',
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: screenUtil.setSp(12)
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(widget.player.country.countryname,
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: screenUtil.setSp(12)
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              )
                                            ],
                                          )),
                                      Expanded(flex:1,
                                          child: Row(

                                            children: [
                                              Expanded(
                                                flex:1,
                                                child: Text('السن',
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: screenUtil.setSp(12)
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text("${widget.player.age} سنة",
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: screenUtil.setSp(12)
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              )
                                            ],
                                          )),
                                      Expanded(flex:1,
                                          child: Row(

                                            children: [
                                              Expanded(
                                                flex:1,
                                                child: Text('الخبرة',
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: screenUtil.setSp(12)
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text("${widget.player.ex.toString()} سنة ",
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: screenUtil.setSp(12)
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              )
                                            ],
                                          )),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ) ,
                        SizedBox(height: 4.h,),
                        Container(
                          height: 30.h,
                          child: Row(
                            children: [
                              Expanded(child: Container(),flex: 1,),
                              Expanded(child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset('images/goal.png',height: 20.h,width: 20.h,),
                                    Image.asset('images/out_goal.png',height: 20.h,width: 20.h,),
                                    Image.asset('images/yellow_card.png',height: 20.h,width: 20.h,),
                                    Image.asset('images/red_color.png',height: 20.h,width: 20.h,),

                                  ],
                                ),


                              ),flex: 1,)
                            ],
                          ),

                        ),
                        SizedBox(height: 4.h,),
                        ListView.builder(
                            scrollDirection: Axis.vertical,


                            shrinkWrap: true,
                            physics:  NeverScrollableScrollPhysics(),
                            itemCount: widget.player.championships.length,
                            itemBuilder: (context,index){

                              return Column(
                                children: [
                                  Container(
                                    alignment: AlignmentDirectional.center,
                                    height: 46.h,
                                    width: width,
                                    decoration:  BoxDecoration(
                                      color: Color(0xFFDBE4FF),
                                      borderRadius: BorderRadius.circular(5.w),



                                    ),
                                    child:
                                    Text(widget.player.championships[index].groupName,
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: screenUtil.setSp(16),
                                      fontWeight: FontWeight.normal
                                    ),),

                                  ),
                                  SizedBox(height: 5.h,),
                                  Container(
                                    height: 46.h,

                                    child:
                                    Row(
                                      children: [
                                      Expanded(flex:1,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex:1,
                                                child: Text(widget.player.championships[index].year.toString(),
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: screenUtil.setSp(13),
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(widget.player.championships[index].nameClub.toString(),
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: screenUtil.setSp(13),
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ),
                                            ],

                                      )),
                                        Expanded(flex:1,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(widget.player.championships[index].goal.toString(),
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: screenUtil.setSp(13),
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                Text(widget.player.championships[index].goal.toString(),
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: screenUtil.setSp(13),
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                Text(widget.player.championships[index].yellowCard.toString(),
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: screenUtil.setSp(13),
                                                      fontWeight: FontWeight.w600
                                                  ),),Text(widget.player.championships[index].redCard.toString(),
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: screenUtil.setSp(13),
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ],

                                            ))
                                      ],
                                    ) ,
                                  )



                                ],
                              ) ;
                            })



                      ],
                    ),

                  )
                  :Container(
                   child: Row(
                     children: [
                       Expanded(
                           child: Container(
                             margin: EdgeInsets.all(5.h),
                             child: ListView.builder(
                               scrollDirection: Axis.vertical,



                               shrinkWrap: true,
                               physics: const NeverScrollableScrollPhysics(),
                                 itemCount: widget.player.images.length,
                               itemBuilder: (context,index){
                                 return Container(
                                   child: Column(
                                     children: [
                                       Container(
                                         height: 125.h,
                                         width: width/2,
                                         decoration: BoxDecoration(
                                             border: Border.all(
                                               color: Color(0xFF707070),
                                             ),
                                             borderRadius: BorderRadius.all(Radius.circular(5.w))
                                         ),
                                         child:
                                         Row(
                                           children: [
                                             Expanded(
                                               child:
                                               GestureDetector(
                                                 onTap: (){
                                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowImageScreen(mImageUrl:mBaseImageUrl+ widget.player.images[index].img )));

                                                 },
                                                 child:
                                                 CachedNetworkImage(
                                                   imageUrl:mBaseImageUrl+ widget.player.images[index].img,
                                                   imageBuilder: (context, imageProvider) => Container(
                                                       width: width/2,
                                                       height: 125.h,
                                                       decoration: BoxDecoration(
                                                         border: Border.all(
                                                           color: Color(0xFF707070),
                                                         ),
                                                         borderRadius: BorderRadius.all(Radius.circular(5.w)),
                                                         image: DecorationImage(
                                                             image: imageProvider, fit: BoxFit.cover),
                                                       )
                                                   ),


                                                   errorWidget: (context, url, error) => Icon(Icons.image_not_supported),

                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),

                                       ),
                                       SizedBox(height: 6.h,)
                                     ],
                                   ),
                                 );
                               },
                             ),
                           )),
                       Expanded(
                           child: Container(
                             margin: EdgeInsets.all(5.h),
                             child: ListView.builder(
                               scrollDirection: Axis.vertical,



                               shrinkWrap: true,
                               physics: const NeverScrollableScrollPhysics(),
                               itemCount: widget.player.videos.length,
                               itemBuilder: (context,index){
                                 return Container(
                                   child: Column(
                                     children: [
                                       Stack(
                                         children: [
                                           Container(
                                             height: 125.h,
                                             width: width/2,
                                             decoration: BoxDecoration(
                                                 border: Border.all(
                                                   color: Color(0xFF707070),
                                                 ),
                                                 borderRadius: BorderRadius.all(Radius.circular(5.w))
                                             ),
                                             child:
                                             Row(
                                               children: [
                                                 Expanded(
                                                   child:
                                                   GestureDetector(
                                                     onTap:(){
                                                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => YouTubeScreen(youtubeId :widget.player.videos[index].url )));

                                                     },
                                                     child: CachedNetworkImage(
                                                       imageUrl: widget.player.videos[index].thumbnail,
                                                       imageBuilder: (context, imageProvider) => Container(
                                                         width: width/2,
                                                         height: 125.h,
                                                         decoration: BoxDecoration(
                                                             border: Border.all(
                                                               color: Color(0xFF707070),
                                                             ),
                                                             borderRadius: BorderRadius.all(Radius.circular(5.w)),
                                                             image: DecorationImage(
                                                             image: imageProvider, fit: BoxFit.cover),
                                                       )
                                                         ),


                                                       errorWidget: (context, url, error) => Padding(
                                                         padding:  EdgeInsets.all(20.h),
                                                         child: SizedBox(
                                                           height: 70.w,
                                                             width: 70.w,
                                                             child: Icon(Icons.video_settings_outlined,)),
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ],
                                             ),

                                           ),


                                         ],
                                       ),
                                       SizedBox(height: 6.h,)
                                     ],
                                   ),
                                 );
                               },
                             ),
                           ))

                     ],
                   ),
                  )

                )
                

              ],
            ),
          )
        ],
      )

    );
  }
  void _launchURL(String _url) async{
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}
