import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:studentdatabase/view/student_display_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3),(){
      
      Get.offAll(const StudentDisplayScreen());
    });
    return Scaffold(
      backgroundColor: Colors.teal[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Lottie.asset("assets/Animation - 1705381168260.json",))
        ],
      ),
    );
  }
}