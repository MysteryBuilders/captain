/// success : false
/// message : "Validation Error"
/// payload : {"phone":[" phone تم استخدامه مسبقا."]}

class ErrorProfileModel {
  bool _success;
  String _message;
  Payload _payload;

  bool get success => _success;
  String get message => _message;
  Payload get payload => _payload;

  ErrorProfileModel({
      bool success, 
      String message, 
      Payload payload}){
    _success = success;
    _message = message;
    _payload = payload;
}

  ErrorProfileModel.fromJson(dynamic json) {
    _success = json["success"];
    _message = json["message"];
    _payload = json["payload"] != null ? Payload.fromJson(json["payload"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["message"] = _message;
    if (_payload != null) {
      map["payload"] = _payload.toJson();
    }
    return map;
  }

}

/// phone : [" phone تم استخدامه مسبقا."]

class Payload {
  List<String> _phone;

  List<String> get phone => _phone;

  Payload({
      List<String> phone}){
    _phone = phone;
}

  Payload.fromJson(dynamic json) {
    _phone = json["phone"] != null ? json["phone"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["phone"] = _phone;
    return map;
  }

}