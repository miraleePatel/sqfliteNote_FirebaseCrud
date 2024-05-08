import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_demo/Screens/see_all_categories.dart';
import '../Constants/constants.dart';
import '../Utils/app_color.dart';
import '../Widgets/custom_search_filter.dart';
import '../Widgets/custom_widget_text.dart';
import '../Widgets/travel_places_view_widget.dart';
import 'categories.dart';
import 'see_all_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List<String> topList = [
    "Uttrakhnad",
    "Maldives",
    "Thailand",
  ];
  int? locationIndex;
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
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
            SearchFiletrWidget(),

            ///******************* Travel Places ******************************
            Padding(
              padding: const EdgeInsets.only(right: 20,left: 20,top: 40,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomWidgetsText.text("Travel places",
                      fontSize: 17, fontWeight: FontWeight.w600),
                  GestureDetector(
                      onTap: (){
                        Get.to(const SeeAllPage());
                      },
                      child: CustomWidgetsText.text("See All")),
                ],
              ),
            ),
             TravelPlacesView(),

            ///************************ Top Categories *************************************
            Padding(
              padding: const EdgeInsets.only(top: 40,left: 20,right: 20,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomWidgetsText.text("Top Categories",
                      fontSize: 17, fontWeight: FontWeight.w600),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SeeAllCategories(
                        )));
                      },
                      child: CustomWidgetsText.text("See All")),
                ],
              ),
            ),
            Container(
              height: 6.h,
              width: 200.w,
              margin: const EdgeInsets.only(top: 10, left: 20),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: topList.length,
                itemBuilder: (context, index) {
                 locationIndex = index;
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Categories(
                        getList: topList[index],
                      )));
                    },
                    child: Container(
                      height: 5.h,
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade200),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(Icons.location_on,color:AppColors.iconcyanshade600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CustomWidgetsText.text(
                                topList[index],
                                fontSize: 12,color: AppColors.textBalckColor),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 20,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
