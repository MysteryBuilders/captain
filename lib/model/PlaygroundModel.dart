class PlaygroundModel{
  final  String id,name,price,content,city,address,interval,created_at,time_work;
  final List images;

  PlaygroundModel({this.id,this.name,this.price,this.content,this.city,this.address,this.interval,this.time_work,this.created_at,this.images});

  factory PlaygroundModel.fromJson(final json){
    return PlaygroundModel(
      id:'${json['id']}',
      name:json['name'],
      price:'${json['price']}',
      content:json['content'],
      city:'${json['city']}',
      time_work:'${json['time_work']}',
      address:json['address'],
      interval:'${json['interval']}',
      created_at:'${json['created_at']}',
      images:json['images'],
    );
  }

}