

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
import '../Models/save_model.dart';
import '../Models/travel_places_latest.dart';
import '../Models/travel_places_popular.dart';
import '../Screens/details_page.dart';
import '../Utils/app_color.dart';
import '../Utils/app_string.dart';
import 'custom_widget_bookmark_icon.dart';
import 'custom_widget_cachednetworkimage.dart';
import 'custom_widget_text.dart';

class TravelPlacesView extends StatefulWidget {
  const TravelPlacesView({Key? key}) : super(key: key);

  @override
  State<TravelPlacesView> createState() => _TravelPlacesViewState();
}

class _TravelPlacesViewState extends State<TravelPlacesView>
    with TickerProviderStateMixin {
  late final TabController? tabController;



  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    FireStoreController.showAll();
    FireStoreController.selectSave();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Container(
                height: 3.h,
                width: 68.w,
                margin: const EdgeInsets.only(bottom: 12),
               // padding: const EdgeInsets.only(bottom: 10,top: 10),
                child: TabBar(
                    controller: tabController,
                    labelColor: AppColors.tabbarlabelcolor,
                    unselectedLabelColor: AppColors.tabbarunselectedlabelcolor,
                    indicatorColor: AppColors.tabbarindicatorColor,
                    tabs: [
                      Tab(
                        child: CustomWidgetsText.text(AppStrings.all),
                      ),
                      Tab(
                        child: CustomWidgetsText.text(AppStrings.latest),
                      ),
                      Tab(
                        child: CustomWidgetsText.text(AppStrings.popular),
                      ),
                    ]),
              ),
            ),
        Container(
            height: 30.h,
            width: 410,
            padding: const EdgeInsets.only(right: 58),
            child: TabBarView(
              controller: tabController,
              children: [travelAll(), travelLatest(), travelPopular()],
            )),
          ],
        ),
      ),
    );
  }

  Obx travelPopular() {
    return  Obx(()=>
     ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: FireStoreController.travelPopularList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    travelPopular: FireStoreController.travelPopularList[index],
                    isPopular: true,
                    isLatest: false,
                    isAll: false,
                    isSearch: false,
                  )));
            },
            child:CustomCachedNetworkImage(
              imageUrl: FireStoreController.travelPopularList[index].image!,
              height:10.h ,
              width:70.w ,
              child: Stack(
                children: [
                  CustomBookmarkIcon(
                      child: IconButton(
                        onPressed: () {
                          if (FireStoreController.travelPopularList[index].isSelected!) {
                            setState(() {
                              FireStoreController.travelPopularList[index].isSelected =
                              !FireStoreController.travelPopularList[index].isSelected!;
                              FireStoreController.insertSave({
                                'image' :FireStoreController.travelPopularList[index].image!,
                                'location':FireStoreController.travelPopularList[index].location,
                                'place':FireStoreController.travelPopularList[index].place,
                                'price':FireStoreController.travelPopularList[index].price,
                                'isSelected':FireStoreController.travelPopularList[index].isSelected
                              });
                            });
                          } else {
                            setState(() {
                              FireStoreController.travelPopularList[index].isSelected =
                              !FireStoreController.travelPopularList[index].isSelected!;
                              FireStoreController.deleteSave(FireStoreController.saveList[index].id!);

                            });
                          }
                        },
                        icon: FireStoreController.travelPopularList[index].isSelected!
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
                        child: CustomWidgetsText.text(FireStoreController.travelPopularList[index].place!,
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
                            CustomWidgetsText.text(FireStoreController.travelPopularList[index].location!,
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
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 15,
          );
        },
      ),
    );
  }

  Obx travelLatest() {
    return  Obx(()=>
     ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: FireStoreController.travellatestList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    travelLatest: FireStoreController.travellatestList[index],
                    isPopular: false,
                    isLatest: true,
                    isAll: false,
                    isSearch: false,
                  )));
            },
            child:CustomCachedNetworkImage(
                imageUrl: FireStoreController.travellatestList[index].image!,
                height:10.h ,
                width:70.w ,
                child: Stack(
                  children: [
                    CustomBookmarkIcon(
                        child: IconButton(
                          onPressed: () {
                            if (FireStoreController.travellatestList[index].isSelected!) {
                              setState(() {
                                FireStoreController.travellatestList[index].isSelected =
                                !FireStoreController.travellatestList[index].isSelected!;
                               // saveList.add(FireStoreController.travellatestList[index]);
                                FireStoreController.insertSave({
                                  'image' :FireStoreController.travellatestList[index].image!,
                                  'location':FireStoreController.travellatestList[index].location,
                                  'place':FireStoreController.travellatestList[index].place,
                                  'price':FireStoreController.travellatestList[index].price,
                                  'isSelected':FireStoreController.travellatestList[index].isSelected
                                });
                              });
                            }
                            else {
                              setState(() {
                                FireStoreController.travellatestList[index].isSelected =
                                !FireStoreController.travellatestList[index].isSelected!;
                               // FireStoreController.saveList.remove(FireStoreController.travellatestList[index]);
                                FireStoreController.deleteSave(FireStoreController.saveList[index].id!);
                              });
                            }
                          },
                          icon: FireStoreController.travellatestList[index].isSelected!
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
                          color: Colors.black38,
                          width: 70.w,
                          padding: const EdgeInsets.only(bottom: 3,left: 20),
                          child: CustomWidgetsText.text(FireStoreController.travellatestList[index].place!,
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
                              CustomWidgetsText.text(FireStoreController.travellatestList[index].location!,
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
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 15,
          );
        },
      ),
    );
  }

  Obx travelAll() {
    return Obx(()=>
      ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: FireStoreController.allPlace.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        alldata: FireStoreController.allPlace[index],
                        isPopular: false,
                        isLatest: false,
                        isAll: true,
                        isSearch: false,
                      )));
            },
            child: CustomCachedNetworkImage(
                imageUrl: FireStoreController.allPlace[index].image!,
                height:10.h ,
                width:70.w ,
                child: Stack(
                  children: [
                    CustomBookmarkIcon(
                        child: IconButton(
                          onPressed: () {
                            if (FireStoreController.allPlace[index].isSelected!) {
                              setState(() {
                                FireStoreController.allPlace[index].isSelected =
                                !FireStoreController.allPlace[index].isSelected!;
                                FireStoreController.insertSave({
                                  'image' :FireStoreController.allPlace[index].image!,
                                  'location':FireStoreController.allPlace[index].location,
                                  'place':FireStoreController.allPlace[index].place,
                                  'price':FireStoreController.allPlace[index].price,
                                  'isSelected':FireStoreController.allPlace[index].isSelected
                                });
                              });
                            } else {
                              setState(() {
                                FireStoreController.allPlace[index].isSelected =
                                !FireStoreController.allPlace[index].isSelected!;
                                FireStoreController.deleteSave(FireStoreController.saveList[index].id!);
                              });
                            }
                          },
                          icon: FireStoreController.allPlace[index].isSelected!
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
                          child: CustomWidgetsText.text(FireStoreController.allPlace[index].place!,
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
                              CustomWidgetsText.text(FireStoreController.allPlace[index].location!,
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
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 15,
           );
        },
      ),
    );
  }
}
