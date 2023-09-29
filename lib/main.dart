import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller/RegisterController.dart';
import 'package:appnghich/screen/login_screen.dart';


void main() {
  runApp(MyApp());
  Get.put(RegisterController());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}