import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:urban_cult/app/modules/splashscreen/controllers/splashscreen_controller.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    splashScreenController.goToLogin();
    // TODO: implement initState
    super.initState();
  }

  final SplashscreenController splashScreenController =
      Get.put(SplashscreenController());

  @override
  Widget build(BuildContext context) {
    // splashScreenController.goToLogin();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 232, 240),
      // appBar: AppBar(
      //   title: const Text('SplashScreenView'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: LottieBuilder.asset(
                "assets/Animation - 1737454063491-2.json",
                fit: BoxFit.cover,
              ),
            )
            // Animate(
            //     effects: [
            //       FlipEffect(
            //         curve: Curves.fastOutSlowIn,
            //         duration: Duration(milliseconds: 1099),
            //       ),
            //       ScaleEffect(
            //           // alignment: Alignment.bottomCenter,
            //           transformHitTests: true,
            //           duration: Duration(milliseconds: 1059),
            //           // delay: Duration(milliseconds: 659),
            //           curve: Curves.bounceOut)
            //     ],
            //     child: Image.asset(
            //       'assets/gropto_phone_logo.webp',
            //       width: 100.w,
            //       height: 350,
            //     )),
            // SizedBox(
            //   height: 10,
            // ),
            ,
            Text(
              "URBAN CULTURE",
              style: GoogleFonts.belleza(
                color: const Color.fromARGB(255, 130, 35, 86),
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 500),
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                )
                .slideY(
                  begin: -0.5, // Moves from top
                  end: 0,
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.easeOutBack,
                )
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                  duration: Duration(milliseconds: 700),
                  curve: Curves.elasticOut,
                )
                .then(delay: Duration(milliseconds: 200))
          ],
        ),
      ),
    );
  }
}
