/// success : true
/// payload : {"user":{"id":11,"name":"mohammed","email":"mm@m.com","email_verified_at":null,"phone":"12345678","whatsapp":null,"facebook":null,"img":null,"full_name":null,"isadmin":0,"type":"0","deleted_at":null,"created_at":"2021-03-02T17:03:35.000000Z","updated_at":"2021-03-03T18:56:28.000000Z","notifications_count":0},"access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9iZXRhLmNhcHRhaW4yMy5jb21cL2FwaVwvdjFcL2xvZ2luIiwiaWF0IjoxNjE0Nzk3ODEyLCJleHAiOjE2NDYzMzM4MTIsIm5iZiI6MTYxNDc5NzgxMiwianRpIjoiaU1nRm0wc05OcWt0N0dKVSIsInN1YiI6MTEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.KOg7YZCieb5rQhaSZrMHwEhSflMa6ndDcOX8Cr4ahsg","token_type":"bearer","expires_in":1645037812}

class Login_model {
  bool _success;
  Payload _payload;

  bool get success => _success;
  Payload get payload => _payload;

  Login_model({
      bool success, 
      Payload payload}){
    _success = success;
    _payload = payload;
}

  Login_model.fromJson(dynamic json) {
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

/// user : {"id":11,"name":"mohammed","email":"mm@m.com","email_verified_at":null,"phone":"12345678","whatsapp":null,"facebook":null,"img":null,"full_name":null,"isadmin":0,"type":"0","deleted_at":null,"created_at":"2021-03-02T17:03:35.000000Z","updated_at":"2021-03-03T18:56:28.000000Z","notifications_count":0}
/// access_token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9iZXRhLmNhcHRhaW4yMy5jb21cL2FwaVwvdjFcL2xvZ2luIiwiaWF0IjoxNjE0Nzk3ODEyLCJleHAiOjE2NDYzMzM4MTIsIm5iZiI6MTYxNDc5NzgxMiwianRpIjoiaU1nRm0wc05OcWt0N0dKVSIsInN1YiI6MTEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.KOg7YZCieb5rQhaSZrMHwEhSflMa6ndDcOX8Cr4ahsg"
/// token_type : "bearer"
/// expires_in : 1645037812

class Payload {
  User _user;
  String _accessToken;
  String _tokenType;
  int _expiresIn;

  User get user => _user;
  String get accessToken => _accessToken;
  String get tokenType => _tokenType;
  int get expiresIn => _expiresIn;

  Payload({
      User user, 
      String accessToken, 
      String tokenType, 
      int expiresIn}){
    _user = user;
    _accessToken = accessToken;
    _tokenType = tokenType;
    _expiresIn = expiresIn;
}

  Payload.fromJson(dynamic json) {
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    _accessToken = json["access_token"];
    _tokenType = json["token_type"];
    _expiresIn = json["expires_in"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    map["access_token"] = _accessToken;
    map["token_type"] = _tokenType;
    map["expires_in"] = _expiresIn;
    return map;
  }

}

/// id : 11
/// name : "mohammed"
/// email : "mm@m.com"
/// email_verified_at : null
/// phone : "12345678"
/// whatsapp : null
/// facebook : null
/// img : null
/// full_name : null
/// isadmin : 0
/// type : "0"
/// deleted_at : null
/// created_at : "2021-03-02T17:03:35.000000Z"
/// updated_at : "2021-03-03T18:56:28.000000Z"
/// notifications_count : 0

class User {
  int _id;
  String _name;
  String _email;
  dynamic _emailVerifiedAt;
  String _phone;
  dynamic _whatsapp;
  dynamic _facebook;
  dynamic _img;
  dynamic _fullName;
  int _isadmin;
  String _type;
  dynamic _deletedAt;
  String _createdAt;
  String _updatedAt;
  int _notificationsCount;

  int get id => _id;
  String get name => _name;
  String get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String get phone => _phone;
  dynamic get whatsapp => _whatsapp;
  dynamic get facebook => _facebook;
  dynamic get img => _img;
  dynamic get fullName => _fullName;
  int get isadmin => _isadmin;
  String get type => _type;
  dynamic get deletedAt => _deletedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get notificationsCount => _notificationsCount;

  User({
      int id, 
      String name, 
      String email, 
      dynamic emailVerifiedAt, 
      String phone, 
      dynamic whatsapp, 
      dynamic facebook, 
      dynamic img, 
      dynamic fullName, 
      int isadmin, 
      String type, 
      dynamic deletedAt, 
      String createdAt, 
      String updatedAt, 
      int notificationsCount}){
    _id = id;
    _name = name;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _phone = phone;
    _whatsapp = whatsapp;
    _facebook = facebook;
    _img = img;
    _fullName = fullName;
    _isadmin = isadmin;
    _type = type;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _notificationsCount = notificationsCount;
}

  User.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _email = json["email"];
    _emailVerifiedAt = json["email_verified_at"];
    _phone = json["phone"];
    _whatsapp = json["whatsapp"];
    _facebook = json["facebook"];
    _img = json["img"];
    _fullName = json["full_name"];
    _isadmin = json["isadmin"];
    _type = json["type"];
    _deletedAt = json["deleted_at"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _notificationsCount = json["notifications_count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["email"] = _email;
    map["email_verified_at"] = _emailVerifiedAt;
    map["phone"] = _phone;
    map["whatsapp"] = _whatsapp;
    map["facebook"] = _facebook;
    map["img"] = _img;
    map["full_name"] = _fullName;
    map["isadmin"] = _isadmin;
    map["type"] = _type;
    map["deleted_at"] = _deletedAt;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["notifications_count"] = _notificationsCount;
    return map;
  }

}