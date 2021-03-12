import 'package:captain/model/AcademyModel.dart';
import 'package:flutter/foundation.dart';

class AcademyProvider extends ChangeNotifier{

  List<AcademyModel> _items = [];

  int _page=1;
  var _count='';
  var _name='';
  var _cat_id='';
  var _city_id='';
  var _id='';

  void add(AcademyModel item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(AcademyModel item) {
    _items.remove(item);
    notifyListeners();
  }

  List<AcademyModel> get items {
    return _items;
  }

  void increas(){
    _page++;
    notifyListeners();
  }

  get page{
    return _page;
  }
  get name{
    return _name;
  }
  get count{
    return _count;
  }
  get cat_id{
    return _cat_id;
  }
  get city_id{
    return _city_id;
  }
  get id{
    return _id;
  }

  void set_page(){
    _page = 1;
    notifyListeners();
  }

  void set_count(String count){
    _count = count;
    notifyListeners();
  }

  void set_name(String name){
    _name = name;
    notifyListeners();
  }

  void set_city_id(String city_id){
    _city_id = city_id;
    notifyListeners();
  }

  void set_cat_id(String cat_id){
    _cat_id = cat_id;
    notifyListeners();
  }

  void set_id(String id){
    _id = id;
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    _page = 1;
    _name='';
    _count='';
    _cat_id='';
    _city_id='';
    _id='';
    notifyListeners();
  }


}