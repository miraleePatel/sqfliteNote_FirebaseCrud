import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
import '../Screens/details_page.dart';
import '../Utils/app_color.dart';
import 'custom_widget_cachednetworkimage.dart';
import 'custom_widget_text.dart';
import 'custom_widget_textformfield.dart';

class SearchFiletrWidget extends StatefulWidget {
  const SearchFiletrWidget({Key? key}) : super(key: key);

  @override
  State<SearchFiletrWidget> createState() => _SearchFiletrWidgetState();
}

class _SearchFiletrWidgetState extends State<SearchFiletrWidget> {
  TextEditingController searchcontroller = TextEditingController();
  final List<String> typelitems = ["Tour", "Adventure", "Countries"];
  final List<String> locationlitems1 = [
    "All",
    "Uttrakhand",
    "Maldives",
    "Thailand",
  ];
  bool pressAttentionAll = false;
  bool pressAttentionUtrakhand = false;
  bool pressAttentionMaldives = false;
  bool pressAttentionThailand = false;

  // Initialize to -1 so that none are selected
  // If you want to select the first by default you could change this to 0
  int locationIndex = -1;
  bool isShow = false;
  bool isOpen = false;
  final List _allUsers = List.from(FireStoreController.travellatestList)..addAll(FireStoreController.travelPopularList);

