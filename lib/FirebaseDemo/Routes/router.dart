import 'package:flutter/material.dart';
import 'package:travel_demo/Routes/routes.dart';


import '../Constants/constants.dart';
import '../Screens/Setting/edit_account.dart';
import '../Screens/Setting/my_trips_page.dart';
import '../Screens/Setting/setting_page.dart';
import '../Screens/Setting/show_setting.dart';
import '../Screens/book_now_page.dart';
import '../Screens/categories.dart';
import '../Screens/dashbord_page.dart';
import '../Screens/details_page.dart';
import '../Screens/explore_page.dart';
import '../Screens/home_page.dart';
import '../Screens/save_page.dart';
import '../Screens/see_all_categories.dart';
import '../Screens/see_all_page.dart';
import '../Screens/signin_page.dart';
import '../Screens/signup_page.dart';
import '../Screens/splash_screen.dart';
import '../Screens/welcome_page.dart';
import '../Screens/zoom_images.dart';

class AppRouter {

  static generateRoute(BuildContext context) {
    return {
      Routes.SPLASH_SCREEN_ROUTE: (BuildContext context) =>
      const SplashScreen(),

      Routes.WELCOME_ROUTE: (BuildContext context) =>
      const WelcomePage(),

      Routes.SIGN_IN_ROUTE: (BuildContext context) =>
      const SigninPage(),

      Routes.SIGN_UP_ROUTE: (BuildContext context) =>
      const SignupPage(),

      Routes.DASHBORD_ROUTE: (BuildContext context) =>
      DashbordPage(),

      Routes.HOME_PAGE_ROUTE: (BuildContext context) =>
      const HomePage(),

      Routes.EXPLORE_PAGE_ROUTE: (BuildContext context) =>
      const ExplorePage(),

      Routes.SAVE_PAGE_ROUTE: (BuildContext context) =>
      const SavePage(),

      Routes.SETTING_PAGE_ROUTE: (BuildContext context) =>
      const SettingPage(),

      Routes.SEE_ALL_PAGE_ROUTE: (BuildContext context) =>
      const SeeAllPage(),

      Routes.SEE_ALL_CATEGORIES_ROUTE: (BuildContext context) =>
      const SeeAllCategories(),

      Routes.CATEGORIES_ROUTE: (BuildContext context) =>
       Categories(),

      Routes.DETAILS_PAGE_ROUTE: (BuildContext context) =>
       DetailsPage(),

      Routes.BOOK_NOW_PAGE_ROUTE: (BuildContext context) =>
       BookNowPage(),

      Routes.ZOOM_IMAGES_ROUTE: (BuildContext context) =>
     ZoomImages(),

      Routes.EDIT_ACCOUNT_ROUTE: (BuildContext context) =>
       EditAccount(),

      Routes.MY_CARD_ROUTE: (BuildContext context) =>
    EditAccount(),

    Routes.SHOW_SETTING_ROUTE: (BuildContext context) =>
    const ShowSetting(),

      Routes.MY_TRIPS_PAGE_ROUTE: (BuildContext context) =>
      const MyTripsPage(),

    };
  }

}