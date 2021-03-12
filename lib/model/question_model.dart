/// success : true
/// payload : {"msg":"استفسار\n<br>\nاحتاج المزيد من المعلومات","name":"Ahmed","email":"ahmed@sz4h.com","phone":"66991985","type":"0","coach_id":"8","updated_at":"2021-03-08T11:43:34.000000Z","created_at":"2021-03-08T11:43:34.000000Z","id":6}

class QuestionModel {
  bool _success;
  Payload _payload;

  bool get success => _success;
  Payload get payload => _payload;

  QuestionModel({
      bool success, 
      Payload payload}){
    _success = success;
    _payload = payload;
}

  QuestionModel.fromJson(dynamic json) {
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

/// msg : "استفسار\n<br>\nاحتاج المزيد من المعلومات"
/// name : "Ahmed"
/// email : "ahmed@sz4h.com"
/// phone : "66991985"
/// type : "0"
/// coach_id : "8"
/// updated_at : "2021-03-08T11:43:34.000000Z"
/// created_at : "2021-03-08T11:43:34.000000Z"
/// id : 6

class Payload {
  String _msg;
  String _name;
  String _email;
  String _phone;
  String _type;
  String _coachId;
  String _updatedAt;
  String _createdAt;
  int _id;

  String get msg => _msg;
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get type => _type;
  String get coachId => _coachId;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;

  Payload({
      String msg, 
      String name, 
      String email, 
      String phone, 
      String type, 
      String coachId, 
      String updatedAt, 
      String createdAt, 
      int id}){
    _msg = msg;
    _name = name;
    _email = email;
    _phone = phone;
    _type = type;
    _coachId = coachId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Payload.fromJson(dynamic json) {
    _msg = json["msg"];
    _name = json["name"];
    _email = json["email"];
    _phone = json["phone"];
    _type = json["type"];
    _coachId = json["coach_id"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["msg"] = _msg;
    map["name"] = _name;
    map["email"] = _email;
    map["phone"] = _phone;
    map["type"] = _type;
    map["coach_id"] = _coachId;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    return map;
  }

}