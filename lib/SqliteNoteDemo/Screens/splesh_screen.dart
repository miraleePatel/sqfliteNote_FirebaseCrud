import 'dart:async';

import 'package:demo_sqflite/SqliteNoteDemo/Screens/home_page.dart';
import 'package:flutter/material.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 3),
            ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Homepage())),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade800,
      body: Center(child:Image.asset('assets/logo.png'),)
    );
  }
}
