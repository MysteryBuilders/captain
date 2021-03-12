import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain/api/api_client.dart';
import 'package:captain/component/gradient_appbar.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/academies_model.dart';
import 'package:captain/model/academy_data.dart';
import 'package:captain/model/city_main.dart';
import 'package:captain/model/main_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'academies_countries.dart';
import 'academydetail.dart';

class AcademiesScreen extends StatefulWidget {
  static String id = 'AcademiesScreen';
  final  List<Cities> cities;
  AcademiesScreen({Key key,@required this.cities}): super(key: key);
  @override
  _AcademiesScreenState createState() => _AcademiesScreenState();
}


class _AcademiesScreenState extends State<AcademiesScreen> {
  AcademiesModel academiesModel = null;
 Academies academiesList = null;
  bool shouldLoadMore = true;
  int _current = 0;
  ScreenUtil screenUtil = ScreenUtil();
  int page =2;
  bool isLoading = false;
  CaptinService captinService = CaptinService();
  SharedPref mSharedPrefs = SharedPref();
  String mBaseImageUrl='';
  List<Data> mAcademeiesList = List();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   getAcademies().then((value){
     academiesModel = value;
     setState(() {
       academiesList = value.payload.academies ;
       mAcademeiesList = value.payload.academies.data;
       print(academiesModel);

     });

   });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {  //Check whether user scrolled to last position




            loadMoreAcademies(page);//load more data


      }
    });


  }
  @override
  void dispose() {

    super.dispose();
  }

  Future<AcademiesModel> getAcademies() async{
    mBaseImageUrl = await mSharedPrefs.readString(KBaseImageUrl);
    academiesModel = await captinService.academies(1);
   return academiesModel;

  }

  Future<String> loadMoreAcademies(int index) async{
   AcademiesModel model = await captinService.academies(index);
    List<Data> academiesRequest =  model.payload.academies.data;

    if(academiesRequest.isNotEmpty){
page++;

        print('isLoading --> ${isLoading}');
        for(int i =0;i<academiesRequest.length;i++){
          mAcademeiesList.add(academiesRequest[i]);
        }


setState(() {

});
        isLoading = false;


    }


    return 'sucessful';

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final double itemWidth = width / 2;
    final double itemHeight = 240.h;
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: GradientAppBar(screenUtil: screenUtil,title:'الأكاديميات')
          ,flex: 1,),
          Expanded(
            flex: 9,

            child:

          Container(
            margin: EdgeInsets.all(20.w),
            child:academiesList == null?  Container(
              child: CircularProgressIndicator(),
              alignment: FractionalOffset.center,
            ):
            ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,

              controller: _scrollController,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),


              children: [
                Stack(
                  children: [
                    CarouselSlider(

                      options: CarouselOptions(
                          autoPlay: true,

                          viewportFraction: 1.0,
                          enlargeCenterPage: false,


                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }
                      ),
                      items: academiesModel.payload.slides.map((item) =>
                          Stack(
                            children: [
                              Card(
                                elevation: 2.h,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0.w),
                                ),
                                child: Container(

                                  child: ClipRRect(

                                    borderRadius: BorderRadius.circular(10.w),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill ,
                                      width: width,
                                      height: 600.h,


                                      imageUrl: '${mBaseImageUrl}${item.img}',
                                      placeholder: (context, url) => Center(
                                        child: SizedBox(height: 50.h,
                                            width: 50.h,
                                            child: new CircularProgressIndicator()),
                                      ),
                                      errorWidget: (context, url, error) => new Image.asset('images/user.png'),
                                    ),
                                  ),
                                )

                                // Container(
                                //   decoration: BoxDecoration(
                                //     color: Color(0xFF002087),
                                //     borderRadius: BorderRadius.circular(20.0.w),
                                //
                                //   ) ,
                                //
                                //
                                //   child: Image.network(
                                //
                                //
                                //     mBaseImageUrl+ item.img, fit: BoxFit.fitWidth,
                                //     height: 600.h,),
                                //   width: width,
                                // ),
                              ),


                            ] ,
                          )
                      ).toList(),


                    ),
                    Positioned.directional
                      (textDirection :  Directionality.of(context),
                      bottom: 10.h,
                      start: 0,
                      end: 0,



                      child:
                      Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: academiesModel.payload.slides.map((item) {
                          int  currentIndex = academiesModel.payload.slides.indexOf(item);
                          return
                            Container(
                            width: 8.0.w,
                            height: 8.0.h,
                            margin: EdgeInsets.symmetric(vertical: 10.0.w, horizontal: 2.0.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == currentIndex
                                  ? Color(0xFFFFEEC4)
                                  : Color(0xFFF2C046),
                            ),
                          );
                        }).toList(),
                      ),)
                  ],
                ),

                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 10.h),
                  child:
                  Text('أنواع الرياضات',style:
                    TextStyle(color: Color(0xFF000000),
                    fontSize: screenUtil.setSp(20,allowFontScalingSelf: true),
                    fontWeight: FontWeight.bold),),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AcademiesCountriesScreen(cities: widget.cities,categoryId: academiesModel.payload.academies.data[0].cat.id,categoryName:academiesModel.payload.academies.data[0].cat.name ,)));

                      },
                      child: Container(
                        height: 100.h,
                        width: width/4,
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Expanded(
                                flex:4,
                                child:
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF002087),
                                    borderRadius: BorderRadius.circular(20.0.w),

                                  ) ,
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    child:   CachedNetworkImage(
                                      height: 70.h,
                                      width: 70.h ,


                                      imageUrl: '${mBaseImageUrl}${academiesModel.payload.academies.data[0].cat.img}',
                                      placeholder: (context, url) =>
                                          Container(

                                            child: Center(
                                        child: SizedBox(height: 50.h,
                                              width: 50.w,
                                              child: new CircularProgressIndicator()),
                                      ),
                                          ),
                                      errorWidget: (context, url, error) => new Image.asset('images/user.png'),
                                    ),
                                  ),

                            )
                            ),
                            Expanded(flex: 1,
                                child:Center(
                                  child:
                                  Text(
                                      academiesModel.payload.academies.data[0].cat.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenUtil.setSp(14,allowFontScalingSelf: true),
                                      color: Color(0xFF002087)
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),

                Text('آخر الأكاديميات المضافة',style:
                TextStyle(color: Color(0xFF000000),
                    fontSize: screenUtil.setSp(20,allowFontScalingSelf: true),
                    fontWeight: FontWeight.bold),),
                SizedBox(height: 10.h,),


                GridView.builder(
                    scrollDirection: Axis.vertical,


                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
    childAspectRatio:itemWidth/itemHeight),
                  itemCount: mAcademeiesList.length,


               itemBuilder:(context,index){

                     return GestureDetector(
                       onTap: (){
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => AcademyDetail(mAcademy: mAcademeiesList[index])));

                       },
                       child: Padding(padding: EdgeInsets.all(5.w),
                        child: Container(


                          child: Card(
                            elevation: 1.w,
                            child: Container(

                              margin: EdgeInsets.all(4.h),

                              child: Column(
                                children: [
                                  Expanded(flex:4 ,
                                      child:CachedNetworkImage(
                                        fit: BoxFit.cover ,
                                        width: itemWidth,


                                        imageUrl: '${mBaseImageUrl}${mAcademeiesList[index].img}',
                                        placeholder: (context, url) => Center(
                                          child:
                                          Center(
                                            child: SizedBox(
                                              height: 50.h,
                                              width: 50.h,
                                              child: new
                                              CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => new Image.asset('images/user.png'),
                                      )
                                  ),
                                  Expanded(flex: 2,
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child:
                                              Container(
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Text(
                                                  mAcademeiesList[index].name,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: screenUtil.setSp(14,allowFontScalingSelf: true),
                                                      color: Color(0xFF002087)
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Expanded(flex: 3,
                                                      child:
                                                      Container(
                                                        alignment: AlignmentDirectional.centerStart,
                                                        child: Text(
                                                          "${mAcademeiesList[index].price} د.ك ",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: screenUtil.setSp(14,allowFontScalingSelf: true),
                                                              color: Color(0xFF717171)
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ))
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





            ),
          ))

        ],
      ),
    );
  }

}
