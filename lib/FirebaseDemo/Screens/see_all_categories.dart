import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Constants/constants.dart';
import '../Utils/app_color.dart';
import '../Widgets/custom_widget_bookmark_icon.dart';
import '../Widgets/custom_widget_cachednetworkimage.dart';
import '../Widgets/custom_widget_text.dart';
import '../Widgets/custom_widgets.dart';
import 'details_page.dart';

class SeeAllCategories extends StatefulWidget {
  const SeeAllCategories({Key? key}) : super(key: key);

  @override
  State<SeeAllCategories> createState() => _SeeAllCategoriesState();
}

class _SeeAllCategoriesState extends State<SeeAllCategories> {
  bool isSelected = true;
  TextEditingController searchcontroller = TextEditingController();
  final List<String> litems = ["All", "Mountain", "Lake", "Beach"];

  // Initialize to -1 so that none are selected
  // If you want to select the first by default you could change this to 0
  int pressedAttentionIndex = 0;
  List found = List.from(FireStoreController.topCategoriesList);
  final List _allUsers = List.from(FireStoreController.topCategoriesList);
  bool isShow = false;
  // This list holds the data for the list view
  List _foundUsers = [];
  List _foundUsers1 = [];

  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers.addAll(_allUsers);
    _foundUsers1.addAll(_allUsers);
    FireStoreController.selectTopcategories();
    super.initState();
  }

  /// This function is called whenever the text field changes
  void _findLocation(String enteredKeyword) {
    List results = List.filled(0, "0", growable: true);
    List results1 = List.filled(0, "0", growable: true);

    if (enteredKeyword.isEmpty) {
      /// if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user.location
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
      results1 = _allUsers
          .where((user) => user.place
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers = results;
      _foundUsers1 = results + results1;
    });
    if (_foundUsers.isNotEmpty) {
          if (kDebugMode) {
           setState(() {
             print('Using where: ${_foundUsers.length}');
           });
          }
        }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CustomWidgets.backIcon(context: context),
                    ),
                  ],
                ),
                ///*************** Search ***********************
                Container(
                  height: 5.5.h,
                  width: 90.w,
                  margin: EdgeInsets.only(left: 20,top: 30),
                  decoration: BoxDecoration(
                      color: AppColors.icongreyshade200,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: searchcontroller,
                    keyboardType: TextInputType.text,
                    onChanged: (value) => _findLocation(value),
                    onTap: () {
                      setState(() {
                        isShow = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search..",
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isShow = false;
                            searchcontroller.clear();
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
                 isShow ? showSheet() :
            ///************************** Button List *********************************
            Container(
                      height: 8.h,
                      width: 100.w,
                  margin: EdgeInsets.only(left: 20),
                       padding: EdgeInsets.only(left: 10),
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
                                if (pressedAttentionIndex == 1) {
                                  setState(() {
                                    pressedAttentionIndex = 1;
                                    _findLocation('Mountain');
                                  });
                                }
                                else if (pressedAttentionIndex == 2) {
                                  setState(() {
                                    pressedAttentionIndex = 2;
                                    _findLocation('Lake');
                                  });
                                }
                                else if (pressedAttentionIndex == 3) {
                                  setState(() {
                                    pressedAttentionIndex = 3;
                                    _findLocation('Beach');
                                  });
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 20, left: 20),
                                alignment: Alignment.center,
                                height: 4.h,
                                width: 23.w,
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

                    ///********************************* Location List *********************
                    pressedAttentionIndex==0 ?
                    Container(
                      height: 110.h,
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
                        itemCount: FireStoreController.topCategoriesList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    searchData: FireStoreController.topCategoriesList[index],
                                    isPopular: false,
                                    isLatest: false,
                                    isAll: false,
                                    isSave: false,
                                    isSearch: true,
                                  )));
                            },
                            child:
                            CustomCachedNetworkImage(
                                imageUrl:FireStoreController.topCategoriesList[index].image!,
                                height: 40.h,
                                width: 75.w,
                                child: Stack(
                                  children: [
                                    CustomBookmarkIcon(
                                      child: IconButton(
                                        onPressed: () {
                                          if (FireStoreController.topCategoriesList[index].isSelected!) {
                                            setState(() {
                                              FireStoreController.topCategoriesList[index].isSelected =
                                              !FireStoreController.topCategoriesList[index].isSelected!;
                                              FireStoreController.insertSave({
                                                'image' :FireStoreController.topCategoriesList[index].image!,
                                                'location':FireStoreController.topCategoriesList[index].location,
                                                'place':FireStoreController.topCategoriesList[index].place,
                                                'price':FireStoreController.topCategoriesList[index].price,
                                                'isSelected':FireStoreController.topCategoriesList[index].isSelected
                                              });
                                            });
                                          } else {
                                            setState(() {
                                              FireStoreController.topCategoriesList[index].isSelected =
                                              !FireStoreController.topCategoriesList[index].isSelected!;
                                              FireStoreController.deleteSave(FireStoreController.saveList[index].id!);
                                            });
                                          }
                                        },
                                        icon: FireStoreController.topCategoriesList[index].isSelected!
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
                                          child: CustomWidgetsText.text(FireStoreController.topCategoriesList[index].place!,
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
                                              CustomWidgetsText.text(FireStoreController.topCategoriesList[index].location!,
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
                        : pressedAttentionIndex==1 ?
                    Container(
                      height: 50.h,
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
                        itemCount: _foundUsers.length,
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
                                imageUrl:_foundUsers[index].image!,
                                height: 40.h,
                                width: 75.w,
                                child:Stack(
                                  children: [
                                    CustomBookmarkIcon(
                                      child:  IconButton(
                                        onPressed: () {
                                          if (_foundUsers[index].isSelected!) {
                                            setState(() {
                                              _foundUsers[index].isSelected =
                                              !_foundUsers[index].isSelected!;
                          FireStoreController.insertSave({
                          'image' : _foundUsers[index][index].image!,
                          'location': _foundUsers[index][index].location,
                          'place': _foundUsers[index][index].place,
                          'price': _foundUsers[index][index].price,
                          'isSelected': _foundUsers[index][index].isSelected
                          });
                                            });
                                          } else {
                                            setState(() {
                                              _foundUsers[index].isSelected =
                                              !_foundUsers[index].isSelected!;
                          FireStoreController.deleteSave(FireStoreController.saveList[index].id!);

                          });
                                          }
                                        },
                                        icon: _foundUsers[index].isSelected!
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
                                          child: CustomWidgetsText.text(_foundUsers[index].place!,
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
                                              CustomWidgetsText.text(_foundUsers[index].location!,
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
                    ) : pressedAttentionIndex==2 ?
                    Container(
                      height: 50.h,
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
                        itemCount: _foundUsers.length,
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
                                  imageUrl:_foundUsers[index].image!,
                                  height: 40.h,
                                  width: 75.w,
                                  child:Stack(
                                    children: [
                                      CustomBookmarkIcon(
                                        child:  IconButton(
                                          onPressed: () {
                                            if (_foundUsers[index].isSelected!) {
                                              setState(() {
                                                _foundUsers[index].isSelected =
                                                !_foundUsers[index].isSelected!;
                                                FireStoreController.insertSave({
                                                  'image' : _foundUsers[index][index].image!,
                                                  'location': _foundUsers[index][index].location,
                                                  'place': _foundUsers[index][index].place,
                                                  'price': _foundUsers[index][index].price,
                                                  'isSelected': _foundUsers[index][index].isSelected
                                                });
                                              });
                                            } else {
                                              setState(() {
                                                _foundUsers[index].isSelected =
                                                !_foundUsers[index].isSelected!;
                                                FireStoreController.deleteSave(FireStoreController.saveList[index].id!);

                                              });
                                            }
                                          },
                                          icon: _foundUsers[index].isSelected!
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
                                            child: CustomWidgetsText.text(_foundUsers[index].place!,
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
                                                CustomWidgetsText.text(_foundUsers[index].location!,
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
                    )  :pressedAttentionIndex==3 ?
                    Container(
                      height: 75.h,
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
                        itemCount: _foundUsers.length,
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
                                  imageUrl:_foundUsers[index].image!,
                                  height: 40.h,
                                  width: 75.w,
                                  child:Stack(
                                    children: [
                                      CustomBookmarkIcon(
                                        child:  IconButton(
                                          onPressed: () {
                                            if (_foundUsers[index].isSelected!) {
                                              setState(() {
                                                _foundUsers[index].isSelected =
                                                !_foundUsers[index].isSelected!;
                                                FireStoreController.insertSave({
                                                  'image' : _foundUsers[index][index].image!,
                                                  'location': _foundUsers[index][index].location,
                                                  'place': _foundUsers[index][index].place,
                                                  'price': _foundUsers[index][index].price,
                                                  'isSelected': _foundUsers[index][index].isSelected
                                                });
                                              });
                                            } else {
                                              setState(() {
                                                _foundUsers[index].isSelected =
                                                !_foundUsers[index].isSelected!;
                                                FireStoreController.deleteSave(FireStoreController.saveList[index].id!);

                                              });
                                            }
                                          },
                                          icon: _foundUsers[index].isSelected!
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
                                            child: CustomWidgetsText.text(_foundUsers[index].place!,
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
                                                CustomWidgetsText.text(_foundUsers[index].location!,
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
                    )  : Container(),

              ],
            ),
          ))

    );
  }
  Container showSheet() {
    return Container(
      height: 100.h,
      width: 85.w,
      margin: const EdgeInsets.only(left: 30),
      child:
     _foundUsers1.isNotEmpty
          ? ListView.builder(
        physics: NeverScrollableScrollPhysics(),
       scrollDirection: Axis.vertical,
       itemCount:
       _foundUsers1.isEmpty == null ? 0 : _foundUsers1.length,
       itemBuilder: (context, index) =>
           Container(
             height: 16.h,
             child: GestureDetector(
               onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(
                     builder: (context) => DetailsPage(
                       searchData: _foundUsers1[index],
                       isPopular: false,
                       isLatest: false,
                       isAll: false,
                       isSave: false,
                       isSearch: true,
                     )));
               },
               child: Card(
                   color: Colors.grey.shade100,
                   elevation:10,
                   shape: RoundedRectangleBorder(
                     side: BorderSide(
                         color: AppColors.bordercyanshade600,
                        //  strokeAlign: StrokeAlign.inside
                     ),
                     borderRadius: BorderRadius.circular(20),//<-- SEE HERE
                   ),
                   margin: EdgeInsets.only(bottom: 20),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     //  mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CustomCachedNetworkImage(imageUrl:_foundUsers1[index].image!),
                       Padding(
                         padding: const EdgeInsets.only(top: 13,left: 20),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             CustomWidgetsText.text(
                                 _foundUsers1[index].place!,
                                 color: AppColors.textBalckColor,
                                 fontSize: 15),
                             Row(
                               children: [
                                 Icon(Icons.location_on,color: AppColors.textgrey,size: 15,),
                                 CustomWidgetsText.text(_foundUsers1[index].location!,
                                     color: AppColors.textgrey,fontSize: 8.sp)
                               ],
                             ),
                           ],
                         ),
                       ),
                     ],
                   )),
             ),
           ),
     )
          : Center(
        child: CustomWidgetsText.text(
            'No results found'),
      ),
    );
  }
}
