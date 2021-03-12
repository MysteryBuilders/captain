/// success : true
/// payload : {"payment_url":"https://kpaytest.com.kw/kpg/PaymentHTTP.htm?param=paymentInit&trandata=E820A3265EFE10D28AA585A0F9C06D10480EB3C8ADD21A0461A0855716B4A6769AF40DA21E8374B43B8402CED3971CE02676201AC59655C2905B6D817CD87E10672D56BF60FF06999DDDFE0AF58A94DE0D023D9BC589C557B81C092B2402E505FB46ADE01DF3550E65197A251206613A32CE0603DCCA35AFDA1A5EA9E65A748DE774C7D3FBE0E246CDB36D38C17DCCC11EBF4A9324731E0E53529338F669D0BDAB7FAB9A8FC35F39E70BEC65A5C1440E1A2766358B1A3DAD057F5E7BF865662DE1B5F3A431240FA4EE9BF27134A2826F760FD21F25006C630BFA68B9846C802AEA19C0240DB7DBCFBA20A31B0BBD6EFDAD633F172CE90CCA1CEAFC9406939EDE939656E242819253D275B55CA4D527C58F18CEC7E4266D7E79AC09176CF1AC29&errorURL=errorURL=https://apps.bookeey.com/pgapi/api/payinvoice/KfastFail/16518544717&&responseURL=responseURL=https://apps.bookeey.com/pgapi/api/payinvoice/KfastSuccess/16518544717&&tranportalId=108401"}

class OrderModel {
  bool _success;
  Payload _payload;

  bool get success => _success;
  Payload get payload => _payload;

  OrderModel({
      bool success, 
      Payload payload}){
    _success = success;
    _payload = payload;
}

  OrderModel.fromJson(dynamic json) {
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

/// payment_url : "https://kpaytest.com.kw/kpg/PaymentHTTP.htm?param=paymentInit&trandata=E820A3265EFE10D28AA585A0F9C06D10480EB3C8ADD21A0461A0855716B4A6769AF40DA21E8374B43B8402CED3971CE02676201AC59655C2905B6D817CD87E10672D56BF60FF06999DDDFE0AF58A94DE0D023D9BC589C557B81C092B2402E505FB46ADE01DF3550E65197A251206613A32CE0603DCCA35AFDA1A5EA9E65A748DE774C7D3FBE0E246CDB36D38C17DCCC11EBF4A9324731E0E53529338F669D0BDAB7FAB9A8FC35F39E70BEC65A5C1440E1A2766358B1A3DAD057F5E7BF865662DE1B5F3A431240FA4EE9BF27134A2826F760FD21F25006C630BFA68B9846C802AEA19C0240DB7DBCFBA20A31B0BBD6EFDAD633F172CE90CCA1CEAFC9406939EDE939656E242819253D275B55CA4D527C58F18CEC7E4266D7E79AC09176CF1AC29&errorURL=errorURL=https://apps.bookeey.com/pgapi/api/payinvoice/KfastFail/16518544717&&responseURL=responseURL=https://apps.bookeey.com/pgapi/api/payinvoice/KfastSuccess/16518544717&&tranportalId=108401"

class Payload {
  String _paymentUrl;

  String get paymentUrl => _paymentUrl;

  Payload({
      String paymentUrl}){
    _paymentUrl = paymentUrl;
}

  Payload.fromJson(dynamic json) {
    _paymentUrl = json["payment_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["payment_url"] = _paymentUrl;
    return map;
  }

}