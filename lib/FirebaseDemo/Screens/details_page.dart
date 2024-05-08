import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_demo/Screens/zoom_images.dart';
import '../Constants/constants.dart';
import '../Utils/app_color.dart';
import '../Utils/app_string.dart';
import '../Widgets/custom_widget_button.dart';
import '../Widgets/custom_widget_cachednetworkimage.dart';
import '../Widgets/custom_widget_text.dart';
import 'book_now_page.dart';

class DetailsPage extends StatefulWidget {
  bool? isAll;
  bool? isLatest;
  bool? isPopular;
  bool? isSave;
  bool? isSearch;
  var travelLatest;
 var travelPopular;
  var saveData;
  var alldata;
  var searchData;

  DetailsPage(
      {Key? key,
      this.isAll,
      this.isLatest,
      this.isPopular,
      this.alldata,
      this.travelPopular,
      this.travelLatest,
      this.isSave,
      this.saveData,
      this.isSearch,
      this.searchData})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TransformationController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
            child: Container(
          height: 13.h,
          width: 100.w,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                widget.isLatest!
                    ? CustomWidgetsText.text(
                        "\$ ${widget.travelLatest!.price.toString()}",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      )
                    : widget.isPopular!
                        ? CustomWidgetsText.text(
                            "\$ ${widget.travelPopular!.price.toString()}",
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          )
                        : widget.isAll!
                            ? CustomWidgetsText.text(
                                "\$ ${widget.alldata!.price.toString()}",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              )
                            : widget.isSave!
                                ? CustomWidgetsText.text(
                                    "\$ ${widget.saveData!.price.toString()}",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  )
                                : widget.isSearch!
                                    ? CustomWidgetsText.text(
                                        "\$ ${widget.searchData!.price.toString()}",
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      )
                                    : Text(""),
                CustomWidgetsText.text(
                  "\/package",
                ),
                CustomButton(
                  margin: const EdgeInsets.only(left: 50),
                  height: 6.h,
                  width: 40.w,
                  onPressed: () {
                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookNowPage()));
                    widget.isLatest!
                        ?  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookNowPage(
                        bookData: widget.travelLatest,
                      isUpdate: false,
                      )))
                        : widget.isPopular!
                        ?  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookNowPage(
                        isUpdate: false,
                        bookData: widget.travelPopular)))
                        : widget.isAll!
                        ?  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookNowPage(
                        isUpdate: false,
                        bookData: widget.alldata)))
                        : widget.isSave!
                        ?  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookNowPage(
                        isUpdate: false,
                        bookData: widget.saveData)))
                        : widget.isSearch!
                        ? Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookNowPage(
                        isUpdate: false,
                        bookData: widget.searchData))) :
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookNowPage(
                      )));

                  },
                  child: CustomWidgetsText.text(AppStrings.bookNow,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textWhiteColor),
                )
              ],
            ),
          ),
        )),
        body: widget.isLatest!
            ? Padding(
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
                            padding: const EdgeInsets.only(left: 25),
                            child: CircleAvatar(
                              backgroundColor: AppColors.icongreyshade200,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: AppColors.iconcyanshade600,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                          CustomWidgetsText.text("Details",
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textgrey),
                          Padding(
                            padding: const EdgeInsets.only(right: 35),
                            child: CircleAvatar(
                              backgroundColor: AppColors.icongreyshade200,
                              child: IconButton(
                                onPressed: () {
                                  // setState(() {
                                  //   travelPopularList[index].isSelected = !travelPopularList[index].isSelected!;
                                  // });
                                  if (widget.travelLatest!.isSelected!) {
                                    setState(() {
                                      widget.travelLatest!.isSelected =
                                          !widget.travelLatest!.isSelected!;
                                      FireStoreController.insertSave({
                                        'image' :widget.travelLatest.image!,
                                        'location':widget.travelLatest.location,
                                        'place':widget.travelLatest.place,
                                        'price':widget.travelLatest.price,
                                        'isSelected':widget.travelLatest.isSelected
                                      });
                                    });
                                  } else {
                                    setState(() {
                                      widget.travelLatest!.isSelected =
                                          !widget.travelLatest!.isSelected!;
                                    });
                                  }
                                },
                                icon: widget.travelLatest!.isSelected!
                                    ? Icon(
                                        Icons.bookmark_border,
                                        color: AppColors.iconcyanshade600,
                                      )
                                    : Icon(Icons.bookmark_outlined,
                                        color: AppColors.iconcyanshade600),
                              ),
                            ),
                          ),
                        ],
                      ),

                      ///******************* Latest Images *************************
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ZoomImages(
                                          latestImages:
                                              widget.travelLatest!.image!,
                                          isAll: false,
                                          isLatest: true,
                                          isPopular: false,
                                          isSave: false,
                                          isSearch: false,
                                        )));
                              },
                              child: Hero(
                                tag: 'latest_images',
                                child:
                                CustomCachedNetworkImage(
                                  imageUrl:widget.travelLatest!.image!,
                                  height: 25.h,
                                  width: 65.w,
                                )
                              ),
                            ),

                            /// ********************* Icon ******************************
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 5.h,
                                  width: 5.h,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan.shade100,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.other_houses,
                                    color: AppColors.iconcyanshade600,
                                  ),
                                ),
                                CustomWidgetsText.text("20 Place", fontSize: 9),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 5.h,
                                  width: 5.h,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan.shade100,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.watch_later,
                                    color: AppColors.iconcyanshade600,
                                  ),
                                ),
                                CustomWidgetsText.text("3 Week", fontSize: 9),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 5.h,
                                  width: 5.h,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan.shade100,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.more_vert,
                                    color: AppColors.iconcyanshade600,
                                  ),
                                ),
                                CustomWidgetsText.text("More", fontSize: 9),
                              ],
                            )
                          ],
                        ),
                      ),

                      ///****************************** Description *********************************************
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 30),
                        child: CustomWidgetsText.text(
                            widget.travelLatest!.place!,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.star,
                            color: Colors.yellow.shade700,
                          ),
                          label: CustomWidgetsText.text("4.5 (1045)",
                              color: AppColors.textgrey),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 30, right: 25),
                        child: CustomWidgetsText.text(
                            "Lorem ipsum is simply dummy text of the printing and typesetting industry",
                            color: AppColors.textgrey,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 40.h,
                        width: 85.w,
                        margin: const EdgeInsets.only(top: 30, left: 30),
                        decoration: BoxDecoration(
                            color: AppColors.textgreyshade200,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ],
                  ),
                ))
            : widget.isPopular!
                ? Padding(
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
                                padding: const EdgeInsets.only(left: 25),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.icongreyshade200,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: AppColors.iconcyanshade600,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ),
                              CustomWidgetsText.text("Details",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textgrey),
                              Padding(
                                padding: const EdgeInsets.only(right: 35),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.icongreyshade200,
                                  child: IconButton(
                                    onPressed: () {
                                      // setState(() {
                                      //   travelPopularList[index].isSelected = !travelPopularList[index].isSelected!;
                                      // });
                                      if (widget.travelPopular!.isSelected!) {
                                        setState(() {
                                          widget.travelPopular!.isSelected =
                                              !widget
                                                  .travelPopular!.isSelected!;
                                          FireStoreController.insertSave({
                                            'image' :widget.travelPopular.image!,
                                            'location':widget.travelPopular.location,
                                            'place':widget.travelPopular.place,
                                            'price':widget.travelPopular.price,
                                            'isSelected':widget.travelPopular.isSelected
                                          });
                                        });
                                      } else {
                                        setState(() {
                                          widget.travelPopular!.isSelected =
                                              !widget
                                                  .travelPopular!.isSelected!;

                                        });
                                      }
                                    },
                                    icon: widget.travelPopular!.isSelected!
                                        ? Icon(
                                            Icons.bookmark_border,
                                            color: AppColors.iconcyanshade600,
                                          )
                                        : Icon(Icons.bookmark_outlined,
                                            color: AppColors.iconcyanshade600),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///******************* Popular Images *************************
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ZoomImages(
                                                  popularImages: widget
                                                      .travelPopular!.image!,
                                                  isAll: false,
                                                  isLatest: false,
                                                  isPopular: true,
                                                  isSave: false,
                                                  isSearch: false,
                                                )));
                                  },
                                  child: Hero(
                                    tag: 'popular_image',
                                    child: CustomCachedNetworkImage(
                                      imageUrl:  widget.travelPopular!.image!,
                                      height: 25.h,
                                      width: 65.w,
                                    )
                                  ),
                                ),

                                /// ********************* Icon ******************************
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 5.h,
                                      width: 5.h,
                                      decoration: BoxDecoration(
                                        color: Colors.cyan.shade100,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Icon(
                                        Icons.other_houses,
                                        color: AppColors.iconcyanshade600,
                                      ),
                                    ),
                                    CustomWidgetsText.text("20 Place",
                                        fontSize: 9),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 5.h,
                                      width: 5.h,
                                      decoration: BoxDecoration(
                                        color: Colors.cyan.shade100,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Icon(
                                        Icons.watch_later,
                                        color: AppColors.iconcyanshade600,
                                      ),
                                    ),
                                    CustomWidgetsText.text("3 Week",
                                        fontSize: 9),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 5.h,
                                      width: 5.h,
                                      decoration: BoxDecoration(
                                        color: Colors.cyan.shade100,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Icon(
                                        Icons.more_vert,
                                        color: AppColors.iconcyanshade600,
                                      ),
                                    ),
                                    CustomWidgetsText.text("More", fontSize: 9),
                                  ],
                                )
                              ],
                            ),
                          ),

                          ///****************************** Description *********************************************
                          Padding(
                            padding: const EdgeInsets.only(top: 30, left: 30),
                            child: CustomWidgetsText.text(
                                widget.travelPopular!.place!,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.star,
                                color: Colors.yellow.shade700,
                              ),
                              label: CustomWidgetsText.text("4.5 (1045)",
                                  color: AppColors.textgrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 25),
                            child: CustomWidgetsText.text(
                                "Lorem ipsum is simply dummy text of the printing and typesetting industry",
                                color: AppColors.textgrey,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            height: 40.h,
                            width: 85.w,
                            margin: EdgeInsets.only(top: 30, left: 30),
                            decoration: BoxDecoration(
                                color: AppColors.textgreyshade200,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ],
                      ),
                    ))
                : widget.isAll!
                    ? Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          AppColors.icongreyshade200,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: AppColors.iconcyanshade600,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ),
                                  CustomWidgetsText.text("Details",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textgrey),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 35),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          AppColors.icongreyshade200,
                                      child: IconButton(
                                        onPressed: () {
                                          // setState(() {
                                          //   travelPopularList[index].isSelected = !travelPopularList[index].isSelected!;
                                          // });
                                          if (widget.alldata!.isSelected!) {
                                            setState(() {
                                              widget.alldata!.isSelected =
                                                  !widget.alldata!.isSelected!;
                                              FireStoreController.insertSave({
                                                'image' :widget.alldata.image!,
                                                'location':widget.alldata.location,
                                                'place':widget.alldata.place,
                                                'price':widget.alldata.price,
                                                'isSelected':widget.alldata.isSelected
                                              });
                                            });
                                          } else {
                                            setState(() {
                                              widget.alldata!.isSelected =
                                                  !widget.alldata!.isSelected!;
                                             });
                                          }
                                        },
                                        icon: widget.alldata!.isSelected!
                                            ? Icon(
                                                Icons.bookmark_border,
                                                color:
                                                    AppColors.iconcyanshade600,
                                              )
                                            : Icon(Icons.bookmark_outlined,
                                                color:
                                                    AppColors.iconcyanshade600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ///******************* AllData Images *************************
                              Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ZoomImages(
                                                      allImages: widget
                                                          .alldata!.image!,
                                                      isAll: true,
                                                      isLatest: false,
                                                      isPopular: false,
                                                      isSave: false,
                                                      isSearch: false,
                                                    )));
                                      },
                                      child: Hero(
                                        tag: 'all_images',
                                        child:CustomCachedNetworkImage(
                                          imageUrl: widget.alldata!.image!,
                                          height: 25.h,
                                          width: 65.w,
                                        )
                                      ),
                                    ),

                                    /// ********************* Icon ******************************
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 5.h,
                                          width: 5.h,
                                          decoration: BoxDecoration(
                                            color: Colors.cyan.shade100,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Icon(
                                            Icons.other_houses,
                                            color: AppColors.iconcyanshade600,
                                          ),
                                        ),
                                        CustomWidgetsText.text("20 Place",
                                            fontSize: 9),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 5.h,
                                          width: 5.h,
                                          decoration: BoxDecoration(
                                            color: Colors.cyan.shade100,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Icon(
                                            Icons.watch_later,
                                            color: AppColors.iconcyanshade600,
                                          ),
                                        ),
                                        CustomWidgetsText.text("3 Week",
                                            fontSize: 9),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 5.h,
                                          width: 5.h,
                                          decoration: BoxDecoration(
                                            color: Colors.cyan.shade100,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Icon(
                                            Icons.more_vert,
                                            color: AppColors.iconcyanshade600,
                                          ),
                                        ),
                                        CustomWidgetsText.text("More",
                                            fontSize: 9),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              ///****************************** Description *********************************************
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, left: 30),
                                child: CustomWidgetsText.text(
                                    widget.alldata!.place!,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.star,
                                    color: Colors.yellow.shade700,
                                  ),
                                  label: CustomWidgetsText.text("4.5 (1045)",
                                      color: AppColors.textgrey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 30, right: 25),
                                child: CustomWidgetsText.text(
                                    "Lorem ipsum is simply dummy text of the printing and typesetting industry",
                                    color: AppColors.textgrey,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                height: 40.h,
                                width: 85.w,
                                margin:
                                    const EdgeInsets.only(top: 30, left: 30),
                                decoration: BoxDecoration(
                                    color: AppColors.textgreyshade200,
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ],
                          ),
                        ))
                    : widget.isSave!
                        ? Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.icongreyshade200,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.arrow_back,
                                              color: AppColors.iconcyanshade600,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                      ),
                                      CustomWidgetsText.text("Details",
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textgrey),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 35),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.icongreyshade200,
                                          child: IconButton(
                                            onPressed: () {
                                              // setState(() {
                                              //   travelPopularList[index].isSelected = !travelPopularList[index].isSelected!;
                                              // });
                                              if (widget
                                                  .saveData!.isSelected!) {
                                                setState(() {
                                                  widget.saveData!.isSelected =
                                                      !widget.saveData!
                                                          .isSelected!;
                                                  FireStoreController.insertSave({
                                                    'image' :widget.saveData.image!,
                                                    'location':widget.saveData.location,
                                                    'place':widget.saveData.place,
                                                    'price':widget.saveData.price,
                                                    'isSelected':widget.saveData.isSelected
                                                  });
                                                });
                                              } else {
                                                setState(() {
                                                  widget.saveData!.isSelected =
                                                      !widget.saveData!
                                                          .isSelected!;

                                                });
                                              }
                                            },
                                            icon: widget.saveData!.isSelected!
                                                ? Icon(
                                                    Icons.bookmark_border,
                                                    color: AppColors
                                                        .iconcyanshade600,
                                                  )
                                                : Icon(Icons.bookmark_outlined,
                                                    color: AppColors
                                                        .iconcyanshade600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///******************* SaveData Images *************************
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ZoomImages(
                                                          saveImages: widget
                                                              .saveData!.image!,
                                                          isAll: false,
                                                          isLatest: false,
                                                          isPopular: false,
                                                          isSave: true,
                                                          isSearch: false,
                                                        )));
                                          },
                                          child: Hero(
                                            tag: 'save_images',
                                            child: CustomCachedNetworkImage(
                                              imageUrl: widget
                                                  .saveData!.image!,
                                              height: 25.h,
                                              width: 65.w,
                                            ),
                                          ),
                                        ),

                                        /// ********************* Icon ******************************
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 5.h,
                                              width: 5.h,
                                              decoration: BoxDecoration(
                                                color: Colors.cyan.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Icon(
                                                Icons.other_houses,
                                                color:
                                                    AppColors.iconcyanshade600,
                                              ),
                                            ),
                                            CustomWidgetsText.text("8 Place",
                                                fontSize: 9),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              height: 5.h,
                                              width: 5.h,
                                              decoration: BoxDecoration(
                                                color: Colors.cyan.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Icon(
                                                Icons.watch_later,
                                                color:
                                                    AppColors.iconcyanshade600,
                                              ),
                                            ),
                                            CustomWidgetsText.text("3 Week",
                                                fontSize: 9),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              height: 5.h,
                                              width: 5.h,
                                              decoration: BoxDecoration(
                                                color: Colors.cyan.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Icon(
                                                Icons.more_vert,
                                                color:
                                                    AppColors.iconcyanshade600,
                                              ),
                                            ),
                                            CustomWidgetsText.text("More",
                                                fontSize: 9),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                  ///****************************** Description *********************************************
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 30),
                                    child: CustomWidgetsText.text(
                                        widget.saveData!.place!,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: TextButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.star,
                                        color: Colors.yellow.shade700,
                                      ),
                                      label: CustomWidgetsText.text(
                                          "4.5 (1045)",
                                          color: AppColors.textgrey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 30, right: 25),
                                    child: CustomWidgetsText.text(
                                        "Lorem ipsum is simply dummy text of the printing and typesetting industry",
                                        color: AppColors.textgrey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    height: 40.h,
                                    width: 85.w,
                                    margin: const EdgeInsets.only(
                                        top: 30, left: 30),
                                    decoration: BoxDecoration(
                                        color: AppColors.textgreyshade200,
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ],
                              ),
                            ))
                        : Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.icongreyshade200,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.arrow_back,
                                              color: AppColors.iconcyanshade600,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                      ),
                                      CustomWidgetsText.text("Details",
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textgrey),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 35),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.icongreyshade200,
                                          child: IconButton(
                                            onPressed: () {
                                              // setState(() {
                                              //   travelPopularList[index].isSelected = !travelPopularList[index].isSelected!;
                                              // });
                                              if (widget
                                                  .searchData!.isSelected!) {
                                                setState(() {
                                                  widget.searchData!
                                                          .isSelected =
                                                      !widget.searchData!
                                                          .isSelected!;
                                                  FireStoreController.insertSave({
                                                    'image' :widget.searchData.image!,
                                                    'location':widget.searchData.location,
                                                    'place':widget.searchData.place,
                                                    'price':widget.searchData.price,
                                                    'isSelected':widget.searchData.isSelected
                                                  });
                                                });
                                              } else {
                                                setState(() {
                                                  widget.searchData!
                                                          .isSelected =
                                                      !widget.searchData!
                                                          .isSelected!;
                                                });
                                              }
                                            },
                                            icon: widget.searchData!.isSelected!
                                                ? Icon(
                                                    Icons.bookmark_border,
                                                    color: AppColors
                                                        .iconcyanshade600,
                                                  )
                                                : Icon(Icons.bookmark_outlined,
                                                    color: AppColors
                                                        .iconcyanshade600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///******************* Search Images *************************
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ZoomImages(
                                                          searchImages: widget
                                                              .searchData!
                                                              .image!,
                                                          isAll: false,
                                                          isLatest: false,
                                                          isPopular: false,
                                                          isSave: false,
                                                          isSearch: true,
                                                        )));
                                          },
                                          child: Hero(
                                            tag: 'search_images',
                                            child:
                                            CustomCachedNetworkImage(
                                              height: 25.h,
                                              width: 65.w,
                                              imageUrl: widget
                                                  .searchData!.image!,
                                            ),
                                          ),
                                        ),

                                        /// ********************* Icon ******************************
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 5.h,
                                              width: 5.h,
                                              decoration: BoxDecoration(
                                                color: Colors.cyan.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Icon(
                                                Icons.other_houses,
                                                color:
                                                    AppColors.iconcyanshade600,
                                              ),
                                            ),
                                            CustomWidgetsText.text("20 Place",
                                                fontSize: 9),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              height: 5.h,
                                              width: 5.h,
                                              decoration: BoxDecoration(
                                                color: Colors.cyan.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Icon(
                                                Icons.watch_later,
                                                color:
                                                    AppColors.iconcyanshade600,
                                              ),
                                            ),
                                            CustomWidgetsText.text("3 Week",
                                                fontSize: 9),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              height: 5.h,
                                              width: 5.h,
                                              decoration: BoxDecoration(
                                                color: Colors.cyan.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Icon(
                                                Icons.more_vert,
                                                color:
                                                    AppColors.iconcyanshade600,
                                              ),
                                            ),
                                            CustomWidgetsText.text("More",
                                                fontSize: 9),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                  ///****************************** Description *********************************************
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 30),
                                    child: CustomWidgetsText.text(
                                        widget.searchData!.place!,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: TextButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.star,
                                        color: Colors.yellow.shade700,
                                      ),
                                      label: CustomWidgetsText.text(
                                          "4.5 (1045)",
                                          color: AppColors.textgrey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 30, right: 25),
                                    child: CustomWidgetsText.text(
                                        "Lorem ipsum is simply dummy text of the printing and typesetting industry",
                                        color: AppColors.textgrey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    height: 40.h,
                                    width: 85.w,
                                    margin: const EdgeInsets.only(
                                        top: 30, left: 30),
                                    decoration: BoxDecoration(
                                        color: AppColors.textgreyshade200,
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ],
                              ),
                            )));
  }
}
