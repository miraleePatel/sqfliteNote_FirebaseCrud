import 'package:flutter/material.dart';

import '../Utils/app_color.dart';

class CustomButton extends StatelessWidget {
  double? height;
  double? width;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  Widget? child;
  Function()? onPressed;
  CustomButton(
      {Key? key,
      this.height,
      this.width,
      this.margin,
      this.child,
      this.onPressed,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.buttoncyanshade600),
      child: MaterialButton(
          onPressed: onPressed, child: child),
    );
  }
}
