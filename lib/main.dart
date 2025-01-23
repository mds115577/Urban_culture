import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_cult/app/modules/splashscreen/views/splashscreen_view.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      home: SplashScreenView(),
    ),
  );
}
