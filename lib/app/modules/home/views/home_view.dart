import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:urban_cult/app/modules/home/widgets/add_item_screen.dart';
import 'package:urban_cult/app/modules/home/widgets/home_listtile.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() {
        return Visibility(
          visible: homeController.isDailyCompleted.value ? false : true,
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 224, 211, 215),
            onPressed: () {
              Get.to(AddItemScreen(
                homeController: homeController,
              ));
            },
            child: Icon(Icons.add),
          ),
        );
      }),
      backgroundColor: Color.fromARGB(255, 245, 232, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 232, 240),
        title: Text(
          'Daily Skincare',
          style:
              GoogleFonts.epilogue(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // HomeListtile(), HomeListtile(), HomeListtile(), HomeListtile(),
          FutureBuilder(
            future: homeController.checkDb(),
            builder: (context, snapshot) {
              return Obx(() {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homeController.items.length,
                    itemBuilder: (context, index) {
                      final data = homeController.items[index];
                      return HomeListtile(
                        description: data['description'],
                        name: data['name'],
                        time: data['date'],
                      );
                    });
              });
            },
          ),

          Obx(() {
            return Column(
              children: [
                homeController.items.length == 5
                    ? Icon(
                        Icons.verified,
                        size: 100,
                        color: Colors.green,
                      )
                    : LottieBuilder.asset(
                        (homeController.items.length < 5 &&
                                homeController.items.isNotEmpty)
                            ? "assets/still_there.json"
                            : "assets/Animation - 1737554899435.json",
                        height: (homeController.items.length < 5 &&
                                homeController.items.isNotEmpty)
                            ? 150
                            : null,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Builder(builder: (context) {
                      return Text(
                        (homeController.items.length < 5 &&
                                homeController.items.isNotEmpty)
                            ? "Complete your tasks"
                            : homeController.items.length == 5
                                ? "Done For the day"
                                : "Add your daily routine",
                        style: GoogleFonts.belleza(
                          color: const Color.fromARGB(255, 86, 35, 53),
                          fontSize:
                              MediaQuery.sizeOf(context).width * (10 / 100),
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                  ],
                )
              ],
            );
          }),

          // Row(
          //   children: [
          //     Container(
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           color: const Color.fromARGB(255, 224, 211, 215)),
          //       height: 48,
          //       width: 48,
          //       child: Icon(Icons.check),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
