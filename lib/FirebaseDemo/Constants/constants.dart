import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/firebasedb_controller.dart';
import '../Controller/image_controller.dart';
import '../Controller/search_controller.dart';
import '../Models/travel_places_latest.dart';
import '../Models/travel_places_popular.dart';


/// *******************  getx Controller ***********************
var loginController = Get.put(DbController());
var ImageController=Get.put(imageController());
var  FireStoreController = Get.put(DbController());
var searchDataController = Get.put(searchController());

///****************** Authentication User *****************************
User? user = FirebaseAuth.instance.currentUser;
var current = FirebaseAuth.instance.currentUser;

var imageshow;
var image = imageshow;

///****************** Button Index *****************************
int pressedAttentionIndex = 0;


final focusName = FocusNode();
final focusEmail = FocusNode();
final focusPassword = FocusNode();