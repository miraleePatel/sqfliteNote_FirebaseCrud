import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBookmarkIcon extends StatelessWidget {
 final Widget? child;
  const CustomBookmarkIcon({Key? key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.topRight,
      child: Container(
          height:36,
          width: 37,
          alignment: Alignment.topRight,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)),
          child: child
      ),
    );
  }
}
