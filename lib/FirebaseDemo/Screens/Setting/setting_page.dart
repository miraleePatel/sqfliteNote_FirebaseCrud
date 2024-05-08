import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_demo/Screens/Setting/my_card.dart';
import 'package:travel_demo/Screens/Setting/show_setting.dart';
import '../../Constants/constants.dart';
import '../../Utils/app_color.dart';
import '../../Widgets/custom_listtile_settingpage.dart';
import '../../Widgets/custom_widget_text.dart';
import 'edit_account.dart';
import 'my_trips_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      user!.photoURL;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomListTileSetting(
                title: CustomWidgetsText.text("Account", fontSize: 13),
                onTap: () {
                 // Get.to(const EditAccount());
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditAccount()));

                },
                child: const Icon(Icons.account_circle,color: AppColors.iconbgcolorwhite),
              ),
              SizedBox(
                height: 20,
              ),
              CustomListTileSetting(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyTripsPage()));

                },
                title: CustomWidgetsText.text("My Trips", fontSize: 13),
                child: const Icon(
                  Icons.local_airport_outlined,color: AppColors.iconbgcolorwhite
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomListTileSetting(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyCard()));

                },
                title: CustomWidgetsText.text("My Card", fontSize: 13),
                child: const Icon(Icons.account_circle,color: AppColors.iconbgcolorwhite),
              ),
              SizedBox(
                height: 20,
              ),
              CustomListTileSetting(
                title: CustomWidgetsText.text("Setting", fontSize: 13),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowSetting()));
                },
                child: const Icon(
                  Icons.settings,color: AppColors.iconbgcolorwhite
                ),
              ),
            ],
          ),
        ));
  }
}

// class SettingPage extends StatefulWidget {
//   const SettingPage({Key? key}) : super(key: key);
//
//   @override
//   State<SettingPage> createState() => _SettingPageState();
// }
//
// class _SettingPageState extends State<SettingPage> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
//
//
// }
