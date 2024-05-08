import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Utils/app_color.dart';

class CustomWidgets {
  /// ***************************** Custom Login TextFormfied Input Decoration **********

  static InputDecoration inputloginDecoration(
      {String? hintText, Widget? prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white24,
        errorStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        border: InputBorder.none,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none));
  }

  /// ***************************** Custom Search TextFormfied Input Decoration **********

  static InputDecoration inputSearchDecoration({Widget? suffixIcon}) {
    return InputDecoration(
        hintText: "Search..",
        hintStyle: TextStyle(color:AppColors.iconcyanshade600 ),
        filled: true,
        contentPadding: EdgeInsets.only(bottom: 5, right: 5),
        fillColor: AppColors.icongreyshade200,
        prefixIcon:Icon(
          Icons.search,color: AppColors.iconcyanshade600,
        ),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
            borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
            borderSide: BorderSide.none),
        suffixIcon: suffixIcon);
  }

  /// ******************************  Icon Back **********************************

  static CircleAvatar backIcon({dynamic context}) {
    return CircleAvatar(
      backgroundColor: AppColors.icongreyshade200,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.iconcyanshade600,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  /// ***************************** Container Image Decoration ************************

  static Container childContainer({double? height,double? width,
      EdgeInsetsGeometry? margin, Widget? child,DecorationImage? image}
      ){
    return  Container(
        height:height,
        width: width,
        margin:margin,
        // margin: EdgeInsets.only(left: 70,top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.iconbgcolorwhite,
            image:image),
        child: child
    );
  }

/// ***************************** Container Image Decoration for Detail Page************************

  static Container detailContainer({DecorationImage? image}){
    return Container(
      height: 25.h,
      width: 65.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: image),
    );
  }

  /// ***************************** Container Image Decoration for Serach And Filter************************

  static Container serachContainer({DecorationImage? image}){
    return  Container(
      margin: EdgeInsets.only(
        left: 12,
        top: 1.5.h,
      ),
      height: 10.h,
      width: 10.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            new BoxShadow(
              color: AppColors.textgrey.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 0.5,
              offset: Offset(
                5.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            ),
          ],
          image:image),
    );
  }
}


