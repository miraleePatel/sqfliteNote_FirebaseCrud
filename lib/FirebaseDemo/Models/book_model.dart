class bookModel{
  String? id;
  String? image;
  String? location;
  String? place;
  num? price;
  String? startdate;
  String? enddate;
  num? discount;
  num? total;
  num? person;
  bookModel(
      {this.id, this.image,
        this.location, this.place,
        this.price,
      this.discount,
      this.enddate,this.startdate,this.total,this.person});

  bookModel.fromJson(Map<String,dynamic> map, String id){
    this.image = map['image'];
    this.location = map['location'];
    this.place = map['place'];
    this.price = map['price'];
    this.startdate = map['startdate'];
    this.enddate = map['enddate'];
    this.discount = map['discount'];
    this.total = map['total'];
    this.person = map['person'];
    this.id = id;
  }
}