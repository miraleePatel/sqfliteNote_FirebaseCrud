import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'SqliteNoteDemo/Screens/splesh_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  print(getApplicationDocumentsDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SpleshScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );

  }
}


