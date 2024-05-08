import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  TextEditingController? controller;
  String? hintText;
  TextStyle? hintStyle;
  String? Function(String?)? validator;
  int? maxLines;
  TextFormFieldWidget({Key? key,this.controller,this.hintText,this.hintStyle,this.validator,this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText:hintText ,
          hintStyle:hintStyle,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)
          )
      ),
      validator:validator,
      maxLines: maxLines,
    );
  }
}
