/// success : true
/// payload : true

class SaveTokenModel {
  bool _success;
  bool _payload;

  bool get success => _success;
  bool get payload => _payload;

  SaveTokenModel({
      bool success, 
      bool payload}){
    _success = success;
    _payload = payload;
}

  SaveTokenModel.fromJson(dynamic json) {
    _success = json["success"];
    _payload = json["payload"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["payload"] = _payload;
    return map;
  }

}