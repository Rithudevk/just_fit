import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videoplayer/view/screens/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.to(Home());
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.3),
          image: DecorationImage(image: AssetImage('Assets/figure2.jpg',
          
          ),
          fit: BoxFit.cover,
          opacity: 0.3,
          )
        ),
        child: Container(
          
          padding: EdgeInsets.only(
            bottom: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             Opacity(
              opacity: 0.7,
               child: Text("DON'T SIT",
               style:GoogleFonts.unlock(
                 fontSize: 40,
                fontWeight: FontWeight.w500,
               
               ) ,
               ),
             ),
                Opacity(
                  opacity: 0.7,
                  child: Text("GET FIT",
                   style:  GoogleFonts.unlock(
                                 fontSize: 40,
                                fontWeight: FontWeight.w500,
                  
                               ) ,
                  ),
                ),
            ],
          ),
        ),
      ),
    )
    ;
  }
}