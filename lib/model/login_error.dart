/// success : false
/// message : "خطأ في بيانات الدخول"
/// payload : []

class Login_error {
  bool _success;
  String _message;


  bool get success => _success;
  String get message => _message;


  Login_error({
      bool success, 
      String message}){
    _success = success;
    _message = message;

}

  Login_error.fromJson(dynamic json) {
    _success = json["success"];
    _message = json["message"];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["message"] = _message;

    return map;
  }

}