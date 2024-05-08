import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_demo/Controller/datepicker_controller.dart';
import '../Constants/constants.dart';
import '../Routes/routes.dart';
import '../Utils/app_color.dart';
import '../Widgets/custom_widget_button.dart';
import '../Widgets/custom_widget_text.dart';
import '../Widgets/custom_widgets.dart';

class BookNowPage extends StatefulWidget {
  var bookData;
  var Data;
  bool? isUpdate;
  BookNowPage({Key? key, this.bookData, this.Data, this.isUpdate})
      : super(key: key);

  @override
  State<BookNowPage> createState() => _BookNowPageState();
}

class _BookNowPageState extends State<BookNowPage> {
  num? getPrice;
  num? totalPrice;
  int person = 1;
  var selectDateController = Get.put(DateController());
  @override
  void initState() {
    super.initState();
    ShowUpdateData();
  }

  void ShowUpdateData() {
    if (widget.isUpdate == false) {
      getPrice = widget.bookData!.price!;
      totalPrice = (getPrice! - 10);
    } else {
      totalPrice = (widget.Data.price! - 10);
    }
  }

  void addPerson() {
    if(widget.isUpdate==false) {
    setState(() {
      person++;
      totalPrice = ((getPrice! * person) - 10);
    });}else{
      setState(() {
        widget.Data.person++;
        widget.Data.total = ((widget.Data.price! * widget.Data.person) - 10);
      });
    }
  }

