import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_widgets.dart';

class CustomWidgetTextFormfeild extends StatelessWidget {
  TextEditingController? controller;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  bool obscureText =true;
  Function(String)? onChanged;
 Function()? onTap;
  FocusNode? focusNode;
  CustomWidgetTextFormfeild(
      {Key? key,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.validator,
      this.suffixIcon,
        this.onTap,
        this.keyboardType,
      required this.obscureText,
        this.onChanged,
        this.focusNode

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFeild(
        controller: controller, validator: validator, obscureText: obscureText, onTap: onTap,
        focusNode: focusNode, keyboardType: keyboardType,
        onChanged: onChanged, hintText: hintText,
        suffixIcon: suffixIcon, prefixIcon: prefixIcon);
  }
}

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({
    Key? key,
    required this.controller,
    required this.validator,
    required this.obscureText,
    required this.onTap,
    required this.focusNode,
    required this.keyboardType,
    required this.onChanged,
    required this.hintText,
    required this.suffixIcon,
    required this.prefixIcon,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? Function(String? p1)? validator;
  final bool obscureText;
  final Function()? onTap;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Function(String p1)? onChanged;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator:(v)=> validator!(v),
      obscureText: obscureText,
        onTap: onTap,
        focusNode: focusNode,
        keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      decoration: hintText == null?
      CustomWidgets.inputSearchDecoration(suffixIcon:suffixIcon) :
        CustomWidgets.inputloginDecoration(
           hintText : hintText, prefixIcon: prefixIcon, suffixIcon:suffixIcon )

    );
  }
}
