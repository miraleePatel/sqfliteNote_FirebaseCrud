import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_demo/Firebase%20Auth/shared.dart';
import 'Firebase Auth/apple_sign_in.dart';
import 'Firebase Auth/apple_sign_in_available.dart';
import 'Routes/router.dart';
import 'Routes/routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
 sharedpref.init();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(Provider<AppleSignInAvailable>.value(
    value: appleSignInAvailable,
    child: MyApp(),
  ));
 // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Provider<AuthService>(
          create: (_) => AuthService(),
          child: GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: Routes.SPLASH_SCREEN_ROUTE,
            routes: AppRouter.generateRoute(context),
          //  home:const SplashScreen(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}

// return GetMaterialApp(
// title: 'Flutter Demo',
// theme: ThemeData(
// primarySwatch: Colors.blue,
// ),
// initialRoute: Routes.SPLASH_SCREEN_ROUTE,
// routes: AppRouter.generateRoute(context),
// //  home:const SplashScreen(),
// debugShowCheckedModeBanner: false,
// );



/// firebase project:- flutter