/// success : false
/// message : "Validation Error"
/// payload : [" phone تم استخدامه مسبقا."," email تم استخدامه مسبقا."]

class Register_error {
  bool _success;
  String _message;
  List<String> _payload;

  bool get success => _success;
  String get message => _message;
  List<String> get payload => _payload;

  Register_error({
      bool success, 
      String message, 
      List<String> payload}){
    _success = success;
    _message = message;
    _payload = payload;
}

  Register_error.fromJson(dynamic json) {
    _success = json["success"];
    _message = json["message"];
    _payload = json["payload"] != null ? json["payload"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["message"] = _message;
    map["payload"] = _payload;
    return map;
  }

}