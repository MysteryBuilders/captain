import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain/api/api_client.dart';
import 'package:captain/component/gradient_appbar.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NotificationScreen extends StatefulWidget {
  static String id = 'NotificationScreen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  NotificationModel notificationModel;
  CaptinService captinService = CaptinService();
  List<Data> notificationList = List();
  ScrollController _scrollController = ScrollController();
  SharedPref mSharedPref = SharedPref();
  bool shouldLoadMore = true;
  String mBaseImageUrl ="";
  int index = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifications().then((value){
      notificationModel = value;
      for(int i =0;i<notificationModel.payload.data.length;i++){
        notificationList.add(notificationModel.payload.data[i]);

      }
      setState(() {

      });

    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {




        loadMoreNotifcations(index);//load more data

      }
    });
  }
  Future<String> loadMoreNotifcations(int index) async{
    NotificationModel model = await captinService.notifications(index);
    List<Data> academiesRequest =  model.payload.data;

    if(academiesRequest.isNotEmpty){
      index++;



      for(int i = 0;i<academiesRequest.length;i++){
        notificationList.add(academiesRequest[i]);
      }
      setState(() {

      });





    }


    return 'sucessful';

  }
  Future<NotificationModel> getNotifications() async{
    mBaseImageUrl = await mSharedPref.readString(KBaseImageUrl);
    NotificationModel model = await captinService.notifications(1);
    return model;

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Expanded(child: GradientAppBar(screenUtil: screenUtil,title:'الإشعارات')
            ,flex: 1,),
          Expanded(flex: 9,
              child: notificationList.isEmpty  ?
              Container(
                child: CircularProgressIndicator(),
                alignment: FractionalOffset.center,
              ):

              Container(
                margin: EdgeInsets.all(10.w),

                child: ListView.separated(
                  padding: EdgeInsets.zero,


                  itemCount: notificationList.length,
                  scrollDirection: Axis.vertical,

                  controller: _scrollController,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context,index){
                  return Container(width: width,
                  height: 10.h,);
                  },
                  itemBuilder: (context,index){
                  return  Container(
                    height: 70.h,
                    width: width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0.w),
                      ),
                      shadowColor: Color(0xAAAAAAAA),
                      elevation: 2.w,
                      child: Container(
                        margin: EdgeInsets.all(10.h),
                        child: Row(
                          children: [
                            Expanded(flex: 1,
                                child:  CachedNetworkImage(
                                  width: 50.h,
                                  height: 50.h,

                                  imageUrl:'${mBaseImageUrl}${notificationList[index].url}',
                                  imageBuilder: (context, imageProvider) => Container(
                                      width: 50.h,
                                      height: 50.h,

                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,

                                        image: DecorationImage(
                                            image: imageProvider),
                                      )
                                  ),
                                  placeholder: (context, url) =>
                                      Center(
                                        child: SizedBox(
                                            height: 30.h,
                                            width: 30.h,
                                            child: new CircularProgressIndicator()),
                                      ),


                                  errorWidget: (context, url, error) => Icon(Icons.image_not_supported,size: 50.h,),

                                ),
                            ),
                            Expanded(flex: 4,
                                child:
                                Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(notificationList[index].msg,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: screenUtil.setSp(16),
                                        color: Color(0xFF717171)
                                    ),

                                  ) ,
                                ))
                          ],
                        ),

                      ),
                    ),
                  );
                  },

                ),
              )
          )

        ],
      ),
    );
  }
}
