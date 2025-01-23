import 'package:get/get.dart';
import 'package:urban_cult/app/data/beauty_db_helper.dart';

class StreaksController extends GetxController {
  //TODO: Implement StreaksController

  final count = 0.obs;

  void increment() => count.value++;

  RxInt streakCount = RxInt(0);
  RxDouble streakPercent = RxDouble(0);
  getCount() async {
    final dbHelper = BeautyDatabaseHelper();

    streakCount.value = await dbHelper.getStreakCount();
    streakPercent.value = await dbHelper.getLast30DaysStreakPercentage();
  }
}
