class topModel{
  String? id;
  String? image;
  String? location;
  String? place;
  String? description;
  num? price;
  bool? isSelected;

  topModel(
      {this.id, this.image, this.location, this.place,this.description,this.isSelected,this.price});
  topModel.fromJson(Map<String,dynamic> map, String id){
    this.image = map['image'];
    this.location = map['location'];
    this.place = map['place'];
    this.price = map['price'];
    this.isSelected = map['isSelected'];
    this.id = id;
  }

}

// List<topModel> topCategoriesList = [
//   topModel(
//       id: 1.toString(),
//       image: 'assets/Top/laem_sing_beach.jpg',
//       location: 'Puket Beach',
//       place: 'Thailand',
//       description: 'Laem Sing Beach, Located in Phuket',
//       price: 450,
//       isSelected: true),
//   topModel(
//       id: 2.toString(),
//       image: 'assets/Top/auli_mountain.jpg',
//       location: 'Auli Mountain',
//       place: 'Uttrakhnad',
//       description: 'There are very beautiful mountain in uttarakhand india. But it has one unique mountain call it "Lotus Mountain" at auli, Uttarakhand. Which shaped leaves of louts and create a visual shape of lotus.',
//       price: 450,
//       isSelected: true),
//   topModel(
//       id: 3.toString(),
//       image: 'assets/Top/nainital_lake.jpg',
//       location: 'Nainital Lake',
//       place: 'Uttrakhnad',
//       description: 'Full view of Naini Lake during evening time near Mall Road in Nainital, Uttarakhand, India, Beautiful view of Nainital Lake with mountains and blue sky',
//       price: 450,
//       isSelected: true),
//   topModel(
//       id: 4.toString(),
//       image: 'assets/Top/pradisiac_beach.jpg',
//       location: 'Pradisiac Beach',
//       place: 'Maldives',
//       description: 'Paradisiac beach at Maldives',
//       price: 450,
//       isSelected: true),
//   topModel(
//       id: 5.toString(),
//       image: 'assets/Top/kendhoo_beach.jpg',
//       location: 'kendhoo Beach',
//       place: 'Maldives',
//       description: 'kendhoo Beach at Maldives',
//       price: 450,
//       isSelected: true),
//
//
// ];