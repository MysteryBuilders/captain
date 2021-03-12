
class PlayerData {
  int _id;
  String _name;
  String _img;
  String _center;
  int _age;
  int _catId;
  String _countryCode;
  int _ex;
  int _length;
  String _foot;
  int _isStar;
  dynamic _deletedAt;
  String _createdAt;
  String _updatedAt;
  Cat _cat;
  Country _country;
  List<Videos> _videos;
  List<Images> _images;
  List<Championships> _championships;

  int get id => _id;
  String get name => _name;
  String get img => _img;
  String get center => _center;
  int get age => _age;
  int get catId => _catId;
  String get countryCode => _countryCode;
  int get ex => _ex;
  int get length => _length;
  String get foot => _foot;
  int get isStar => _isStar;
  dynamic get deletedAt => _deletedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  Cat get cat => _cat;
  Country get country => _country;
  List<Videos> get videos => _videos;
  List<Images> get images => _images;
  List<Championships> get championships => _championships;

  PlayerData({
    int id,
    String name,
    String img,
    String center,
    int age,
    int catId,
    String countryCode,
    int ex,
    int length,
    String foot,
    int isStar,
    dynamic deletedAt,
    String createdAt,
    String updatedAt,
    Cat cat,
    Country country,
    List<Videos> videos,
    List<Images> images,
    List<Championships> championships}){
    _id = id;
    _name = name;
    _img = img;
    _center = center;
    _age = age;
    _catId = catId;
    _countryCode = countryCode;
    _ex = ex;
    _length = length;
    _foot = foot;
    _isStar = isStar;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _cat = cat;
    _country = country;
    _videos = videos;
    _images = images;
    _championships = championships;
  }

