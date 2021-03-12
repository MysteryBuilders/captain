class CoachModel{
  final  String id,name,country_code,ex,age,address,length,created_at,foot,is_star,cat_name,img;

  CoachModel({this.id,this.name,this.country_code,this.ex,this.age,this.address,this.length,
    this.foot,this.created_at,this.is_star,this.cat_name,this.img});

  factory CoachModel.fromJson(final json){
    return CoachModel(
      id:'${json['id']}',
      name:json['name'],
      country_code:'${json['country_code']}',
      ex:json['ex'],
      age:'${json['age']}',
      foot:'${json['foot']}',
      address:json['address'],
      length:'${json['length']}',
      created_at:'${json['created_at']}',
      is_star:json['is_star'],
      cat_name:json['cat_name'],
      img:json['img'],
    );
  }
}
