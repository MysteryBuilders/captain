import 'package:captain/model/PlaygroundModel.dart';
import 'package:flutter/foundation.dart';

class PlaygroundProvider extends ChangeNotifier{

  List<PlaygroundModel> _items = [];

  int _page=1;
  var _count='';
  var _name='';

  void add(PlaygroundModel item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(PlaygroundModel item) {
    _items.remove(item);
    notifyListeners();
  }

  List<PlaygroundModel> get items {
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

  void removeAll() {
    _items.clear();
    _page = 1;
    _name='';
    _count='';
    notifyListeners();
  }


}