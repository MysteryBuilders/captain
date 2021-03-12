/// success : true
/// payload : {"data":[{"id":1,"msg":"hello","url":"https://google.com","data":null,"created_at":"11-03-21 09:09 AM","updated_at":"2021-03-11T09:09:38.000000Z"},{"id":2,"msg":"hello","url":null,"academy":{"id":13,"name":"اكاديمية ١","img":"1608987689_3604.png","address":"ش حميد","time_work":"من الساعة ٦ صباحة حتى الساعة ٦ مساء","content":"<p>نص تجريبي&nbsp;نص تجريبي&nbsp;نص تجريبي&nbsp;نص تجريبي&nbsp;نص تجريبي&nbsp;نص تجريبي&nbsp;نص تجريبي&nbsp;</p>","price":50,"price_n":70,"cat_id":1,"city_id":1,"gender":"0","deleted_at":null,"created_at":"2021-01-25T18:08:26.000000Z","updated_at":"2021-01-25T18:08:26.000000Z","cat":{"id":1,"name":"كرة قدم","img":"1608987363_8280.png","deleted_at":null,"created_at":"2020-12-26T15:56:04.000000Z","updated_at":"2020-12-26T15:56:04.000000Z"},"city":{"id":1,"name":"اختبار","img":"1608987523_7869.jpg","deleted_at":null,"created_at":"2020-12-26T15:58:47.000000Z","updated_at":"2020-12-26T15:58:47.000000Z"},"images":[{"id":4,"img":"1614783478_6005.jpg","academy_id":13,"created_at":"2021-03-03T14:57:58.000000Z","updated_at":"2021-03-03T14:57:58.000000Z"},{"id":5,"img":"1614783495_7844.jpg","academy_id":13,"created_at":"2021-03-03T14:58:15.000000Z","updated_at":"2021-03-03T14:58:15.000000Z"}]},"created_at":"11-03-21 09:11 AM","updated_at":"2021-03-11T09:11:26.000000Z"}],"from":1,"to":2,"total":2,"current_page":1,"last_page":1,"per_page":10}

class NotificationModel {
  bool _success;
  Payload _payload;

  bool get success => _success;
  Payload get payload => _payload;

  NotificationModel({
      bool success, 
      Payload payload}){
    _success = success;
    _payload = payload;
}

  NotificationModel.fromJson(dynamic json) {
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

/// data : [{"id":1,"msg":"hello","url":"https://google.com","data":null,"created_at":"11-03-21 09:09 AM","updated_at":"2021-03-11T09:09:38.000000Z"},{"id":2,"msg":"hello","url":null,"academy":{"id":13,"name":"اكاديمية ١","img":"1608987689_3604.png","address":"ش حميد","time_work":"من الساعة ٦ صباحة حتى الساعة ٦ مساء","content":"<p>نص تجريبي&nbsp;نص تجريبي&nbsp;نص تجريبي&nbsp;نص تجريبي&nbsp;نص تجريبي&nbsp;نص تجريبي&nbsp;نص تجريبي&nbsp;</p>","price":50,"price_n":70,"cat_id":1,"city_id":1,"gender":"0","deleted_at":null,"created_at":"2021-01-25T18:08:26.000000Z","updated_at":"2021-01-25T18:08:26.000000Z","cat":{"id":1,"name":"كرة قدم","img":"1608987363_8280.png","deleted_at":null,"created_at":"2020-12-26T15:56:04.000000Z","updated_at":"2020-12-26T15:56:04.000000Z"},"city":{"id":1,"name":"اختبار","img":"1608987523_7869.jpg","deleted_at":null,"created_at":"2020-12-26T15:58:47.000000Z","updated_at":"2020-12-26T15:58:47.000000Z"},"images":[{"id":4,"img":"1614783478_6005.jpg","academy_id":13,"created_at":"2021-03-03T14:57:58.000000Z","updated_at":"2021-03-03T14:57:58.000000Z"},{"id":5,"img":"1614783495_7844.jpg","academy_id":13,"created_at":"2021-03-03T14:58:15.000000Z","updated_at":"2021-03-03T14:58:15.000000Z"}]},"created_at":"11-03-21 09:11 AM","updated_at":"2021-03-11T09:11:26.000000Z"}]
/// from : 1
/// to : 2
/// total : 2
/// current_page : 1
/// last_page : 1
/// per_page : 10

class Payload {
  List<Data> _data;
  int _from;
  int _to;
  int _total;
  int _currentPage;
  int _lastPage;
  int _perPage;

  List<Data> get data => _data;
  int get from => _from;
  int get to => _to;
  int get total => _total;
  int get currentPage => _currentPage;
  int get lastPage => _lastPage;
  int get perPage => _perPage;

  Payload({
      List<Data> data, 
      int from, 
      int to, 
      int total, 
      int currentPage, 
      int lastPage, 
      int perPage}){
    _data = data;
    _from = from;
    _to = to;
    _total = total;
    _currentPage = currentPage;
    _lastPage = lastPage;
    _perPage = perPage;
}

  Payload.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _from = json["from"];
    _to = json["to"];
    _total = json["total"];
    _currentPage = json["current_page"];
    _lastPage = json["last_page"];
    _perPage = json["per_page"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["from"] = _from;
    map["to"] = _to;
    map["total"] = _total;
    map["current_page"] = _currentPage;
    map["last_page"] = _lastPage;
    map["per_page"] = _perPage;
    return map;
  }

}

/// id : 1
/// msg : "hello"
/// url : "https://google.com"
/// data : null
/// created_at : "11-03-21 09:09 AM"
/// updated_at : "2021-03-11T09:09:38.000000Z"

class Data {
  int _id;
  String _msg;
  String _url;
  dynamic _data;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get msg => _msg;
  String get url => _url;
  dynamic get data => _data;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Data({
      int id, 
      String msg, 
      String url, 
      dynamic data, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _msg = msg;
    _url = url;
    _data = data;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _msg = json["msg"];
    _url = json["url"];
    _data = json["data"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["msg"] = _msg;
    map["url"] = _url;
    map["data"] = _data;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}