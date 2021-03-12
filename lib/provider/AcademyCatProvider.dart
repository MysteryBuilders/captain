import 'package:captain/model/AcademyCatModel.dart';
import 'package:flutter/foundation.dart';

class AcademyCatProvider extends ChangeNotifier{

  List<AcademyCatModel> _items = [];

  void add(AcademyCatModel item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(AcademyCatModel item) {
    _items.remove(item);
    notifyListeners();
  }

  List<AcademyCatModel> get items {
    return _items;
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }


}