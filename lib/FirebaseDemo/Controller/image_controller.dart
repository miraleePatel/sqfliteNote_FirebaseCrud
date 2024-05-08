import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Constants/constants.dart';

class imageController extends GetxController{
  final ImagePicker picker = ImagePicker();
  var imageshow;
  var imagename;
  String? downloadloadedurl;
  var ref;

  @override
  void onInit() {
    // TODO: implement onInit
    user = FirebaseAuth.instance.currentUser!;
    print(user);
    super.onInit();
  }
  void uploadFromCamera() async{
    XFile? image = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    imageshow = File(image!.path);
    imagename = File(image.name);
    update();
  }

  void uploadFromGallary() async{
    XFile? image = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    imageshow = File(image!.path);
    imagename = File(image.name);
    update();
  }

  void upload() async{
    if(imageshow != null){
      var ref = FirebaseStorage.instance.ref().child('Images/${imagename.path.toString()}');
      ref.putFile(imageshow!).then((value) async {
        downloadloadedurl = await ref.getDownloadURL();
        print(downloadloadedurl);
      });
    }
    update();
  }

  // void upload() async{
  //   if(imageshow !=null){
  //     var ref = FirebaseStorage.instance
  //         .ref()
  //         .child('Images/${user!.uid}');
  //     ref.putFile(imageshow!).then((value) async{
  //       downloadloadedurl = await ref.getDownloadURL();
  //       print(downloadloadedurl);
  //     });
  //     update();
  //   }
  // }

  DeleteImage(){
    ref.delete();
  }
}