  void removePerson() {
    if(widget.isUpdate==false) {
      if (person != 1) {
        setState(() {
          person--;
          totalPrice = ((getPrice! * person) - 10);
        });
      } else {
        setState(() {
          person = 1;
        });
      }
    }
    else{
      if (widget.Data.person != 1) {
        setState(() {
          widget.Data.person--;
          widget.Data.total = ((widget.Data.price! * widget.Data.person) - 10);
        });
      } else {
        setState(() {
          widget.Data.person = 1;
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
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomWidgets.backIcon(context: context),
                        CustomWidgetsText.text("Checkout",
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textgrey),
                        CircleAvatar(
                          backgroundColor: AppColors.icongreyshade200,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.close,
                                color: AppColors.iconcyanshade600,
                              )),
                        ),
                      ],
                    ),

                    ///********************* Location Details ***************************************
                    Center(
                      child: Container(
                        height: 17.h,
                        width: 90.w,
                        margin: EdgeInsets.only(top: 40),
                        decoration: BoxDecoration(
                            color: AppColors.icongreyshade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: widget.isUpdate == false
                                  ? widget.bookData.image!
                                  : widget.Data.image!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 12.h,
                                width: 12.h,
                                margin: EdgeInsets.only(left: 15, right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.teal,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill)),
                              ),
                              placeholder: (context, url) => Container(
                                  height: 17.h,
                                  width: 90.w,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    color: AppColors.bgColor,
                                  )),
                              // placeholderFadeInDuration: Duration(seconds: 1),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: CustomWidgetsText.text(
                                    widget.isUpdate == false
                                        ? widget.bookData.place!
                                        : widget.Data.place!,
                                    //   widget.bookData.place,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 15,
                                        color: AppColors.iconcyanshade600,
                                      ),
                                      CustomWidgetsText.text(
                                          widget.isUpdate == false
                                              ? widget.bookData.location!
                                              : widget.Data.location!,
                                          // widget.bookData.location,
                                          color: AppColors.textgrey,
                                          fontSize: 8.sp)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 25),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.yellow.shade700,
                                          size: 15),
                                      CustomWidgetsText.text("4.5 (1045)",
                                          fontSize: 8.sp,
                                          color: AppColors.textgrey),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 90),
                                        child: CustomWidgetsText.text(
                                            "\$${widget.isUpdate == false ? widget.bookData.price.toString() : widget.Data.price.toString()}",
                                            fontSize: 10.sp,
                                            color: AppColors.textCyan600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///************************************* Date ****************************
                    SizedBox(
                      height: 20,
                    ),
                    CustomWidgetsText.text("Date",
                        fontSize: 17, fontWeight: FontWeight.w600),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // _selectDate(context);
                            selectDateController.selectDate();
                          },
                          child: Container(
                              height: 5.h,
                              width: 35.w,
                              margin: EdgeInsets.only(bottom: 20, top: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.icongreyshade200,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  widget.isUpdate == false
                                      ?  Obx(() =>CustomWidgetsText.text(
                                          selectDateController.startDate.value,
                                          // selectDateController.startDate.value,
                                          fontSize: 9.sp,
                                          color: AppColors.textgrey))
                                      : CustomWidgetsText.text(
                                          widget.Data.startdate!,
                                          // selectDateController.startDate.value,
                                          fontSize: 9.sp,
                                          color: AppColors.textgrey),
                                  Icon(Icons.arrow_drop_down,
                                      color: AppColors.iconcyanshade600),
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectDateController.selectDate1();
                          },
                          child: Container(
                              height: 5.h,
                              width: 35.w,
                              margin: EdgeInsets.only(bottom: 20, top: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.icongreyshade200,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                   widget.isUpdate == false
                                        ? Obx(
                              () =>CustomWidgetsText.text(
                                            selectDateController.endDate.value,
                                            //selectDateController.endDate.value,
                                            fontSize: 9.sp,
                                            color: AppColors.textgrey)  )
                                        : CustomWidgetsText.text(
                                            widget.Data.enddate!,
                                            //selectDateController.endDate.value,
                                            fontSize: 9.sp,
                                            color: AppColors.textgrey),

                                  Icon(Icons.arrow_drop_down,
                                      color: AppColors.iconcyanshade600),
                                ],
                              )),
                        ),
                      ],
                    ),

                    ///************************************* Person ****************************
                    SizedBox(
                      height: 10,
                    ),
                    CustomWidgetsText.text("Person",
                        fontSize: 17, fontWeight: FontWeight.w600),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            removePerson();
                          },
                          child: Container(
                              height: 5.h,
                              width: 25.w,
                              margin: EdgeInsets.only(bottom: 20, top: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.icongreyshade200,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(Icons.remove,
                                  color: AppColors.textgrey)),
                        ),
                        Container(
                          height: 5.h,
                          width: 25.w,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 20, top: 20),
                          decoration: BoxDecoration(
                              color: AppColors.icongreyshade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: CustomWidgetsText.text(
                              widget.isUpdate == false
                                  ? person.toString()
                                  : widget.Data.person.toString(),
                              // person.toString(),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textgrey),
                        ),
                        GestureDetector(
                          onTap: () {
                            addPerson();
                          },
                          child: Container(
                              height: 5.h,
                              width: 25.w,
                              margin: EdgeInsets.only(bottom: 20, top: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.icongreyshade200,
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  Icon(Icons.add, color: AppColors.textgrey)),
                        ),
                      ],
                    ),

                    ///************************************* Price Details ****************************

                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: CustomWidgetsText.text("Price Details",
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    Center(
                      child: Container(
                        height: 17.h,
                        width: 85.w,
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            color: AppColors.icongreyshade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomWidgetsText.text(
                                    "Travel fee",
                                    fontSize: 9.sp,
                                  ),
                                  CustomWidgetsText.text(
                                      widget.isUpdate == false
                                          ? "\$${widget.bookData!.price.toString()}"
                                          : "\$${widget.Data!.price.toString()}",
                                      // "\$${widget.bookData!.price.toString()}",
                                      fontSize: 9.sp,
                                      color: AppColors.textgrey),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomWidgetsText.text(
                                    "Discount",
                                    fontSize: 9.sp,
                                  ),
                                  CustomWidgetsText.text("-10",
                                      fontSize: 9.sp,
                                      color: AppColors.textgrey),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1.h,
                              color: AppColors.icongrey,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomWidgetsText.text(
                                    "Total",
                                    fontSize: 9.sp,
                                  ),widget.isUpdate == false
                                      ?
                                  CustomWidgetsText.text(
                                      "\$${totalPrice}",
                                      //  "\$${totalPrice}",
                                      fontSize: 9.sp,
                                      color: AppColors.textgrey):  CustomWidgetsText.text(
                                      "\$${widget.Data!.total}",
                                      //  "\$${totalPrice}",
                                      fontSize: 9.sp,
                                      color: AppColors.textgrey)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// ********************* Confirm ******************************
                    Center(
                      child: CustomButton(
                        // margin: const EdgeInsets.only(left: 50),
                        height: 6.h,
                        width: 40.w,
                        onPressed: () {
                          //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookNowPage()));
                          if(widget.isUpdate==false){
                            FireStoreController.insertBook({
                              'image': widget.bookData!.image!,
                              'location': widget.bookData!.location,
                              'place': widget.bookData!.place,
                              'price': widget.bookData!.price,
                              'startdate': selectDateController.startDate.value,
                              'enddate': selectDateController.endDate.value,
                              'discount': 10,
                              'total': totalPrice,
                              'person': person
                            });
                          }
                          else{
                            FireStoreController.UpdateBook({
                              'image': widget.Data!.image!,
                              'location': widget.Data!.location,
                              'place': widget.Data!.place,
                              'price': widget.Data!.price,
                              'startdate': widget.Data!.startdate,
                              'enddate': widget.Data!.enddate,
                              'discount': 10,
                              'total': widget.Data!.total,
                              'person': widget.Data.person
                            },widget.Data.id);
                          }

                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyTripsPage()));
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.MY_TRIPS_PAGE_ROUTE);
                        },
                        child: CustomWidgetsText.text("Confirm",
                            fontWeight: FontWeight.w400,
                            color: AppColors.textWhiteColor),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
