class Utilities{

static bool validateEmail(String value) {
  String patttern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return false;
  }
  else if (!regExp.hasMatch(value)) {
    return false;
  }else{
    return true;
  }

}
static bool validateMobile(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{8}$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return false;
  }
  else if (!regExp.hasMatch(value)) {
    return false;
  }else{
    return true;
  }

}
}