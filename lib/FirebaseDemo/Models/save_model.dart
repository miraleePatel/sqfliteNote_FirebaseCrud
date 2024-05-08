class saveModel{
  String? id;
  String? image;
  String? location;
  String?  place;
  num? price;
  bool? isSelected;

  saveModel({this.id,this.image,this.location,this.place,this.isSelected,this.price});

  saveModel.fromJson(Map<String,dynamic>map,String id){
    this.image=map['image'];
    this.location=map['location'];
    this.place=map['place'];
    this.price=map['price'];
    this.isSelected=map['isSelected'];
    this.id=id;
  }
}

// List saveList = [];