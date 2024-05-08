import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Constants/constants.dart';
import '../Utils/app_color.dart';
import '../Widgets/custom_search_filter.dart';
import '../Widgets/custom_widget_bookmark_icon.dart';
import '../Widgets/custom_widget_cachednetworkimage.dart';
import '../Widgets/custom_widget_text.dart';
import 'details_page.dart';

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
//  bool isSelected = true;
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
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: SearchFiletrWidget(),
          ),
          Obx(()=>
            Container(
              height: 63.h,
              width: 95.w,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: FireStoreController.saveList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsPage(
                                saveData: FireStoreController.saveList[index],
                                isPopular: false,
                                isLatest: false,
                                isAll: false,
                                isSave: true,
                                isSearch: false,
                              )));
                    },
                     child:
                     CustomCachedNetworkImage(
                         imageUrl:  FireStoreController.saveList[index].image!,
                         height: 28.h,
                         width: 55.w,
                         margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                         child: Stack(
                           children: [
                             CustomBookmarkIcon(
                                 child: IconButton(
                                   onPressed: () {
                                     // if ( FireStoreController.saveList[index].isSelected!) {
                                     //   setState(() {
                                     //     FireStoreController.saveList[index].isSelected =
                                     //     !FireStoreController.saveList[index].isSelected!;
                                     //     FireStoreController.insertSave({
                                     //       'image' :FireStoreController.saveList[index].image!,
                                     //       'location':FireStoreController.saveList[index].location,
                                     //       'place':FireStoreController.saveList[index].place,
                                     //       'price':FireStoreController.saveList[index].price,
                                     //       'isSelected':FireStoreController.saveList[index].isSelected
                                     //     });
                                     //   });
                                     // } else {
                                     //   setState(() {
                                     //     FireStoreController.saveList[index].isSelected =
                                     //     ! FireStoreController.saveList[index].isSelected!;
                                     //     FireStoreController.deleteSave(FireStoreController.saveList[index].id!);
                                     //   });
                                     // }
                                   },
                                   icon:  FireStoreController.saveList[index].isSelected!
                                       ? Icon(
                                     Icons.bookmark_border,
                                     color: AppColors.iconcyanshade600,size: 20,
                                   )
                                       : Icon(Icons.bookmark_outlined,
                                     color: AppColors.iconcyanshade600,size: 20,),
                                 )
                             ),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [

                                 Container(
                                   color: Colors.black38,
                                   width: 90.w,
                                   padding: const EdgeInsets.only(bottom: 3,left: 20),
                                   child: CustomWidgetsText.text( FireStoreController.saveList[index].place!,
                                       color: AppColors.textWhiteColor, fontSize: 15),
                                 ),
                                 Container(
                                   width: 90.w,
                                   padding: const EdgeInsets.only(bottom: 10,left: 20),
                                   margin: EdgeInsets.only(bottom:1),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                                     color: Colors.black38,
                                   ),
                                   child: Row(
                                     children: [
                                       Icon(Icons.location_on,color: AppColors.textWhiteColor,size: 15,),
                                       CustomWidgetsText.text( FireStoreController.saveList[index].location!,
                                           color: AppColors.textWhiteColor,fontSize: 8.sp)
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         )
                     )

                  );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
