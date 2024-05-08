import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class DateController extends GetxController {
  var initDate = DateTime.now().obs;

  RxString startDate = 'Start Date'.obs;
  RxString endDate = 'End Date'.obs;

  @override
  void onInit() {
  }

  selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: initDate.value,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != initDate) {
      startDate.value = new DateFormat.yMd().format(picked);
    }
  }

  selectBod() async{
    final DateTime? picked = await showDatePicker
      (context: Get.context!,
        initialDate: initDate.value,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
  }

  selectDate1() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: initDate.value,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != initDate) {endDate.value = new DateFormat.yMd().format(picked);
    }
  }
}
