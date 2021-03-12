/// success : true
/// payload : {"password":351559}

class Reset_password_model {
  bool _success;
  Payload _payload;

  bool get success => _success;
  Payload get payload => _payload;

  Reset_password_model({
      bool success, 
      Payload payload}){
    _success = success;
    _payload = payload;
}

  Reset_password_model.fromJson(dynamic json) {
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

/// password : 351559

class Payload {
  int _password;

  int get password => _password;

  Payload({
      int password}){
    _password = password;
}

  Payload.fromJson(dynamic json) {
    _password = json["password"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["password"] = _password;
    return map;
  }

}