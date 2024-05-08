class TravelLatest {
  String? id;
  String? image;
  String? location;
  String? place;
  num? price;
  bool? isSelected;

  TravelLatest(
      {this.id, this.image, this.location, this.place, this.isSelected,this.price});

  TravelLatest.fromJson(Map<String,dynamic> map, String id){
    this.image = map['image'];
    this.location = map['location'];
    this.place = map['place'];
    this.price = map['price'];
    this.isSelected = map['isSelected'];
    this.id = id;
  }

  TravelLatest.toJson(Map<String,dynamic> map, String id){
    map['image']=this.image;
    map['location']=this.location;
    map['place']=this.place;
    map['price']=this.price;
    map['isSelected']=this.isSelected;
    id=this.id!;
  }

}

