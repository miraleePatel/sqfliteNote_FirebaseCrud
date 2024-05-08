import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/app_color.dart';
import 'custom_widget_text.dart';

class CustomListTileSetting extends StatelessWidget {
  Widget? title;
  Widget? child;
  Function()? onTap;
  CustomListTileSetting({Key? key, this.title, this.child, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 9.h,
      width: 48.h,
      margin: EdgeInsets.only(left: 20,right: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.bordercyanshade600)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          child: CircleAvatar(
              backgroundColor: AppColors.bordercyanshade600, child: child),
        ),
        title: title,
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: onTap,
      ),
    );
  }
}
