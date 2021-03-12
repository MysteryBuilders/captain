import 'package:captain/model/CoachModel.dart';
import 'package:flutter/foundation.dart';

class CoachProvider extends ChangeNotifier{

  List<CoachModel> _items = [];

  int _page=1;
  var _count='';
  var _name='';
  var _country_code='';

  void add(CoachModel item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(CoachModel item) {
    _items.remove(item);
    notifyListeners();
  }

  List<CoachModel> get items {
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
  get country_code{
    return _country_code;
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

  void set_country_code(String country_code){
    _country_code = country_code;
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    _page = 1;
    _name='';
    _count='';
    _country_code='';
    notifyListeners();
  }


}