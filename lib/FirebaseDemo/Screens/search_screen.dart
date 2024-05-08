import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Constants/constants.dart';
import '../Utils/app_color.dart';
import '../Widgets/custom_widget_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchcontroller = TextEditingController();
  final List<String> typelitems = ["Tour", "Adventure", "Countries"];
  final List<String> locationlitems1 = [
    "Uttrakhand",
    "Maldives",
    "Thailand",
  ];

  // Initialize to -1 so that none are selected
  // If you want to select the first by default you could change this to 0
  int typeIndex = -1;
  int locationIndex = -1;

  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List _allUsers = List.from(FireStoreController.travellatestList)..addAll(FireStoreController.travelPopularList);

  // This list holds the data for the list view
  List _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user.place.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 5.h,
            width: 65.w,
            margin: const EdgeInsets.only(left: 38, top: 20),
            decoration: BoxDecoration(
                color: AppColors.icongreyshade200,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: TextFormField(
              controller: searchcontroller,
              keyboardType: TextInputType.text,
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  hintText: "Search..",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: _foundUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _foundUsers.length,
                    itemBuilder: (context, index) => Container(
                      height: 15.h,
                      child: Card(
                          color: AppColors.icongreyshade200,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, top: 10, right: 25),
                                // padding: EdgeInsets.only(top: 10),
                                height: 10.h,
                                width: 10.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            _foundUsers[index].image!),
                                        fit: BoxFit.fill)),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomWidgetsText.text(
                                      _foundUsers[index].place!,
                                      color: AppColors.textBalckColor,
                                      fontSize: 13),
                                  TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.location_on,
                                        color: AppColors.textBalckColor,
                                        size: 20,
                                      ),
                                      label: CustomWidgetsText.text(
                                          _foundUsers[index].location!,
                                          color: AppColors.textBalckColor)),
                                ],
                              ),
                            ],
                          )),
                    ),
                  )
                : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
          ),
        ],
      ),
    );
  }
}
