class CityModel{
  final int id;
  final  String name;

  CityModel({this.id,this.name});

  factory CityModel.fromJson(final json){
    return CityModel(
      id:json['id'],
      name:json['name'],
    );
  }
}
