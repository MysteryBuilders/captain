class CityMain {
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

  CityMain({
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

  CityMain.fromJson(dynamic json) {
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