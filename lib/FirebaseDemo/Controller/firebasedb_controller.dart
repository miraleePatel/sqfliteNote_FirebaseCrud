import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_demo/Models/book_model.dart';
import 'package:travel_demo/Models/save_model.dart';
import 'package:travel_demo/Models/top_categories.dart';
import 'package:travel_demo/Models/user_model.dart';
import '../Models/travel_places_latest.dart';
import '../Models/travel_places_popular.dart';
import '../Utils/app_color.dart';

class  DbController extends GetxController{
  RxList loginList = [].obs;
  RxList userList = [].obs;
  RxList travellatestList = [].obs;
  RxList travelPopularList = [].obs;
  RxList saveList = [].obs;
  RxList allPlace = [].obs;
  RxList seeallPlace = [].obs;
  RxList bookList = [].obs;
  List topCategoriesList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    selectSave();
    selectLatestData();
    selectPopular();
    selectBook();
    selectTopcategories();
    showAll();
    seeAllPage();
    super.onInit();
  }
  /// ******************************  User  ******************************************

  inserUser(Map<String,dynamic> map,String id){
    FirebaseFirestore.instance.collection('users').doc(id).set(map);
    selectUser();
  }

  selectUser()async{
    var data = await FirebaseFirestore.instance.collection('users').get();
    userList.value=data.docs.map((e) =>userModel.fromJson(e.data(),e.id)).toList();
  }

  updateUser(Map<String,dynamic> map,String id){
    FirebaseFirestore.instance.collection('users').doc(id).update(map).then((value) => Get.snackbar(
      "",
      "",
      backgroundColor: AppColors.bgColor,
      duration: Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        "Update Account Sucessfully",
        style: TextStyle(color: Colors.white),
      ),
    ));
    selectUser();
  }

  /// ******************************  Login ******************************************
  inserData(Map<String,dynamic> map){
    FirebaseFirestore.instance.collection('Login').add(map);
  }
  //
  // selectData()async{
  //   var data = await FirebaseFirestore.instance.collection('Login').get();
  //   loginList.value=data.docs.map((e) => loginModel.fromJson(e.data(),e.id)).toList();
  // }


  UpdateData(Map<String,dynamic> map,String id){
    FirebaseFirestore.instance.collection('login').doc(id).update(map);
  }

  DeleteData(String id)async{
    FirebaseFirestore.instance.collection('login').doc(id).delete();
  }

  /// ******************************  Book Now ******************************************
  insertBook(Map<String,dynamic> map){
    FirebaseFirestore.instance.collection('Booking').add(map);

  }

  selectBook()async{
    var data = await FirebaseFirestore.instance.collection('Booking').get();
    bookList.value=data.docs.map((e) => bookModel.fromJson(e.data(),e.id)).toList();
  }


  UpdateBook(Map<String,dynamic> map,String id){
    FirebaseFirestore.instance.collection('Booking').doc(id).update(map);
    }

  DeleteBook(String id)async{
    FirebaseFirestore.instance.collection('Booking').doc(id).delete();

  }

  ///*******************************  SaveList Data ************************************

  insertSave(Map<String,dynamic>map){
    FirebaseFirestore.instance.collection('Save').add(map);
    selectSave();
  }

  selectSave()async{
    var data = await FirebaseFirestore.instance.collection('Save').get();
    saveList.value=data.docs.map((e) => saveModel.fromJson(e.data(),e.id)).toList();
  }

  deleteSave(String id)async{
    FirebaseFirestore.instance.collection('Save').doc(id).delete();
    selectSave();
  }

  ///*************************** Select Latest Data ******************************************
  selectLatestData()async{
    var data = await FirebaseFirestore.instance.collection('Latest').get();
    travellatestList.value = data.docs.map((e) => TravelLatest.fromJson(e.data(),e.id)).toList();
  }

  ///*************************** Select Popular Data ******************************************

  selectPopular()async{
    var data = await FirebaseFirestore.instance.collection('Popular').get();
    travelPopularList.value = data.docs.map((e) => TravelPopular.fromJson(e.data(),e.id)).toList();
  }

  ///*************************** Select Top Categories Data ******************************************

  selectTopcategories()async{
    var data = await FirebaseFirestore.instance.collection('TopCategories').get();
    topCategoriesList = data.docs.map((e) => topModel.fromJson(e.data(),e.id)).toList();
    update();
  }

  ///*************************** Show All Data ******************************************

  showAll() {
    allPlace.value = List.from(travellatestList.take(2))
      ..addAll(travelPopularList.take(2));
  }

  seeAllPage(){
    seeallPlace.value = List.from(travellatestList)
      ..addAll(travelPopularList);
  }


}