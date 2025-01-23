import 'package:get/get.dart';
import 'package:urban_cult/app/modules/bottom_bar/views/bottom_bar_view.dart';

class SplashscreenController extends GetxController {
  //TODO: Implement SplashscreenController

  final count = 0.obs;

  void increment() => count.value++;
  goToLogin() async {
    await Future.delayed(Duration(milliseconds: 3740));
    Get.offAll(BottomBarView(),
        transition: Transition.circularReveal,
        duration: const Duration(seconds: 2));
  }
}
