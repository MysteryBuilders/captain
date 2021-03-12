class AcademyCatModel {
  final String id, name, created_at, img;

  AcademyCatModel({this.id, this.name, this.created_at, this.img});

  factory AcademyCatModel.fromJson(final json){
    return AcademyCatModel(
      id: '${json['id']}',
      name: json['name'],
      img: '${json['img']}',
      created_at: '${json['created_at']}',
    );
  }
}