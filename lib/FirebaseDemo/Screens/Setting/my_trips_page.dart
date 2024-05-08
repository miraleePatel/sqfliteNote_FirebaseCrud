import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_demo/Screens/book_now_page.dart';
import '../../Constants/constants.dart';
import '../../Utils/app_color.dart';
import '../../Widgets/custom_widget_button.dart';
import '../../Widgets/custom_widget_text.dart';
import '../../Widgets/custom_widgets.dart';

class MyTripsPage extends StatefulWidget {
  const MyTripsPage({Key? key}) : super(key: key);

  @override
  State<MyTripsPage> createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  @override
  void initState() {
    // TODO: implement initState
    FireStoreController.selectBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            //  physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildRow(context),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                      height: 88.h,
                      width: 100.w,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: AppColors.textWhiteColor),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Obx(
                          () => ListView.builder(
                              itemCount: FireStoreController.bookList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => BookNowPage(
                                                  Data: FireStoreController
                                                      .bookList[index],
                                                  isUpdate: true,
                                                )));
                                    // Navigator.of(context).pop();
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 17.h,
                                        width: 90.w,
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                            color: AppColors.icongreyshade200,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: FireStoreController
                                                    .bookList[index].image!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  height: 12.h,
                                                  width: 12.h,
                                                  margin: EdgeInsets.only(
                                                      left: 15, right: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.teal,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill)),
                                                ),
                                                placeholder: (context, url) =>
                                                    Container(
                                                        height: 17.h,
                                                        width: 90.w,
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              AppColors.bgColor,
                                                        )),
                                                // placeholderFadeInDuration: Duration(seconds: 1),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomWidgetsText.text(
                                                    FireStoreController
                                                        .bookList[index].place,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 23),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 15,
                                                          color: AppColors
                                                              .iconcyanshade600,
                                                        ),
                                                        CustomWidgetsText.text(
                                                            FireStoreController
                                                                .bookList[index]
                                                                .location,
                                                            color: AppColors
                                                                .textgrey,
                                                            fontSize: 8.sp)
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 30,
                                                            left: 3),
                                                    child: CustomWidgetsText.text(
                                                        "\$${FireStoreController.bookList[index].total.toString()}",
                                                        fontSize: 10.sp,
                                                        color: AppColors
                                                            .textCyan600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 310,
                                        top: 10,
                                        right: 10,
                                        child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    elevation: 50,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    title:
                                                        CustomWidgetsText.text(
                                                            "Cancel Booking",
                                                            color: AppColors
                                                                .textCyan600,
                                                            fontSize: 15),
                                                    content:
                                                        CustomWidgetsText.text(
                                                      "Are you sure want to cancel booking?",
                                                      color: AppColors.textgrey,
                                                    ),
                                                    actions: [
                                                      CustomButton(
                                                          height: 4.h,
                                                          width: 20.w,
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: CustomWidgetsText.text(
                                                              "No",
                                                              color: AppColors
                                                                  .textWhiteColor)),
                                                      CustomButton(
                                                          height: 4.h,
                                                          width: 20.w,
                                                          onPressed: () {
                                                            FireStoreController
                                                                .DeleteBook(
                                                                    FireStoreController
                                                                        .bookList[
                                                                            index]
                                                                        .id!);
                                                            setState(() {
                                                              FireStoreController
                                                                  .selectBook();
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: CustomWidgetsText.text(
                                                              "Yes",
                                                              color: AppColors
                                                                  .textWhiteColor)),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.close)),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(child: CustomWidgets.backIcon(context: context)),
          CustomWidgetsText.text("My Trip",
              fontSize: 15, color: AppColors.textWhiteColor),
          Container(
            width: 15.w,
          )
        ],
      ),
    );
  }
}
