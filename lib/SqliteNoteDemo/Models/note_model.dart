class NoteModel{
  int? id;
  String? title;
  String? description;

  NoteModel.fromJson(Map<String, dynamic> map){
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
  }

  NoteModel.toJson(){
    Map<String, dynamic> map=Map<String, dynamic>();
    map['id']= this.id;
    map['title']= this.title;
    map['description']= this.description;
  }
}