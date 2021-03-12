class AcademyModel {
  final String id, name, price, price_n, content, city_name, cat_id, cat_name,
      city_id,
      address, gender, time_work, created_at, img;
  final List images;

  AcademyModel(
      {this.id, this.name, this.price, this.price_n, this.content, this.cat_id, this.cat_name,this.images
        , this.city_id, this.city_name, this.address, this.gender, this.time_work, this.created_at, this.img});

  factory AcademyModel.fromJson(final json){
    return AcademyModel(
      id: '${json['id']}',
      name: json['name'],
      price: '${json['price']}',
      price_n: json['price_n'],
      cat_id: '${json['cat_id']}',
      city_id: '${json['city_id']}',
      city_name: '${json['city_name']}',
      address: json['address'],
      gender: json['gender'],
      img: '${json['img']}',
      content: '${json['content']}',
      time_work: '${json['time_work']}',
      created_at: '${json['created_at']}',
      images:json['images'],

    );
  }
}