/// success : false
/// message : "Email error"

class ResetPasswordError {
  bool _success;
  String _message;

  bool get success => _success;
  String get message => _message;

  ResetPasswordError({
      bool success, 
      String message}){
    _success = success;
    _message = message;
}

  ResetPasswordError.fromJson(dynamic json) {
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