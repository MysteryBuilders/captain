class Data {
  int _id;
  String _name;
  String _img;
  String _address;
  String _timeWork;
  String _content;
  int _price;
  int _priceN;
  int _catId;
  int _cityId;
  double _lat;
  double _lng;
  int _phone;

  String _gender;
  dynamic _deletedAt;
  String _createdAt;
  String _updatedAt;
  Cat _cat;
  City _city;
  List<Images> _images;

  int get id => _id;
  int get phone =>_phone;
  String get name => _name;
  String get img => _img;
  String get address => _address;
  String get timeWork => _timeWork;
  String get content => _content;
  double get lat =>_lat;
  double get lng =>_lng;
  int get price => _price;
  int get priceN => _priceN;
  int get catId => _catId;
  int get cityId => _cityId;
  String get gender => _gender;
  dynamic get deletedAt => _deletedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  Cat get cat => _cat;
  City get city => _city;
  List<Images> get images => _images;

  Data({
    int id,
    String name,
    String img,
    String address,
    String timeWork,
    String content,
    int price,
    int priceN,
    int catId,
    int cityId,
    String gender,
    dynamic deletedAt,
    String createdAt,
    String updatedAt,
    Cat cat,
    City city,
    List<Images> images,
  double lat,
  double lng,
  int phone}){
    _id = id;
    _phone = phone;
    _name = name;
    _lat = lat;
    _lng = lng;
    _img = img;
    _address = address;
    _timeWork = timeWork;
    _content = content;
    _price = price;
    _priceN = priceN;
    _catId = catId;
    _cityId = cityId;
    _gender = gender;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _cat = cat;
    _city = city;
    _images = images;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _phone =json['phone'];
    _name = json["name"];
    _img = json["img"];
    _lat = json['lat'];
    _lng =json['lng'];
    _address = json["address"];
    _timeWork = json["time_work"];
    _content = json["content"];
    _price = json["price"];
    _priceN = json["price_n"];
    _catId = json["cat_id"];
    _cityId = json["city_id"];
    _gender = json["gender"];
    _deletedAt = json["deleted_at"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _cat = json["cat"] != null ? Cat.fromJson(json["cat"]) : null;
    _city = json["city"] != null ? City.fromJson(json["city"]) : null;
    if (json["images"] != null) {
      _images = [];
      json["images"].forEach((v) {
        _images.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map['phone']=_phone;
    map['lat']=_lat;
    map['lng'] =_lng;
    map["name"] = _name;
    map["img"] = _img;
    map["address"] = _address;
    map["time_work"] = _timeWork;
    map["content"] = _content;
    map["price"] = _price;
    map["price_n"] = _priceN;
    map["cat_id"] = _catId;
    map["city_id"] = _cityId;
    map["gender"] = _gender;
    map["deleted_at"] = _deletedAt;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_cat != null) {
      map["cat"] = _cat.toJson();
    }
    if (_city != null) {
      map["city"] = _city.toJson();
    }
    if (_images != null) {
      map["images"] = _images.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 4
/// img : "1614783478_6005.jpg"
/// academy_id : 13
/// created_at : "2021-03-03T14:57:58.000000Z"
/// updated_at : "2021-03-03T14:57:58.000000Z"

class Images {
  int _id;
  String _img;
  int _academyId;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get img => _img;
  int get academyId => _academyId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Images({
    int id,
    String img,
    int academyId,
    String createdAt,
    String updatedAt}){
    _id = id;
    _img = img;
    _academyId = academyId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Images.fromJson(dynamic json) {
    _id = json["id"];
    _img = json["img"];
    _academyId = json["academy_id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["img"] = _img;
    map["academy_id"] = _academyId;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}
class City {
  int _id;
  String _name;
  String _img;
  dynamic _deletedAt;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get name => _name;
  String get img => _img;
  dynamic get deletedAt => _deletedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  City({
    int id,
    String name,
    String img,
    dynamic deletedAt,
    String createdAt,
    String updatedAt}){
    _id = id;
    _name = name;
    _img = img;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  City.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _img = json["img"];
    _deletedAt = json["deleted_at"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["img"] = _img;
    map["deleted_at"] = _deletedAt;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}

/// id : 1
/// name : "كرة قدم"
/// img : "1608987363_8280.png"
/// deleted_at : null
/// created_at : "2020-12-26T15:56:04.000000Z"
/// updated_at : "2020-12-26T15:56:04.000000Z"

class Cat {
  int _id;
  String _name;
  String _img;
  dynamic _deletedAt;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get name => _name;
  String get img => _img;
  dynamic get deletedAt => _deletedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Cat({
    int id,
    String name,
    String img,
    dynamic deletedAt,
    String createdAt,
    String updatedAt}){
    _id = id;
    _name = name;
    _img = img;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Cat.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _img = json["img"];
    _deletedAt = json["deleted_at"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["img"] = _img;
    map["deleted_at"] = _deletedAt;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}