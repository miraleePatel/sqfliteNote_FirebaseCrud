import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../Constants/constants.dart';
import '../Firebase Auth/authentication.dart';
import '../Utils/app_color.dart';
import '../Utils/validator.dart';
import '../Widgets/custom_widget_button.dart';
import '../Widgets/custom_widget_text.dart';
import '../Widgets/custom_widget_textformfield.dart';
import 'dashbord_page.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  bool passwordVisible = true;
  bool confirmVisible = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        focusName.unfocus();
        focusEmail.unfocus();
        focusPassword.unfocus();
      },
      child: Scaffold(
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            // physics: NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                    height: 107.h,
                    width: 250.w,
                    child: Image.asset(
                      'assets/images/login_bg1.jpg',
                      fit: BoxFit.fill,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.h, vertical: 10.h),
                        child: CustomWidgetsText.text("RIGISTER",
                            color: AppColors.textWhiteColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w400),
                      ),
                      CustomWidgetTextFormfeild(
                        controller: fullNameController,
                        validator: (value) => Validator.validateName(name: value),
                        focusNode: focusName,
                        obscureText: false,
                        hintText: "Full Name",
                        prefixIcon: const Icon(Icons.account_circle_outlined),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomWidgetTextFormfeild(
                        controller: emailController,
                        validator: (value) => Validator.validateEmail(email: value),
                        focusNode: focusEmail,
                        obscureText: false,
                        hintText: "Email",
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomWidgetTextFormfeild(
                        controller: passwordController,
                        obscureText: passwordVisible,
                        validator: (value) =>Validator.validatePassword(password: value),
                        focusNode: focusPassword,
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(passwordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomWidgetTextFormfeild(
                        controller: confirmPasswordController,
                        obscureText: confirmVisible,
                        hintText: "Confirm Password",
                        validator: (value) =>Validator.validateConfirmPassword(Confirmpassword: value,
                            password: passwordController.text),
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              confirmVisible = !confirmVisible;
                            });
                          },
                          icon: Icon(confirmVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomButton(
                        margin: EdgeInsets.only(top: 3.h),
                        height: 50,
                        width: 80.w,
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            // authController.register(emailController.text.trim(),
                            //             passwordController.text.trim());
                            var data = await FirebaseServices().Signup(name : fullNameController.text,
                              email :emailController.text,
                               password: passwordController.text,
                            );

                            if (data is String) {
                              Get.snackbar("About user", "User message",
                                  backgroundColor: AppColors.bgColor,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: Duration(seconds: 2),
                                  titleText: Text(
                                    "Account creation failed",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  messageText: Text(
                                   "The email address is already in use by another account",
                                    style: TextStyle(color: Colors.white),
                                  ));
                            } else {
                              Get.snackbar(
                                "",
                                "",
                                backgroundColor: AppColors.bgColor,
                                duration: Duration(seconds: 1),
                                snackPosition: SnackPosition.BOTTOM,
                                titleText: Text(
                                  "Account create Sucessfully",
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              Future.delayed(Duration(seconds: 2),(){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DashbordPage()));
                              });
                            }
                          }
                        },
                        child: CustomWidgetsText.text("RIGISTER",
                            fontWeight: FontWeight.w400,
                            color: AppColors.textWhiteColor),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
                        child: CustomWidgetsText.text("OR USE",
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textWhiteColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black38,
                            child: Image.asset(
                              'assets/images/google_logo.png',
                              height: 2.h,
                            ),
                          ),
                          SizedBox(
                            width: 7.w,
                            // height: 10.h,
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black38,
                            child: Image.asset('assets/images/facebook_logo.png',
                                height: 3.h),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
