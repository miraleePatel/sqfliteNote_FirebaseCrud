import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';
import '../Utils/app_color.dart';

class ZoomImages extends StatefulWidget {
  bool? isLatest;
  bool? isPopular;
  bool? isAll;
  bool? isSave;
  bool? isSearch;
  var latestImages;
  var popularImages;
  var allImages;
  var saveImages;
  var searchImages;
  ZoomImages(
      {Key? key,
      this.latestImages,
      this.isLatest,
      this.isAll,
      this.isPopular,
      this.isSave,
      this.isSearch,
      this.allImages,
      this.popularImages,
      this.saveImages,
      this.searchImages})
      : super(key: key);

  @override
  State<ZoomImages> createState() => _ZoomImagesState();
}

class _ZoomImagesState extends State<ZoomImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        widget.isLatest!
            ? PhotoView(
                imageProvider: NetworkImage(widget.latestImages),
                heroAttributes: PhotoViewHeroAttributes(tag: 'latest_images'),
                //enableRotation: true,
                // minScale: PhotoViewComputedScale.covered ,
                // maxScale: PhotoViewComputedScale.covered * 0.9,
                // initialScale: PhotoViewComputedScale.covered,
                basePosition: Alignment.center,
              )
            : widget.isPopular!
                ? PhotoView(
                    imageProvider: NetworkImage(widget.popularImages),
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: 'popular_images'),
                    basePosition: Alignment.center,
                  )
                : widget.isAll!
                    ? PhotoView(
                        imageProvider: NetworkImage(widget.allImages),
                        heroAttributes:
                            PhotoViewHeroAttributes(tag: 'all_images'),
                        basePosition: Alignment.center,
                      )
                    : widget.isSave!
                        ? PhotoView(
                            imageProvider: NetworkImage(widget.saveImages),
                            heroAttributes:
                                PhotoViewHeroAttributes(tag: 'save_images'),
                            basePosition: Alignment.center,
                          )
                        : PhotoView(
                            imageProvider: NetworkImage(widget.searchImages),
                            heroAttributes:
                                PhotoViewHeroAttributes(tag: 'search_images'),
                            basePosition: Alignment.center,
                          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 6.h,
            width: 30.w,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.iconcyanshade600,
                )),
            child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
                label: Text("Dismiss")),
          ),
        )
      ],
    ));
  }
}
