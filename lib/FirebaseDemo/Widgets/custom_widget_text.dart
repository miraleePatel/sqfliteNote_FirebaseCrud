import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../Utils/app_color.dart';


class CustomWidgetsText {
  static Text text(
    String content, {
    Color? color,
    double? fontSize = 12,
    FontWeight? fontWeight = FontWeight.normal,
    int? maxLine,
    double? letterSpacing = 0.0,
    TextAlign? textAlign,
    double? height = 1.7,
    TextOverflow? overflow,
  })
  {
    return Text(content,
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: overflow,
        style: GoogleFonts.lato(
          letterSpacing: letterSpacing,
          color: color,
          fontSize: fontSize!.sp,
          fontWeight: fontWeight,
        ));
  }

  ///**************** Custom Widget Search TextFormfeild *****************************


}
