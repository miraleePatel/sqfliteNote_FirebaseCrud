import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_demo/Constants/constants.dart';
import '../../Firebase Auth/authentication.dart';
import '../../Firebase Auth/shared.dart';
import '../../Utils/app_color.dart';
import '../../Widgets/custom_listtile_settingpage.dart';
import '../../Widgets/custom_widget_button.dart';
import '../../Widgets/custom_widget_text.dart';
import '../../Widgets/custom_widgets.dart';

class ShowSetting extends StatefulWidget {
  const ShowSetting({Key? key}) : super(key: key);

  @override
  State<ShowSetting> createState() => _ShowSettingState();
}

class _ShowSettingState extends State<ShowSetting> {
  bool mode = true;
  final storage = GetStorage();

  Future _deleteImageFromCache(String? imageUrl) async {
    String url = imageUrl!;
    await CachedNetworkImage.evictFromCache(url);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
          //  physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                buildRow(context),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                      height: 87.h,
                      width: 200.w,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: AppColors.textWhiteColor),
                      child: Column(
                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //  crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          CustomListTileSetting(
                            title: CustomWidgetsText.text(
                                "Notification Settings",
                                fontSize: 13,color: AppColors.textBalckColor),
                            child: const Icon(Icons.notifications,color: AppColors.iconbgcolorwhite),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomListTileSetting(
                            title: CustomWidgetsText.text("Gift Cards",
                                fontSize: 13,color: AppColors.textBalckColor),
                            child: const Icon(Icons.card_giftcard,color: AppColors.iconbgcolorwhite),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 9.h,
                            width: 48.h,
                            margin: EdgeInsets.only(left: 20,right: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.bordercyanshade600)),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.bordercyanshade600,
                                  child: const Icon(Icons.light_mode,color: AppColors.iconbgcolorwhite),
                                ),
                              ),
                              title: CustomWidgetsText.text("Light Mode",
                                  fontSize: 13,color: AppColors.textBalckColor),
                              trailing: CupertinoSwitch(
                                value: mode,
                                // thumbColor: CupertinoColors.systemBlue,
                                // trackColor: CupertinoColors.systemRed.withOpacity(0.14),
                                activeColor: CupertinoColors.secondaryLabel
                                    .withOpacity(0.64),
                                onChanged: (bool? value) {
                                  setState(() {
                                    mode = value!;
                                   // Get.changeTheme(ThemeData.dark());
                                   Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                                  });

                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomListTileSetting(
                            title: CustomWidgetsText.text("Location",
                                fontSize: 13,color: AppColors.textBalckColor),
                            child: const Icon(Icons.location_on,color: AppColors.iconbgcolorwhite),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            height: 6.h,
                            width: 70.w,
                            onPressed: () {
                              FirebaseServices().logOutCurrentUser(context);
                                sharedpref().clearData();
                                // FirebaseServices().signOut();
                                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SigninPage()));
                              imageCache.clear();
                              imageshow=null;
                              image=null;
                              _deleteImageFromCache(user!.photoURL);
                            },
                            child: CustomWidgetsText.text("Logout",
                                fontWeight: FontWeight.w400,
                                color: AppColors.textWhiteColor),
                          ),
                        ],
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
      padding: const EdgeInsets.only(left: 20,right: 20,top: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomWidgets.backIcon(context: context),
          CustomWidgetsText.text("Setting",
              fontSize: 15, color: AppColors.textWhiteColor),
          Container(width:15.w,)
        ],
      ),
    );
  }
}
