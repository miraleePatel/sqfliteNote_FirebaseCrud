import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Constants/constants.dart';
import '../Models/travel_places_popular.dart';
import '../Utils/app_color.dart';
import '../Utils/app_string.dart';
import '../Widgets/custom_widget_text.dart';
import 'Setting/edit_account.dart';
import 'Setting/setting_page.dart';
import 'explore_page.dart';
import 'home_page.dart';
import 'save_page.dart';

class DashbordPage extends StatefulWidget {
   const DashbordPage({Key? key}) : super(key: key);

  @override
  State<DashbordPage> createState() => _DashbordPageState();
}

class _DashbordPageState extends State<DashbordPage> {
  bool searchBoolean = false;
  int Selectedindex = 0;
  List<Widget> pageList = [
    HomePage(),
    ExplorePage(),
    SavePage(),
    SettingPage(),
  ];
  bool? isSearch;
  List<TravelPopular> travelPopularList=[];
  @override
  void initState() {
    // TODO: implement initState
    isSearch = false;
 // print(widget.uid.toString());
   // user!.photoURL;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(14.h),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10.h,
                      width: 38.w,
                      child: CustomWidgetsText.text("where do you want to go ?",
                          maxLine: 2,
                          fontSize: 17,
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditAccount()));
                        // Navigator.of(context)
                        //     .pushReplacementNamed(Routes.EDIT_ACCOUNT_ROUTE);
                      },
                       child:
                        // image != null ?  CachedNetworkImage(
                      //   imageUrl: image,
                      //   imageBuilder: (context,imageProvider) =>CircleAvatar(
                      //     radius: 22,
                      //     backgroundColor: Colors.blueGrey,
                      //     backgroundImage:imageProvider,
                      //   ),
                      //   placeholder: (context, url) => SizedBox(
                      //     height: 2.h,
                      //     width: 2.h,
                      //     child: CircularProgressIndicator(
                      //       color: AppColors.bgColor,
                      //     ),
                      //   ),
                      //   errorWidget: (context, url, error) => Icon(Icons.error),
                      // ):
                      user!.photoURL != null ?
                      CachedNetworkImage(
                        imageUrl: user!.photoURL!,
                        imageBuilder: (context,imageProvider) =>CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.blueGrey,
                          backgroundImage:imageProvider,
                        ),
                        placeholder: (context, url) => SizedBox(
                          height: 2.h,
                          width: 2.h,
                          child: CircularProgressIndicator(
                            color: AppColors.bgColor,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                          :
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.blueGrey,
                      )
                      // CircleAvatar(
                      //   radius: 22,
                      //   backgroundColor: Colors.blueGrey,
                      //   backgroundImage: AssetImage('assets/images/profile.png'),
                      //   child: Image.asset('assets/images/profile.png',fit: BoxFit.cover,),
                      // ),
                    ),
                  )
                ],
              ),
            ),
          )
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              Selectedindex = value;
            });
          },
          currentIndex: Selectedindex,
          backgroundColor: Colors.cyan.shade600,
          unselectedItemColor: Colors.cyan.shade200,
          selectedItemColor: AppColors.buttoncyanshade600,
          elevation: 10,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: AppStrings.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: AppStrings.explore),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), label: AppStrings.save),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppStrings.setting),
          ],
        ),
        body:
             pageList.elementAt(Selectedindex)
    );
  }
}
