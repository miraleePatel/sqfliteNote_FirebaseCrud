import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Constants/constants.dart';
import '../Utils/app_color.dart';
import '../Widgets/custom_search_filter.dart';
import '../Widgets/custom_widget_bookmark_icon.dart';
import '../Widgets/custom_widget_cachednetworkimage.dart';
import '../Widgets/custom_widget_text.dart';
import 'details_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<String> litems = ["All", "Popular", "Latest"];
  // Initialize to -1 so that none are selected
  // If you want to select the first by default you could change this to 0


  @override
  void initState() {

    setState(() {
      user!.photoURL;
    });
    super.initState();
    FireStoreController.showAll();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchFiletrWidget(),

            ///********************* Button List *************************************
            Container(
              height: 70,
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 5),
              margin: EdgeInsets.only(bottom: 20),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: litems.length,
                  itemBuilder: (context, index) {
                    final pressAttention = pressedAttentionIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          pressedAttentionIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        alignment: Alignment.center,
                        height: 30,
                        width: 20.w,
                        decoration: BoxDecoration(
                            color: pressAttention
                                ? AppColors.iconcyanshade600
                                : AppColors.icongreyshade200,
                            borderRadius: BorderRadius.circular(20)),
                        child: CustomWidgetsText.text(litems[index],
                            color: pressAttention
                                ? AppColors.textWhiteColor
                                : AppColors.textgrey),
                      ),
                    );
                  }),
            ),

            ///***************************** Location List **********************************************

            pressedAttentionIndex == 0
                ? Obx(()=>
                   Container(
              height: 60.h,
              width: double.infinity,
              margin: EdgeInsets.only(left: 20,right: 20),
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
                  itemCount: FireStoreController.allPlace.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              alldata: FireStoreController.allPlace[index],
                              isAll: true,
                              isLatest: false,
                              isPopular: false,
                            )));
                      },
                      child: CustomCachedNetworkImage(
                          imageUrl: FireStoreController.allPlace[index].image!,
                          height: 20.h ,
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
              ),
            ),
                )
                : pressedAttentionIndex == 1
                    ?
                    ///******************* popular **************************
            Container(
              height: 72.h,
              width: double.infinity,
              margin: EdgeInsets.only(left: 20,right: 20),
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
                itemCount: FireStoreController.travelPopularList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            travelPopular: FireStoreController.travelPopularList[index],
                            isAll: false,
                            isLatest: false,
                            isPopular: true,
                          )));
                    },
                    child: CustomCachedNetworkImage(
                        imageUrl: FireStoreController.travelPopularList[index].image!,
                        height: 20.h ,
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
              ),
            )
                    :
                    ///************************** Latest **************************************
            Container(
              height: 72.h,
              width: double.infinity,
              margin: EdgeInsets.only(left: 20,right: 20),
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
                itemCount: FireStoreController.travellatestList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            travelLatest: FireStoreController.travellatestList[index],
                            isAll: false,
                            isLatest: true,
                            isPopular: false,
                          )));
                    },
                    child:  CustomCachedNetworkImage(
                        imageUrl: FireStoreController.travellatestList[index].image!,
                        height: 20.h ,
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
                                        FireStoreController.insertSave({
                                          'image' :FireStoreController.travellatestList[index].image!,
                                          'location':FireStoreController.travellatestList[index].location,
                                          'place':FireStoreController.travellatestList[index].place,
                                          'price':FireStoreController.travellatestList[index].price,
                                          'isSelected':FireStoreController.travellatestList[index].isSelected
                                        });
                                      });
                                    } else {
                                      setState(() {
                                        FireStoreController.travellatestList[index].isSelected =
                                        !FireStoreController.travellatestList[index].isSelected!;
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
              ),
            ),

            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
