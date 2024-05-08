class userModel{
  String? name;
  String? email;
  String? password;
  String? contact;
  String? dob;
  String? id;
  String? image;
  String? uid;

  userModel({this.name,this.email,this.password,this.id,this.uid,this.contact,this.dob,this.image});

  userModel.fromJson(Map<String,dynamic>map,String id){
    this.name = map['fname'];
    this.email = map['email'];
    this.password = map['password'];
    this.contact = map['contact'];
    this.dob = map['dob'];
    this.image = map['image'];
    this.uid = map['uid'];
    this.id = id;
  }

}