  // This list holds the data for the list view
  List _foundUsers = [];

  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers.addAll(_allUsers);
    super.initState();
  }

  /// This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List results = List.filled(0, "0", growable: true);
    List results1 = List.filled(0, "0", growable: true);
    if (enteredKeyword.isEmpty) {
      /// if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user.place.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      results1 = _allUsers
          .where((user) => user.location
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers = results + results1;
    });
  }

  List foundPeople = [];
  void findPersonUsingWhere(List find, String personName) {
    /// Return list of people matching the condition
    foundPeople = find.where((element) => element.place == personName).toList();

    if (foundPeople.isNotEmpty) {
      if (kDebugMode) {
        print('Using where: ${foundPeople.length}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomWidgetTextFormfeild(
                  obscureText: false,
                  controller: searchcontroller,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => _runFilter(value),
                  onTap: () {
                    setState(() {
                      isShow = true;
                      showSheet();
                    });
                  },
                  suffixIcon: IconButton(
                  color: AppColors.iconcyanshade600,
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
              ///************************ Filter *****************************
              GestureDetector(
                onTap: (){
                  _openSheet();
                  isShow=true;
                },
                child: Container(
                  height: 45,
                  width: 12.w,
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: AppColors.buttoncyanshade600,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: const Icon(Icons.tune,color: AppColors.iconWhiteColor,),),
              )
            ],
          ),
        ),
        isShow
            ? showSheet()
            : Container()
      ],
    );
  }

  Container showSheet() {
    return Container(
      height: 65.h,
      width: 85.w,
      margin: const EdgeInsets.only(top: 30),
      child:
      locationIndex == 0
          ? ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount:
        _foundUsers.isEmpty == null ? 0 : _foundUsers.length,
        itemBuilder: (context, index) =>
            Container(
              height: 16.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        searchData: _foundUsers[index],
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
                        // //  strokeAlign: StrokeAlign.inside
                      ),
                      borderRadius: BorderRadius.circular(20),//<-- SEE HERE
                    ),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      CustomCachedNetworkImage(
                        imageUrl: _foundUsers[index].image!,
                      ),
                        Padding(
                          padding: const EdgeInsets.only(top: 13,left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomWidgetsText.text(
                                  _foundUsers[index].place!,
                                  color: AppColors.textBalckColor,
                                  fontSize: 15),
                              Row(
                                children: [
                                  Icon(Icons.location_on,color: AppColors.textgrey,size: 15,),
                                  CustomWidgetsText.text(_foundUsers[index].location!,
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
          : locationIndex == 1
          ? ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: foundPeople.isEmpty == null
            ? 0
            : foundPeople.length,
        itemBuilder: (context, index) => Container(
          height: 16.h,
          child: GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => DetailsPage(
              //       searchData: _foundUsers[index],
              //       isPopular: false,
              //       isLatest: false,
              //       isAll: false,
              //       isSave: false,
              //       isSearch: true,
              //     )));
            },
            child: Card(
                color: Colors.grey.shade100,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: AppColors.bordercyanshade600,
                     //  strokeAlign: StrokeAlign.inside
                  ),
                  borderRadius: BorderRadius.circular(20), //<-- SEE HERE
                ),
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCachedNetworkImage(imageUrl:  foundPeople[index].image!),
                    Padding(
                      padding: const EdgeInsets.only(top: 13,left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomWidgetsText.text(
                              foundPeople[index].place!,
                              color: AppColors.textBalckColor,
                              fontSize: 15),
                          Row(
                            children: [
                              Icon(Icons.location_on,color: AppColors.textgrey,size: 15,),
                              CustomWidgetsText.text(foundPeople[index].location!,
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
          : locationIndex == 2
          ?  ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: foundPeople.isEmpty == null
            ? 0
            : foundPeople.length,
        itemBuilder: (context, index) => Container(
          height: 16.h,
          child: GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => DetailsPage(
              //       searchData: _foundUsers[index],
              //       isPopular: false,
              //       isLatest: false,
              //       isAll: false,
              //       isSave: false,
              //       isSearch: true,
              //     )));
            },
            child: Card(
                color: Colors.grey.shade100,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: AppColors.bordercyanshade600,
                     //  strokeAlign: StrokeAlign.inside
                  ),
                  borderRadius: BorderRadius.circular(20), //<-- SEE HERE
                ),
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCachedNetworkImage(imageUrl:  foundPeople[index].image!),
                    Padding(
                      padding: const EdgeInsets.only(top: 13,left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomWidgetsText.text(
                              foundPeople[index].place!,
                              color: AppColors.textBalckColor,
                              fontSize: 15),
                          Row(
                            children: [
                              Icon(Icons.location_on,color: AppColors.textgrey,size: 15,),
                              CustomWidgetsText.text(foundPeople[index].location!,
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
          : locationIndex == 3
          ?  ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: foundPeople.isEmpty == null
            ? 0
            : foundPeople.length,
        itemBuilder: (context, index) => Container(
          height: 16.h,
          child: GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => DetailsPage(
              //       searchData: _foundUsers[index],
              //       isPopular: false,
              //       isLatest: false,
              //       isAll: false,
              //       isSave: false,
              //       isSearch: true,
              //     )));
            },
            child: Card(
                color: Colors.grey.shade100,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: AppColors.bordercyanshade600,
                     //  strokeAlign: StrokeAlign.inside
                  ),
                  borderRadius: BorderRadius.circular(20), //<-- SEE HERE
                ),
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCachedNetworkImage(imageUrl:  foundPeople[index].image!),
                    Padding(
                      padding: const EdgeInsets.only(top: 13,left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomWidgetsText.text(
                              foundPeople[index].place!,
                              color: AppColors.textBalckColor,
                              fontSize: 15),
                          Row(
                            children: [
                              Icon(Icons.location_on,color: AppColors.textgrey,size: 15,),
                              CustomWidgetsText.text(foundPeople[index].location!,
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
          : _foundUsers.isNotEmpty
          ? ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount:
        _foundUsers.isEmpty == null ? 0 : _foundUsers.length,
        itemBuilder: (context, index) =>
            Container(
              height: 16.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        searchData: _foundUsers[index],
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
                        CustomCachedNetworkImage(imageUrl:_foundUsers[index].image!),
                        Padding(
                          padding: const EdgeInsets.only(top: 13,left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomWidgetsText.text(
                                  _foundUsers[index].place!,
                                  color: AppColors.textBalckColor,
                                  fontSize: 15),
                              Row(
                                children: [
                                  Icon(Icons.location_on,color: AppColors.textgrey,size: 15,),
                                  CustomWidgetsText.text(_foundUsers[index].location!,
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

  void _openSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///******************* Places *********************************
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 3.h,vertical: 3.h),
                child: CustomWidgetsText.text("Places",
                    fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
              Container(
                  height: 40.h,
                  width: 100.w,
                  padding: const EdgeInsets.only(bottom: 50),
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // crossAxisSpacing:20 ,
                          childAspectRatio:3.0,
                          mainAxisSpacing: 7.0,
                          crossAxisSpacing: 7.0
                      ),
                      itemCount: locationlitems1.length,
                      itemBuilder: (context, index) {
                        final pressAttention = locationIndex == index;
                        return Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          alignment: Alignment.center,
                          height: 2.h,
                          width: 27.w,
                          decoration: BoxDecoration(
                              color: pressAttention
                                  ? AppColors.iconcyanshade600
                                  : AppColors.icongreyshade200,
                              borderRadius: BorderRadius.circular(20)),
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                locationIndex = index;
                              });

                              if (locationIndex == 0) {
                                setState(() {
                                  locationIndex = 0;
                                  Navigator.of(context).pop();
                                });
                              } else if (locationIndex == 1) {
                                setState(() {
                                  locationIndex = 1;
                                  findPersonUsingWhere(
                                      _foundUsers, 'Uttrakhand');
                                  Navigator.of(context).pop();
                                });
                              } else if (locationIndex == 2) {
                                setState(() {
                                  locationIndex = 2;
                                  findPersonUsingWhere(
                                      _foundUsers, 'Maldives');
                                  Navigator.of(context).pop();
                                });
                              }else if (locationIndex == 3) {
                                setState(() {
                                  locationIndex = 3;
                                  findPersonUsingWhere(
                                      _foundUsers, 'Thailand');
                                  Navigator.of(context).pop();
                                });
                              }
                              else {
                                setState(() {
                                  isOpen = !isOpen;
                                  Navigator.of(context).pop();
                                });
                              }
                            },
                            child: CustomWidgetsText.text(
                                locationlitems1[index],
                                color: pressAttention
                                    ? AppColors.textWhiteColor
                                    : AppColors.textgrey),
                          ),
                        );
                      })),
            ],
          );
        }
        );
  }
}
