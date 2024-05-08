import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Constants/constants.dart';
import '../Routes/routes.dart';
import '../Utils/app_color.dart';
import '../Utils/app_string.dart';
import '../Widgets/custom_widget_button.dart';
import '../Widgets/custom_widget_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: 100.h,
              width: 250.w,
              child: Image.asset(
                'assets/images/first_page.png',
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 80,left: 20,right: 20),
            child: Column(
              children: [
                CustomWidgetsText.text(AppStrings.title,
                    color: AppColors.textWhiteColor,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    maxLine: 2,
                    textAlign: TextAlign.left),
                SizedBox(
                  height: 20,
                ),
                CustomWidgetsText.text(AppStrings.description,
                    color: AppColors.textWhiteColor,
                    fontSize: 13,
                    maxLine: 2,
                    textAlign: TextAlign.left),
                const Spacer(),
                CustomButton(
                  margin: const EdgeInsets.only(bottom: 40),
                  height: 6.h,
                  width: 70.w,
                  onPressed: () {
                 //   Get.off(SigninPage());
                    current != null  ? Navigator.of(context)
                        .pushReplacementNamed(Routes.DASHBORD_ROUTE):Navigator.of(context)
                        .pushReplacementNamed(Routes.SIGN_IN_ROUTE);

                  },
                  child: CustomWidgetsText.text(AppStrings.LetsGo,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textWhiteColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