  PlayerData.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _img = json["img"];
    _center = json["center"];
    _age = json["age"];
    _catId = json["cat_id"];
    _countryCode = json["country_code"];
    _ex = json["ex"];
    _length = json["length"];
    _foot = json["foot"];
    _isStar = json["is_star"];
    _deletedAt = json["deleted_at"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _cat = json["cat"] != null ? Cat.fromJson(json["cat"]) : null;
    _country = json["country"] != null ? Country.fromJson(json["country"]) : null;
    if (json["videos"] != null) {
      _videos = [];
      json["videos"].forEach((v) {
        _videos.add(Videos.fromJson(v));
      });
    }
    if (json["images"] != null) {
      _images = [];
      json["images"].forEach((v) {
        _images.add(Images.fromJson(v));
      });
    }
    if (json["championships"] != null) {
      _championships = [];
      json["championships"].forEach((v) {
        _championships.add(Championships.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["img"] = _img;
    map["center"] = _center;
    map["age"] = _age;
    map["cat_id"] = _catId;
    map["country_code"] = _countryCode;
    map["ex"] = _ex;
    map["length"] = _length;
    map["foot"] = _foot;
    map["is_star"] = _isStar;
    map["deleted_at"] = _deletedAt;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_cat != null) {
      map["cat"] = _cat.toJson();
    }
    if (_country != null) {
      map["country"] = _country.toJson();
    }
    if (_videos != null) {
      map["videos"] = _videos.map((v) => v.toJson()).toList();
    }
    if (_images != null) {
      map["images"] = _images.map((v) => v.toJson()).toList();
    }
    if (_championships != null) {
      map["championships"] = _championships.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 9
/// group_name : "كأس العالم للأندية"
/// name_club : "Liverpool"
/// year : 2020
/// goal : 8
/// red_card : 0
/// yellow_card : 1
/// coach_id : 9
/// deleted_at : null
/// created_at : "2021-03-02T18:49:53.000000Z"
/// updated_at : "2021-03-02T18:49:53.000000Z"

class Championships {
  int _id;
  String _groupName;
  String _nameClub;
  int _year;
  int _goal;
  int _redCard;
  int _yellowCard;
  int _coachId;
  dynamic _deletedAt;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get groupName => _groupName;
  String get nameClub => _nameClub;
  int get year => _year;
  int get goal => _goal;
  int get redCard => _redCard;
  int get yellowCard => _yellowCard;
  int get coachId => _coachId;
  dynamic get deletedAt => _deletedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Championships({
    int id,
    String groupName,
    String nameClub,
    int year,
    int goal,
    int redCard,
    int yellowCard,
    int coachId,
    dynamic deletedAt,
    String createdAt,
    String updatedAt}){
    _id = id;
    _groupName = groupName;
    _nameClub = nameClub;
    _year = year;
    _goal = goal;
    _redCard = redCard;
    _yellowCard = yellowCard;
    _coachId = coachId;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Championships.fromJson(dynamic json) {
    _id = json["id"];
    _groupName = json["group_name"];
    _nameClub = json["name_club"];
    _year = json["year"];
    _goal = json["goal"];
    _redCard = json["red_card"];
    _yellowCard = json["yellow_card"];
    _coachId = json["coach_id"];
    _deletedAt = json["deleted_at"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["group_name"] = _groupName;
    map["name_club"] = _nameClub;
    map["year"] = _year;
    map["goal"] = _goal;
    map["red_card"] = _redCard;
    map["yellow_card"] = _yellowCard;
    map["coach_id"] = _coachId;
    map["deleted_at"] = _deletedAt;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}

/// id : 9
/// img : "1614711054_4892.png"
/// coach_id : 9
/// deleted_at : null
/// created_at : "2021-03-02T18:50:54.000000Z"
/// updated_at : "2021-03-02T18:50:54.000000Z"
/// image : "http://beta.captain23.com/upload/img/1614711054_4892.png"

class Images {
  int _id;
  String _img;
  int _coachId;
  dynamic _deletedAt;
  String _createdAt;
  String _updatedAt;
  String _image;

  int get id => _id;
  String get img => _img;
  int get coachId => _coachId;
  dynamic get deletedAt => _deletedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get image => _image;

  Images({
    int id,
    String img,
    int coachId,
    dynamic deletedAt,
    String createdAt,
    String updatedAt,
    String image}){
    _id = id;
    _img = img;
    _coachId = coachId;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _image = image;
  }

  Images.fromJson(dynamic json) {
    _id = json["id"];
    _img = json["img"];
    _coachId = json["coach_id"];
    _deletedAt = json["deleted_at"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["img"] = _img;
    map["coach_id"] = _coachId;
    map["deleted_at"] = _deletedAt;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["image"] = _image;
    return map;
  }

}

/// id : 7
/// url : "https://www.youtube.com/watch?v=0dD-0-4aOVA"
/// videoable_id : 9
/// videoable_type : "App\\Models\\Coach"
/// thumbnail : "https://img.youtube.com/vi/0dD-0-4aOVA/0.jpg"

class Videos {
  int _id;
  String _url;
  int _videoableId;
  String _videoableType;
  String _thumbnail;

  int get id => _id;
  String get url => _url;
  int get videoableId => _videoableId;
  String get videoableType => _videoableType;
  String get thumbnail => _thumbnail;

  Videos({
    int id,
    String url,
    int videoableId,
    String videoableType,
    String thumbnail}){
    _id = id;
    _url = url;
    _videoableId = videoableId;
    _videoableType = videoableType;
    _thumbnail = thumbnail;
  }

  Videos.fromJson(dynamic json) {
    _id = json["id"];
    _url = json["url"];
    _videoableId = json["videoable_id"];
    _videoableType = json["videoable_type"];
    _thumbnail = json["thumbnail"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["url"] = _url;
    map["videoable_id"] = _videoableId;
    map["videoable_type"] = _videoableType;
    map["thumbnail"] = _thumbnail;
    return map;
  }

}

/// countrycode : "ARM"
/// countryname : "Armenia"
/// code : "AM"

class Country {
  String _countrycode;
  String _countryname;
  String _code;

  String get countrycode => _countrycode;
  String get countryname => _countryname;
  String get code => _code;

  Country({
    String countrycode,
    String countryname,
    String code}){
    _countrycode = countrycode;
    _countryname = countryname;
    _code = code;
  }

  Country.fromJson(dynamic json) {
    _countrycode = json["countrycode"];
    _countryname = json["countryname"];
    _code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["countrycode"] = _countrycode;
    map["countryname"] = _countryname;
    map["code"] = _code;
    return map;
  }

}

/// id : 1
/// name : "كرة قدم"
/// img : "1608987489_8567.png"
/// deleted_at : null
/// created_at : "2020-12-26T15:58:10.000000Z"
/// updated_at : "2020-12-26T15:58:10.000000Z"

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