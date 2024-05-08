// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_demo/Models/user_model.dart';
import '../../Constants/constants.dart';
import '../../Utils/app_color.dart';
import '../../Widgets/custom_widget_button.dart';
import '../../Widgets/custom_widget_text.dart';
import '../../Widgets/custom_widgets.dart';

class EditAccount extends StatefulWidget {
  String? uid;
  EditAccount({Key? key, this.uid}) : super(key: key);

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  final ImagePicker picker = ImagePicker();
  var imagename;
  String? downloadloadedurl;
  var ref;
  DateTime initDate = DateTime.now();
  String date_of_birth = 'Date of Birth';
  userModel userDate = userModel();
  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser;
    print(user);
    select();
    super.initState();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != initDate) {
      setState(() {
        date_of_birth = new DateFormat.yMd().format(picked);
      });
      dobController.text = date_of_birth;
    }
  }

  select() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(user!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
     // image = data?['image'];
      fnameController.text = data?['name'];
      emailController.text = data?['email'];
      contactController.text = data!['contact'].toString();
      dobController.text = data['dob'];
    }
    setState(() {

    });
  }

  void uploadFromCamera() async {
    XFile? imagePick =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      imageshow = File(imagePick!.path);
      imagename = File(imagePick.name);
    });
    upload();
  }

  void uploadFromGallary() async {
    XFile? imagePick =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageshow = File(imagePick!.path);
      imagename = File(imagePick.name);
    });
    upload();
  }

  void upload() async {
    if (imageshow != null) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('Images/${imagename.path.toString()}');
      ref.putFile(imageshow!).then((p0) async {
        downloadloadedurl = await ref.getDownloadURL();
        print(downloadloadedurl);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Builder(builder: (context) {
            return SafeArea(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        uploadFromGallary();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      uploadFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Form(
        key: formkey,
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              //  physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildRow(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                        height: 88.h,
                        width: 200.w,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            color: AppColors.textWhiteColor),
                        child: Column(
                          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 20),
                              child: GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: CircleAvatar(
                                  radius: 54,
                                  backgroundColor: AppColors.bgColor,
                                  child: imageshow != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.file(
                                            imageshow,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                          : user!.photoURL != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: CachedNetworkImage(
                                                    imageUrl: user!.photoURL!,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        CircleAvatar(
                                                      radius: 50,
                                                      backgroundColor:
                                                          Colors.blueGrey,
                                                      backgroundImage:
                                                          imageProvider,
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            SizedBox(
                                                      height: 2.h,
                                                      width: 2.h,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            AppColors.bgColor,
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  )) :
                                  userDate.image != null
                                      ? ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl: userDate.image!,
                                        imageBuilder: (context,
                                            imageProvider) =>
                                            CircleAvatar(
                                              radius: 50,
                                              backgroundColor:
                                              Colors.blueGrey,
                                              backgroundImage:
                                              imageProvider,
                                            ),
                                        placeholder:
                                            (context, url) =>
                                            SizedBox(
                                              height: 2.h,
                                              width: 2.h,
                                              child:
                                              CircularProgressIndicator(
                                                color:
                                                AppColors.bgColor,
                                              ),
                                            ),
                                        errorWidget:
                                            (context, url, error) =>
                                            Icon(Icons.error),
                                      ))
                                    : image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.file(
                                              image,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  width: 100,
                                                  height: 100,
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                ),
                              ),
                            ),
                            Container(
                              height: 9.h,
                              width: 93.w,
                              alignment: Alignment.center,
                              child: Card(
                                elevation: 5,
                                child: TextFormField(
                                  controller: fnameController,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 20),
                                      hintText: "Full Name",
                                      border: InputBorder.none),
                                ),
                              ),
                            ),

                            Container(
                              height: 9.h,
                              width: 93.w,
                              alignment: Alignment.center,
                              child: Card(
                                elevation: 5,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 20),
                                      hintText: "Email",
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            Container(
                              height: 9.h,
                              width: 93.w,
                              alignment: Alignment.center,
                              child: Card(
                                elevation: 5,
                                child: TextFormField(
                                  controller: contactController,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 20),
                                      hintText: "Contact",
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            Container(
                              height: 9.h,
                              width: 93.w,
                              alignment: Alignment.center,
                              child: Card(
                                elevation: 5,
                                child: InkWell(
                                  onTap: () {
                                    selectDate(context);
                                  },
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      controller: dobController,
                                      decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          hintText: "Date of Birth",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CustomButton(
                              margin: const EdgeInsets.only(top: 35),
                              height: 6.h,
                              width: 70.w,
                              onPressed: () {
                                FireStoreController.updateUser({
                                  'name': fnameController.text,
                                  'email': emailController.text,
                                  'contact': contactController.text,
                                  'image': downloadloadedurl,
                                  'dob': dobController.text
                                }, user!.uid);
                                user!.updateEmail(emailController.text);
                                user!.updateDisplayName(fnameController.text);
                                user!.updatePhotoURL(downloadloadedurl);
                                print(user);
                                imageCache.clear();
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.of(context).pop();
                                });
                              },
                              child: CustomWidgetsText.text("Save",
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textWhiteColor),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomWidgets.backIcon(context: context),
          CustomWidgetsText.text("Account",
              fontSize: 15, color: AppColors.textWhiteColor),
          Container(
            width: 15.w,
          )
        ],
      ),
    );
  }
}
