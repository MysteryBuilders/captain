/// success : true
/// payload : {"id":11,"name":"Mello","phone":"54921108","email":"mm@m.com","whatsapp":null,"facebook":"https://www.facebook.com/","full_name":"Ahmed Safaa","notifications_count":2,"img":"1615470655_2119.png","created_at":"02-03-21 05:03 PM","updated_at":"2021-03-11T13:50:55.000000Z"}

class UpdateProfileModel {
  bool _success;
  Payload _payload;

  bool get success => _success;
  Payload get payload => _payload;

  UpdateProfileModel({
      bool success, 
      Payload payload}){
    _success = success;
    _payload = payload;
}

  UpdateProfileModel.fromJson(dynamic json) {
    _success = json["success"];
    _payload = json["payload"] != null ? Payload.fromJson(json["payload"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_payload != null) {
      map["payload"] = _payload.toJson();
    }
    return map;
  }

}

/// id : 11
/// name : "Mello"
/// phone : "54921108"
/// email : "mm@m.com"
/// whatsapp : null
/// facebook : "https://www.facebook.com/"
/// full_name : "Ahmed Safaa"
/// notifications_count : 2
/// img : "1615470655_2119.png"
/// created_at : "02-03-21 05:03 PM"
/// updated_at : "2021-03-11T13:50:55.000000Z"

class Payload {
  int _id;
  String _name;
  String _phone;
  String _email;
  dynamic _whatsapp;
  String _facebook;
  String _fullName;
  int _notificationsCount;
  String _img;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get name => _name;
  String get phone => _phone;
  String get email => _email;
  dynamic get whatsapp => _whatsapp;
  String get facebook => _facebook;
  String get fullName => _fullName;
  int get notificationsCount => _notificationsCount;
  String get img => _img;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Payload({
      int id, 
      String name, 
      String phone, 
      String email, 
      dynamic whatsapp, 
      String facebook, 
      String fullName, 
      int notificationsCount, 
      String img, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _name = name;
    _phone = phone;
    _email = email;
    _whatsapp = whatsapp;
    _facebook = facebook;
    _fullName = fullName;
    _notificationsCount = notificationsCount;
    _img = img;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Payload.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _phone = json["phone"];
    _email = json["email"];
    _whatsapp = json["whatsapp"];
    _facebook = json["facebook"];
    _fullName = json["full_name"];
    _notificationsCount = json["notifications_count"];
    _img = json["img"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["phone"] = _phone;
    map["email"] = _email;
    map["whatsapp"] = _whatsapp;
    map["facebook"] = _facebook;
    map["full_name"] = _fullName;
    map["notifications_count"] = _notificationsCount;
    map["img"] = _img;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}