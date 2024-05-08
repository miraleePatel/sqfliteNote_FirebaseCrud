import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Constants/constants.dart';
import '../Utils/app_color.dart';
import '../Widgets/custom_widget_bookmark_icon.dart';
import '../Widgets/custom_widget_cachednetworkimage.dart';
import '../Widgets/custom_widget_text.dart';
import '../Widgets/custom_widgets.dart';

class Categories extends StatefulWidget {
  bool? isUpdate;
  var getList;
  Categories({Key? key,this.isUpdate,this.getList}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List found = List.from(FireStoreController.topCategoriesList);

  @override
  void initState() {
    // TODO: implement initState
    show();
    FireStoreController.selectTopcategories();
    super.initState();
  }
  void findPersonUsingWhere(List find, String placeName) {
    /// Return list of people matching the condition
    found = find.where((element) => element.place == placeName).toList();

    if (found.isNotEmpty) {
      if (kDebugMode) {
        print('Using where: ${found.length}');
      }
    }
  }
  show(){
    findPersonUsingWhere(found,widget.getList!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: FireStoreController,
        builder: (Gcontext) {
          return Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CustomWidgets.backIcon(context: context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 130),
                          child: CustomWidgetsText.text("Categories",
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textgrey),
                        ),
                      ],
                    ),
                Padding(
                            padding: const EdgeInsets.only(top: 30,left: 25),
                            child: CustomWidgetsText.text(
                                "We Found ${found.length} Trip in ${widget.getList}",
                                color: AppColors.textCyan600,
                                fontSize: 13),
                          ),
                    Container(
                      height: 145.h,
                      width: 50.h,
                      margin: EdgeInsets.only(left: 25,right: 25),
                      child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            //childAspectRatio:1.0,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            mainAxisExtent:230
                        ),
                        itemCount: found.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => DetailsPage(
                              //       alldata: allPlace[index],
                              //       isAll: true,
                              //       isLatest: false,
                              //       isPopular: false,
                              //     )));
                            },
                            child:
                            CustomCachedNetworkImage(
                                imageUrl:found[index].image!,
                                height: 40.h,
                                width: 70.w,
                                child: Stack(
                                  children: [
                                    CustomBookmarkIcon(
                                      child:  IconButton(
                                        onPressed: () {
                                          if (found[index].isSelected!) {
                                            setState(() {
                                              found[index].isSelected =
                                              !found[index].isSelected!;
                                              FireStoreController.insertSave({
                                                'image' :found[index].image!,
                                                'location':found[index].location,
                                                'place':found[index].place,
                                                'price':found[index].price,
                                                'isSelected':found[index].isSelected
                                              });
                                            });
                                          } else {
                                            setState(() {
                                              found[index].isSelected =
                                              !found[index].isSelected!;
                                              FireStoreController.deleteSave(FireStoreController.saveList[index].id!);

                                            });
                                          }
                                        },
                                        icon: found[index].isSelected!
                                            ? Icon(
                                          Icons.bookmark_border,
                                          color: AppColors.iconcyanshade600,size: 20,
                                        )
                                            : Icon(Icons.bookmark_outlined,
                                          color: AppColors.iconcyanshade600,size: 20,),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [

                                        Container(
                                          color: Colors.black45,
                                          width: 70.w,
                                          padding: const EdgeInsets.only(bottom: 3,left: 20),
                                          child: CustomWidgetsText.text(found[index].place!,
                                              color: AppColors.textWhiteColor, fontSize: 15),
                                        ),
                                        Container(
                                          width: 70.w,
                                          padding: const EdgeInsets.only(bottom: 10,left: 20),
                                          margin: EdgeInsets.only(bottom:1),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                                            color: Colors.black38,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.location_on,color: AppColors.textWhiteColor,size: 15,),
                                              CustomWidgetsText.text(found[index].location!,
                                                  color: AppColors.textWhiteColor,fontSize: 8.sp)
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                )
                            )
                          );
                        },
                      ),
                    )

                          // Container(
                          //   height: 90.h,
                          //   width: 45.h,
                          //   child: ListView.builder(
                          //     shrinkWrap: true,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     itemCount: found.length,
                          //     itemBuilder: (context, index) {
                          //       return GestureDetector(
                          //         onTap: () {
                          //           // Navigator.of(context).push(MaterialPageRoute(
                          //           //     builder: (context) => DetailsPage(
                          //           //       alldata: allPlace[index],
                          //           //       isAll: true,
                          //           //       isLatest: false,
                          //           //       isPopular: false,
                          //           //     )));
                          //         },
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(top:10,left: 20),
                          //           child: Column(
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               Container(
                          //                 height: 20.h,
                          //                 width: 90.w,
                          //                 decoration: BoxDecoration(
                          //                   border: Border.all(
                          //                     color: AppColors.bordercyanshade600
                          //                   ),
                          //                   borderRadius: BorderRadius.circular(15)
                          //                 ),
                          //                 child: Row(
                          //                   children: [
                          //                     Container(
                          //                       height: 17.h,
                          //                       width: 25.w,
                          //                       margin: EdgeInsets.only(left: 10),
                          //                       decoration: BoxDecoration(
                          //                         borderRadius: BorderRadius.circular(15),
                          //                         image: DecorationImage(
                          //                                      image: AssetImage(found[index].image!),
                          //                                      fit: BoxFit.fill)
                          //                       ),
                          //                     ),
                          //                     Column(
                          //                       crossAxisAlignment: CrossAxisAlignment.start,
                          //                       children: [
                          //                         Padding(
                          //                           padding: const EdgeInsets.only(top: 10),
                          //                           child: TextButton.icon(
                          //                                        onPressed: () {},
                          //                                        icon: const Icon(
                          //                                          Icons.location_on,
                          //                                          color: AppColors.textBalckColor,
                          //                                          size: 20,
                          //                                        ),
                          //                                        label: CustomWidgetsText.text(
                          //                                            found[index].location!,
                          //                                            color: AppColors.textBalckColor,
                          //                                            fontSize: 10)),
                          //                         ),
                          //                         Container(
                          //                           height: 9.h,
                          //                           width: 55.w,
                          //                           margin: EdgeInsets.only(left: 10),
                          //                           child: CustomWidgetsText.text(
                          //                               found[index].description!,
                          //                               color: AppColors.textBalckColor,
                          //                               fontSize: 12),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //              SizedBox(
                          //                height: 20,
                          //              )
                          //              // Container(
                          //              //    margin: const EdgeInsets.only(
                          //              //        left: 15, top: 20,right: 5),
                          //              //    decoration: BoxDecoration(
                          //              //        borderRadius: BorderRadius.circular(25),
                          //              //        color: Colors.grey,
                          //              //        image: DecorationImage(
                          //              //            image: AssetImage(found[index].image!),
                          //              //            fit: BoxFit.fill)),
                          //              //    child: Column(
                          //              //      crossAxisAlignment: CrossAxisAlignment.start,
                          //              //      children: [
                          //              //        Container(
                          //              //            height: 4.h,
                          //              //            width: 4.3.h,
                          //              //            margin: const EdgeInsets.only(
                          //              //                top: 10, left: 130),
                          //              //            decoration: BoxDecoration(
                          //              //                color: Colors.white,
                          //              //                borderRadius:
                          //              //                BorderRadius.circular(6)),
                          //              //            child: IconButton(
                          //              //              onPressed: () {
                          //              //                // setState(() {
                          //              //                //   travelPopularList[index].isSelected = !travelPopularList[index].isSelected!;
                          //              //                // });
                          //              //                if (found[index].isSelected!) {
                          //              //                  setState(() {
                          //              //                    found[index].isSelected =
                          //              //                    !found[index].isSelected!;
                          //              //                    saveList.add(found[index]);
                          //              //                  });
                          //              //                } else {
                          //              //                  setState(() {
                          //              //                    found[index].isSelected =
                          //              //                    !found[index].isSelected!;
                          //              //                    saveList.remove(found[index]);
                          //              //                  });
                          //              //                }
                          //              //              },
                          //              //              icon: found[index].isSelected!
                          //              //                  ? Icon(
                          //              //                Icons.bookmark_border,
                          //              //                color:
                          //              //                AppColors.iconcyanshade600,
                          //              //              )
                          //              //                  : Icon(Icons.bookmark_outlined,
                          //              //                  color:
                          //              //                  AppColors.iconcyanshade600),
                          //              //            )),
                          //              //        Padding(
                          //              //          padding: const EdgeInsets.only(
                          //              //              top: 60, left: 20),
                          //              //          child: CustomWidgetsText.text(
                          //              //              found[index].place!,
                          //              //              color: AppColors.textWhiteColor,
                          //              //              fontSize: 12),
                          //              //        ),
                          //              //        TextButton.icon(
                          //              //            onPressed: () {},
                          //              //            icon: const Icon(
                          //              //              Icons.location_on,
                          //              //              color: AppColors.textWhiteColor,
                          //              //              size: 20,
                          //              //            ),
                          //              //            label: CustomWidgetsText.text(
                          //              //                found[index].location!,
                          //              //                color: AppColors.textWhiteColor,
                          //              //                fontSize: 10)),
                          //              //      ],
                          //              //    ),
                          //              //  ),
                          //             ],
                          //           ),
                          //         ),
                          //
                          //       );
                          //     },
                          //   ),
                          // ),

                  ],
                ),
              ));
        }
      )
    );
  }
}
