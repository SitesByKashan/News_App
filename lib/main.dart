import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/configs/colors.dart';
import 'package:new_app/pages/splash_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
       theme: ThemeData(
       
        focusColor:Appcolor.greenColor ,
        primaryColor: Appcolor.greenColor,
        primarySwatch: Colors.green, 
        textTheme: GoogleFonts.loraTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
