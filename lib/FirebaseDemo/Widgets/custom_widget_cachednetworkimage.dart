import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/app_color.dart';
import 'custom_widgets.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  String? imageUrl;
  Widget? child;
  double? height;
  double? width;
  EdgeInsetsGeometry? margin;
  CustomCachedNetworkImage(
      {Key? key,
      required this.imageUrl,
      this.child,
      this.height,
      this.width,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl.toString(),
      imageBuilder: (context, imageProvider) => margin == null &&
              height == null &&
              width == null
          ? CustomWidgets.serachContainer(
              image: DecorationImage(image: imageProvider, fit: BoxFit.fill))
          : height == null && width == null
              ? CustomWidgets.detailContainer(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill))
              : CustomWidgets.childContainer(
                  height: height,
                  width: width,
                  margin: margin,
                  child: child,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill)),

      placeholder: (context, url) => Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color:AppColors.bgColor,
          )),
      // placeholderFadeInDuration: Duration(seconds: 1),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
