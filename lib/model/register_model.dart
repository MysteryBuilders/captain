/// success : true
/// payload : {"user":{"name":"ahmed","phone":"98921189","email":"aa@a.com","isadmin":0,"updated_at":"2021-03-02T17:14:52.000000Z","created_at":"2021-03-02T17:14:52.000000Z","id":12,"notifications_count":0},"access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9iZXRhLmNhcHRhaW4yMy5jb21cL2FwaVwvdjFcL3JlZ2lzdGVyIiwiaWF0IjoxNjE0NzA1MjkyLCJleHAiOjE2NDYyNDEyOTIsIm5iZiI6MTYxNDcwNTI5MiwianRpIjoiRDNVMnR3MWFHUGFURzFsMSIsInN1YiI6MTIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.vu95MI6DMMFSKtWpmKtfrjTHzMIQvCeYzMttPbgQQcQ","token_type":"bearer","expires_in":1644945292}

class Register_model {
  bool _success;
  Payload _payload;

  bool get success => _success;
  Payload get payload => _payload;

  Register_model({
      bool success, 
      Payload payload}){
    _success = success;
    _payload = payload;
}

  Register_model.fromJson(dynamic json) {
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

/// user : {"name":"ahmed","phone":"98921189","email":"aa@a.com","isadmin":0,"updated_at":"2021-03-02T17:14:52.000000Z","created_at":"2021-03-02T17:14:52.000000Z","id":12,"notifications_count":0}
/// access_token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9iZXRhLmNhcHRhaW4yMy5jb21cL2FwaVwvdjFcL3JlZ2lzdGVyIiwiaWF0IjoxNjE0NzA1MjkyLCJleHAiOjE2NDYyNDEyOTIsIm5iZiI6MTYxNDcwNTI5MiwianRpIjoiRDNVMnR3MWFHUGFURzFsMSIsInN1YiI6MTIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.vu95MI6DMMFSKtWpmKtfrjTHzMIQvCeYzMttPbgQQcQ"
/// token_type : "bearer"
/// expires_in : 1644945292

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

/// name : "ahmed"
/// phone : "98921189"
/// email : "aa@a.com"
/// isadmin : 0
/// updated_at : "2021-03-02T17:14:52.000000Z"
/// created_at : "2021-03-02T17:14:52.000000Z"
/// id : 12
/// notifications_count : 0

class User {
  String _name;
  String _phone;
  String _email;
  int _isadmin;
  String _updatedAt;
  String _createdAt;
  int _id;
  int _notificationsCount;

  String get name => _name;
  String get phone => _phone;
  String get email => _email;
  int get isadmin => _isadmin;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;
  int get notificationsCount => _notificationsCount;

  User({
      String name, 
      String phone, 
      String email, 
      int isadmin, 
      String updatedAt, 
      String createdAt, 
      int id, 
      int notificationsCount}){
    _name = name;
    _phone = phone;
    _email = email;
    _isadmin = isadmin;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
    _notificationsCount = notificationsCount;
}

  User.fromJson(dynamic json) {
    _name = json["name"];
    _phone = json["phone"];
    _email = json["email"];
    _isadmin = json["isadmin"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
    _notificationsCount = json["notifications_count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["phone"] = _phone;
    map["email"] = _email;
    map["isadmin"] = _isadmin;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    map["notifications_count"] = _notificationsCount;
    return map;
  }

}