import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:the_apple_sign_in/scope.dart';
import '../Constants/constants.dart';
import '../Firebase Auth/apple_sign_in.dart';
import '../Firebase Auth/apple_sign_in_available.dart';
import '../Firebase Auth/authentication.dart';
import '../Firebase Auth/shared.dart';
import '../Routes/routes.dart';
import '../Utils/app_color.dart';
import '../Utils/validator.dart';
import '../Widgets/custom_widget_button.dart';
import '../Widgets/custom_widget_text.dart';
import '../Widgets/custom_widget_textformfield.dart';
import 'dashbord_page.dart';


class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  TextEditingController emailController = TextEditingController(

  );
  TextEditingController passwordController = TextEditingController(

  );

  GlobalKey<FormState> formkey = GlobalKey();
  final storage = GetStorage();
  bool passwordVisible = true;
  double _size=50.0;
  @override

  void initState() {
    Future.delayed(Duration(seconds: 2),(){
      checkLogin();
    });
    super.initState();
  }


// logincheck() async {
//     var userdata = await FireStoreController.selectUser();
//     var items = FireStoreController.userList;
//
//     for(var item in items){
//       if(item['email']== emailController.text){
//         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashbordPage(
//         )));
//       print(item);
//       }
//       else{
//       print("Error");
//       }
//     }
// }

  checkLogin()async{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bool isLogincheck = sharedpref().getbool("isLogin", false);
      if(isLogincheck){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashbordPage()));
      }
      setState(() {
      });
    });
  }

  Future<void> _signInWithApple(BuildContext context) async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final user = await authService.signInWithApple(
          scopes: [Scope.email, Scope.fullName]);
      print('uid: ${user.uid}');
    } catch (e) {
      // TODO: Show alert here
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    final appleSignInAvailable =
    Provider.of<AppleSignInAvailable>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
         // physics: NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              Container(
                  height: 100.h,
                  width: 250.w,
                  child: Image.asset(
                    'assets/images/login_bg.jpg',
                    fit: BoxFit.fill,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 10.h),
                      child: CustomWidgetsText.text("SIGN IN",
                          color: AppColors.textWhiteColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w400),
                    ),
                    CustomWidgetTextFormfeild(
                      controller: emailController,
                      focusNode: focusEmail,
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      obscureText: false,
                      validator: (value) => Validator.validateEmail(email: value),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomWidgetTextFormfeild(
                      controller: passwordController,
                      validator: (value) => Validator.validatePassword(password: value),
                      obscureText: passwordVisible,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomWidgetsText.text("Forgotten Password?",
                            fontWeight: FontWeight.w900,
                            color: AppColors.textWhiteColor,
                            fontSize: 10),
                      ],
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    CustomButton(
                      height:_size,
                      width: 80.w,
                      onPressed: () async{
                        if (formkey.currentState!.validate()) {
                          var data = await FirebaseServices().Signin(emailController.text, passwordController.text);
                          if(data is String){
                            Get.snackbar("", "",
                                backgroundColor:  AppColors.bgColor,
                                snackPosition: SnackPosition.BOTTOM,
                                duration: Duration(seconds: 1),
                                titleText: Text("Create a Account new",style: TextStyle(color: Colors.white),),
                                messageText: Text(data.toString(),style: TextStyle(color: Colors.white),)
                            );
                          }
                          else{
                            Get.snackbar("", "",
                              backgroundColor: AppColors.bgColor,
                              snackPosition: SnackPosition.BOTTOM,
                              duration:  Duration(seconds: 1),
                              titleText: Text("Login Sucessfully",style: TextStyle(color: Colors.white),),
                            );
                            Future.delayed(Duration(seconds: 2),(){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashbordPage(
                              )));
                            });
                            sharedpref().setbool("isLogin",true);
                          }
                        }
                      },
                      child: CustomWidgetsText.text("LOGIN",
                          fontWeight: FontWeight.w400,
                          color: AppColors.textWhiteColor),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    CustomWidgetsText.text("SIGN IN WITH",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textWhiteColor),
                    SizedBox(
                      height:10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var response = await FirebaseServices().Googlelogin();
                            if(response is User && response.uid != null){
                              Navigator.of(context)
                                  .pushReplacementNamed(Routes.DASHBORD_ROUTE);  }
                            else{
                              print("error");
                            }
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black38,
                            child: Image.asset(
                              'assets/images/google_logo.png',
                              height: 2.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7.w,
                         // height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var response = await  FirebaseServices().signInWithFacebook();
                            if(response is User && response.uid != null){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashbordPage()));  }
                            else{
                              print("error");
                            }
                        //    FirebaseServices().signInWithFacebook();
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashbordPage()));
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black38,
                            child: Image.asset('assets/images/facebook_logo.png',
                                height: 3.h),
                          ),
                        ), SizedBox(
                          width: 7.w,
                          // height: 10.h,
                        ),
                        if(appleSignInAvailable.isAvailable)
                        GestureDetector(
                          onTap: () async {
                            _signInWithApple(context);
                          },
                          child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.black38,
                              child: CustomWidgetsText.text('A',fontSize: 15,fontWeight: FontWeight.w800,color:AppColors.textWhiteColor)
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7.h),
                      child: CustomWidgetsText.text("Not a Member yet?",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textWhiteColor),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context)
                            .pushNamed(Routes.SIGN_UP_ROUTE);

                      },
                      child: CustomWidgetsText.text("Register",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textlightBlue),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
