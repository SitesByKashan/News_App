
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/configs/colors.dart';
import 'package:new_app/configs/move.dart';
import 'package:new_app/pages/homepage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 2),()=>goreplace(const HomePage(),context) );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.greenColor,
      body: Center(
        child:RichText(
          text: TextSpan(
            children : [
              TextSpan(
                 text: "News.",
             style: GoogleFonts.greatVibes(textStyle: TextStyle(
              fontSize: 60,
              color: Appcolor.whiteColor)),
              ),
             TextSpan(
                text: "Hub",
                style: TextStyle(color: Appcolor.blackColor, fontSize: 25),
              )
            ],
        
          ),

        )
      ),
    );
  }
}