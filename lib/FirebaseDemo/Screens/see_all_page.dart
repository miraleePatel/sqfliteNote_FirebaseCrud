import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Constants/constants.dart';
import '../Utils/app_color.dart';
import '../Widgets/custom_search_filter.dart';
import '../Widgets/custom_widget_bookmark_icon.dart';
import '../Widgets/custom_widget_cachednetworkimage.dart';
import '../Widgets/custom_widget_text.dart';
import '../Widgets/custom_widgets.dart';
import 'details_page.dart';

class SeeAllPage extends StatefulWidget {
  const SeeAllPage({Key? key}) : super(key: key);

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {


  @override
  void initState() {
    super.initState();
    FireStoreController.seeAllPage();
    setState(() {});
  }

  int pressedAttentionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child:CustomWidgets.backIcon(context: context),
                ),
            Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SearchFiletrWidget(),
                    ),
                    ///***************************** Location List **********************************************
                    Obx(()=>
                    Container(
                        height: 145.h,
                        width: 50.h,
                        margin: EdgeInsets.only(left: 25,right: 25),
                        child:  GridView.builder(
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
                          itemCount: FireStoreController.seeallPlace.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                        alldata: FireStoreController.seeallPlace[index],
                                        isAll: true,
                                        isLatest: false,
                                        isPopular: false,
                                      )));
                                },
                                child: CustomCachedNetworkImage(
                                    imageUrl: FireStoreController.seeallPlace[index].image!,
                                    height: 20.h,
                                    width:70.w,
                                    child: Stack(
                                      children: [
                                        CustomBookmarkIcon(
                                            child: IconButton(
                                              onPressed: () {
                                                // if (FireStoreController.seeallPlace[index].isSelected!) {
                                                //   setState(() {
                                                //     FireStoreController.seeallPlace[index].isSelected =
                                                //     !FireStoreController.seeallPlace[index].isSelected!;
                                                //     saveList.add(FireStoreController.seeallPlace[index]);
                                                //   });
                                                // } else {
                                                //   setState(() {
                                                //     FireStoreController.seeallPlace[index].isSelected =
                                                //     !FireStoreController.seeallPlace[index].isSelected!;
                                                //     saveList.remove(FireStoreController.seeallPlace[index]);
                                                //   });
                                                // }
                                              },
                                              icon: FireStoreController.seeallPlace[index].isSelected!
                                                  ? Icon(
                                                Icons.bookmark_border,
                                                color: AppColors.iconcyanshade600,size: 20,
                                              )
                                                  : Icon(Icons.bookmark_outlined,
                                                color: AppColors.iconcyanshade600,size: 20,),
                                            )
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              color: Colors.black38,
                                              width: 70.w,
                                              padding: const EdgeInsets.only(bottom: 3,left: 20),
                                              child: CustomWidgetsText.text(FireStoreController.seeallPlace[index].place!,
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
                                                  CustomWidgetsText.text(FireStoreController.seeallPlace[index].location!,
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
                      ),
                    ),

              ],
            ),
          )),

      // body: SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(bottom: 20,top: 20),
      //         child: SearchFiletrWidget(),
      //       ),
      //       ///***************************** Location List **********************************************
      //       Container(
      //         height: 145.h,
      //         width: 50.h,
      //         margin: EdgeInsets.only(left: 25,right: 25),
      //         child: GridView.builder(
      //           shrinkWrap: true,
      //           scrollDirection: Axis.vertical,
      //           physics: const NeverScrollableScrollPhysics(),
      //           gridDelegate:
      //           const SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2,
      //               //childAspectRatio:1.0,
      //               mainAxisSpacing: 10.0,
      //               crossAxisSpacing: 10.0,
      //               mainAxisExtent:230
      //           ),
      //           itemCount: allPlace.length,
      //           itemBuilder: (context, index) {
      //             return GestureDetector(
      //               onTap: () {
      //                 Navigator.of(context).push(MaterialPageRoute(
      //                     builder: (context) => DetailsPage(
      //                       alldata: allPlace[index],
      //                       isAll: true,
      //                       isLatest: false,
      //                       isPopular: false,
      //                     )));
      //               },
      //               child: Container(
      //                   height: 40.h,
      //                   width: 70.w,
      //                   // margin: EdgeInsets.only(left: 70,top: 20),
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(25),
      //                       color: AppColors.iconbgcolorwhite,
      //                       image: DecorationImage(
      //                           image: AssetImage(allPlace[index].image!),
      //                           fit: BoxFit.fill)),
      //                   child: Stack(
      //                     children: [
      //                       Align(
      //                         alignment: Alignment.topRight,
      //                         child: Container(
      //                             height: 5.h,
      //                             width: 5.h,
      //                             alignment: Alignment.topRight,
      //                             margin: EdgeInsets.all(20),
      //                             decoration: BoxDecoration(
      //                                 color: Colors.white,
      //                                 borderRadius: BorderRadius.circular(10)),
      //                             child: IconButton(
      //                               onPressed: () {
      //                                 if (allPlace[index].isSelected!) {
      //                                   setState(() {
      //                                     allPlace[index].isSelected =
      //                                     !allPlace[index].isSelected!;
      //                                     saveList.add(allPlace[index]);
      //                                   });
      //                                 } else {
      //                                   setState(() {
      //                                     allPlace[index].isSelected =
      //                                     !allPlace[index].isSelected!;
      //                                     saveList.remove(allPlace[index]);
      //                                   });
      //                                 }
      //                               },
      //                               icon: allPlace[index].isSelected!
      //                                   ? Icon(
      //                                 Icons.bookmark_border,
      //                                 color: AppColors.iconcyanshade600,size: 20,
      //                               )
      //                                   : Icon(Icons.bookmark_outlined,
      //                                 color: AppColors.iconcyanshade600,size: 20,),
      //                             )),
      //                       ),
      //                       Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         mainAxisAlignment: MainAxisAlignment.end,
      //                         children: [
      //
      //                           Padding(
      //                             padding: const EdgeInsets.only(bottom: 3,left: 20),
      //                             child: CustomWidgetsText.text(allPlace[index].place!,
      //                                 color: AppColors.textWhiteColor, fontSize: 15),
      //                           ),
      //                           Padding(
      //                             padding: const EdgeInsets.only(bottom: 10,left: 20),
      //                             child: Row(
      //                               children: [
      //                                 Icon(Icons.location_on,color: AppColors.textWhiteColor,size: 15,),
      //                                 CustomWidgetsText.text(allPlace[index].location!,
      //                                     color: AppColors.textWhiteColor,fontSize: 8.sp)
      //                               ],
      //                             ),
      //                           ),
      //
      //                         ],
      //                       ),
      //                     ],
      //                   )
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //
      //     ],
      //   ),
      // ),
    );
  }
}
