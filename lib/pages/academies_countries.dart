


import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain/api/api_client.dart';
import 'package:captain/helpers/constants.dart';
import 'package:captain/helpers/shared_prefs.dart';
import 'package:captain/model/academies_category_model.dart';
import 'package:captain/model/academy_data.dart';
import 'package:captain/model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

import 'academydetail.dart';
class AcademiesCountriesScreen extends StatefulWidget {
  static String id = 'AcademiesCountriesScreen';
  final  List<Cities> cities;
  final int categoryId;
  final String categoryName;

  AcademiesCountriesScreen({Key key,@required this.cities,@required this.categoryId,@required this.categoryName}): super(key: key);
  @override
  _AcademiesCountriesScreenState createState() => _AcademiesCountriesScreenState();
}

class _AcademiesCountriesScreenState extends State<AcademiesCountriesScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  int cityId =0;
  double width;
  String mBaseImageUrl;
  AcademiesCategoryModel academiesCategoryModel;
  List<Data> mAcademyList = List();
  SharedPref sharedPref = SharedPref();
  CaptinService captinService = CaptinService();
  ScrollController _scrollController = ScrollController();
  int page=2;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {  //Check whether user scrolled to last position




        loadMoreAcademies(page);//load more data


      }
    });
      cityId = widget.cities[0].id;
      getAcademies().then((value){
        isLoading = false;
        academiesCategoryModel = value;
        for(int i =0;i<academiesCategoryModel.payload.data.length;i++){
          mAcademyList.add(academiesCategoryModel.payload.data[i]);
        }
        setState(() {


        });


      });



  }
  Future<String> loadMoreAcademies(int index) async{
    AcademiesCategoryModel model = await captinService.academiesCategory(cityId, index);
    List<Data> academiesRequest =  model.payload.data;

    if(academiesRequest.isNotEmpty){
      page++;

      print('isLoading --> ${isLoading}');
      for(int i =0;i<academiesRequest.length;i++){
        mAcademyList.add(academiesRequest[i]);
      }


      setState(() {

      });



    }


    return 'sucessful';

  }
  Future<AcademiesCategoryModel> getAcademies() async{
    isLoading = true;
    mAcademyList.clear();
    mBaseImageUrl = await sharedPref.readString(KBaseImageUrl);
    AcademiesCategoryModel model = await captinService.academiesCategory(cityId, 1);
    return model;
  }
  @override
  Widget build(BuildContext context) {
     width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
     final double itemWidth = width / 2;
     final double itemHeight = 200.h;
    return Scaffold(

      backgroundColor: Color(0xFFFFFFFF),
      appBar:  AppBar(
        automaticallyImplyLeading:false,
        backgroundColor: Color(0xFFFFFFFF),
        title:  Container(
          alignment: AlignmentDirectional.centerStart,
          child: Text(

            widget.categoryName,

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
      body: Container(
        margin: EdgeInsets.all(10.w),
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,

          controller: _scrollController,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [


            Row(
              children: [

                Expanded(child: Container(

                ),flex: 3,),
                Expanded(
                  flex: 2,
                  child:
                  Container(
                    decoration:
                    BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0.h),
                        color: const Color(0xFFF2C046)
                    ),
                    child:

                    DropDown<Cities>(




                      items: widget.cities,
                      initialValue: widget.cities[0],
                      hint:  Text(widget.cities[0].name ,
                        textAlign: TextAlign.center,
                        style: TextStyle(

                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w600,
                            fontSize: screenUtil.setSp(15)
                        ),),
                      onChanged: (Cities city){
                        
                        cityId = city.id;
                        getAcademies().then((value){
                          isLoading = false;
                          for(int i =0;i<value.payload.data.length;i++){
                            mAcademyList.add(academiesCategoryModel.payload.data[i]);
                          }
setState(() {


});

                        });
                      },
                      customWidgets: widget.cities.map((p) => buildDropDownRow(p)).toList(),
                      isExpanded: true,
                      showUnderline: false,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),
isLoading?Container(
  child: CircularProgressIndicator(),
  alignment: FractionalOffset.center,
):
            mAcademyList.isEmpty?
            Container(
              child: Text('لا يوجد بيانات '),
              alignment: FractionalOffset.center,
            )
                :

            GridView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,


                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio:itemWidth/itemHeight),
                itemCount: mAcademyList.length,


                itemBuilder:(context,index){

                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AcademyDetail(mAcademy: mAcademyList[index])));

                    },
                    child: Padding(padding: EdgeInsets.all(5.w),
                      child: Container(

                        child: Card(
                          elevation: 3.w,
                          child: Container(
                            margin: EdgeInsets.all(10.h),

                            child: Column(
                              children: [
                                Expanded(flex:3 ,
                                    child:CachedNetworkImage(
                                      fit: BoxFit.fill ,
                                      width: itemWidth,


                                      imageUrl: '${mBaseImageUrl}${mAcademyList[index].img}',
                                      placeholder: (context, url) => new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => new Image.asset('images/user.png'),
                                    )
                                ),
                                Expanded(flex: 1,
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child:
                                            Container(
                                              alignment: AlignmentDirectional.centerStart,
                                              child: Text(
                                                mAcademyList[index].name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: screenUtil.setSp(14),
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
                                                        "${mAcademyList[index].price} د.ك ",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: screenUtil.setSp(14),
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
      ),
    );
  }
  Row buildDropDownRow(Cities cities) {
    return Row(


      children: <Widget>[
        Expanded(
          flex: 1,
          child:
          Container(






            alignment: AlignmentDirectional.center,

              child: Text(cities.name ,
              style: TextStyle(
                color: Color(0xFF000000),
                fontWeight: FontWeight.w600,
                fontSize: screenUtil.setSp(15)
              ),)),
        ),

      ],
    );
  }
}
