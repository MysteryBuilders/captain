
import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain/api/api_client.dart';
import 'package:captain/component/gradient_appbar.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/player_data.dart';
import 'package:captain/model/player_model.dart';
import 'package:captain/pages/player_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerScreen extends StatefulWidget {
  static String id = 'PlayerScreen';

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  CaptinService captinService = CaptinService();
  PlayerModel playerModel = null;
  SharedPref mSharedPrefs = SharedPref();
  String mBaseImageUrl='';
  int index =2;
  bool isLoading = false;
  List<PlayerData> mPlayersList = List();
  ScrollController _scrollController = ScrollController();
  bool shouldLoadMore = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlayers().then((value){
      playerModel = value;
      setState(() {

        mPlayersList  = value.payload.data;
        print(mPlayersList);

      });

    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {




            loadMoreAcademies(index);//load more data

      }
    });

  }
  Future<String> loadMorePlayers(int index) async{
    PlayerModel model = await captinService.players(index);
    List<PlayerData> academiesRequest =  model.payload.data;

    if(academiesRequest.isNotEmpty){

      isLoading   = false;
      print('isLoading --> ${isLoading}');
      mPlayersList.addAll(academiesRequest);


      isLoading = false;


    }


    return 'sucessful';

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final double itemWidth = width / 2;
    final double itemHeight = 230.h;
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: GradientAppBar(screenUtil: screenUtil,title:'اللاعبين و المدربين')
            ,flex: 1,),
    Expanded(
    flex: 9,

    child:Container(
      margin: EdgeInsets.all(10.w),
      child: playerModel == null?
      Container(
        child: CircularProgressIndicator(),
        alignment: FractionalOffset.center,
      )
          :ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,

        controller: _scrollController,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),

        children: [
          Text('آخر الملفات المضافة',style:
          TextStyle(color: Color(0xFF000000),
              fontSize: screenUtil.setSp(20),
              fontWeight: FontWeight.bold),),
          SizedBox(height: 10.h,),
          GridView.builder(
              scrollDirection: Axis.vertical,


              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                  childAspectRatio:itemWidth/itemHeight),
              itemCount: mPlayersList.length,


              itemBuilder:(context,index){

                return
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlayerDetailsScreen(player: mPlayersList[index])));

                    },
                    child: Padding(padding: EdgeInsets.all(5.w),
                    child: Container(

                      child: Card(
                        elevation: 1.w,
                        child: Container(
                          margin: EdgeInsets.all(10.h),

                          child: Column(
                            children: [
                              Expanded(flex:5 ,
                                  child:
                                  CachedNetworkImage(
                                    width: itemWidth,
                                    imageUrl:'${mBaseImageUrl}${mPlayersList[index].img}',
                                    imageBuilder: (context, imageProvider) => Container(
                                    width: itemWidth,

                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,

                                          image: DecorationImage(
                                              image: imageProvider),
                                        )
                                    ),
                                      placeholder: (context, url) =>
                                          Center(
                                            child: SizedBox(
                                        height: 50.h,
                                            width: 50.h,
                                            child: new CircularProgressIndicator()),
                                          ),


                                    errorWidget: (context, url, error) => Icon(Icons.image_not_supported),

                                  ),
                                  // CachedNetworkImage(
                                  //   fit: BoxFit.cover ,
                                  //   width: itemWidth,
                                  //
                                  //
                                  //   imageUrl: '${mBaseImageUrl}${mPlayersList[index].img}',
                                  //   placeholder: (context, url) =>
                                  //       Center(
                                  //         child: SizedBox(
                                  //     height: 50.h,
                                  //         width: 50.h,
                                  //         child: new CircularProgressIndicator()),
                                  //       ),
                                  //   errorWidget: (context, url, error) => new Image.asset('images/user.png'),
                                  // )
                              ),
                              Expanded(flex: 5,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child:
                                          Container(
                                            alignment: AlignmentDirectional.center,
                                            child: Text(
                                              mPlayersList[index].name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: screenUtil.setSp(14),
                                                  color: Color(0xFF000000)
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Expanded(flex: 2,
                                                  child:
                                                  Container(
                                                    alignment: AlignmentDirectional.centerStart,
                                                    child: Text(
                                                      "الصنف:",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: screenUtil.setSp(13),
                                                          color: Color(0xFF002087)
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(flex: 2,
                                                  child:
                                                  Container(
                                                    alignment: AlignmentDirectional.centerStart,
                                                    child: Text(
                                                      mPlayersList[index].cat.name,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: screenUtil.setSp(13),
                                                          color: Color(0xFF717171)
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child:
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                                              color: Color(0xFFF2C046)
                                            ),
                                            alignment: AlignmentDirectional.center,
                                            child: Text(
                                              mPlayersList[index].country.countryname,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: screenUtil.setSp(14),
                                                  color: Color(0xFF000000)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),


                                  ))
                            ],
                          ),


                        ),

                      ),
                    ),),
                  );
              }



          )
        ],
      )
    )
    ),
        ],
      ),

    );
  }
  @override
  void dispose() {

    super.dispose();
  }

  Future<String> loadMoreAcademies(int index) async{
    PlayerModel model = await captinService.players(index);
    List<PlayerData> academiesRequest =  model.payload.data;

    if(academiesRequest.isNotEmpty){
      index++;

      isLoading = false;
      print('isLoading --> ${isLoading}');
     for(int i = 0;i<academiesRequest.length;i++){
       mPlayersList.add(academiesRequest[i]);
     }
      setState(() {

      });





    }


    return 'sucessful';

  }
  Future<PlayerModel> getPlayers() async{
    mBaseImageUrl = await mSharedPrefs.readString(KBaseImageUrl);
    playerModel = await captinService.players(1);
    return playerModel;

  }
}
