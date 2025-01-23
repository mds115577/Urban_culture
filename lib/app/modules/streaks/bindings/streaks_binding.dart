import 'package:get/get.dart';

import '../controllers/streaks_controller.dart';

class StreaksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StreaksController>(
      () => StreaksController(),
    );
  }
}
