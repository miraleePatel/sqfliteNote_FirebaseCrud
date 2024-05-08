import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../Constants/constants.dart';

class searchController extends GetxController{
  final List _allUsers = List.from(FireStoreController.travellatestList)..addAll(FireStoreController.travelPopularList);
List foundUsers = [];
List foundPeople = [];
  bool isShow = false;
  bool isOpen = false;

  @override
  void onInit() {
    // TODO: implement onInit
    foundUsers.addAll(_allUsers);
    super.onInit();
  }

  void runFilter(String enteredKeyword) {
    List results = List.filled(0, "0", growable: true);
   List results1 = List.filled(0, "0", growable: true);
    if (enteredKeyword.isEmpty) {
      /// if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user.place.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      results1 = _allUsers
          .where((user) => user.location
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
      foundUsers= results + results1;
    update();
  }


  void findPersonUsingWhere(List find, String personName) {
    /// Return list of people matching the condition
    foundPeople = find.where((element) => element.place == personName).toList();

    if (foundPeople.isNotEmpty) {
      if (kDebugMode) {
        print('Using where: ${foundPeople.length}');
      }
    }
    update();
  }

}