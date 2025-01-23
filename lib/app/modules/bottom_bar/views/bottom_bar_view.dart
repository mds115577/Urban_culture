import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_cult/app/modules/home/views/home_view.dart';
import 'package:urban_cult/app/modules/streaks/views/streaks_view.dart';

import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  BottomBarView({super.key});
  final _pages = [HomeView(), StreaksView()];
  static ValueNotifier<int> selectedPageIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 232, 240),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   onPressed: () {

      //   },
      //   child: const Icon(
      //     Icons.add,
      //     size: 40,
      //   ),
      // ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: BottomBarView.selectedPageIndex,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              color: Color.fromARGB(255, 225, 214, 225),
            ))),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                  (Set<WidgetState> states) {
                    // Define the default text style
                    TextStyle defaultStyle = GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,

                      color: Color.fromARGB(152, 150, 79,
                          101), // Default color for unselected labels
                    );

                    // Check if the selected state is included
                    if (states.contains(WidgetState.selected)) {
                      // Set the color for the selected label
                      return defaultStyle.copyWith(
                          color: Color.fromARGB(255, 150, 79, 102),
                          fontWeight: FontWeight.bold);
                    }

                    // Return the default text style for other states
                    return defaultStyle;
                  },
                ),
              ),
              child: NavigationBar(
                backgroundColor: Color.fromARGB(255, 245, 232, 240),
                selectedIndex: updatedIndex,
                onDestinationSelected: (newIndex) {
                  BottomBarView.selectedPageIndex.value = newIndex;
                },
                destinations: const [
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.home,
                      size: 30,
                      color: Color.fromARGB(255, 150, 79, 102),
                    ),
                    icon: Icon(
                      Icons.home,
                      size: 30,
                      color: Color.fromARGB(152, 150, 79, 101),
                    ), // Centering the icon
                    label: 'Home',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.people_alt_outlined,
                      size: 30,
                      color: Color.fromARGB(255, 150, 79, 102),
                    ),
                    icon: Icon(Icons.people_alt_outlined,
                        color: Color.fromARGB(152, 150, 79, 101),
                        size: 30), // Centering the icon
                    label: 'Streaks',
                  ),
                ],
                labelBehavior: NavigationDestinationLabelBehavior
                    .alwaysShow, // Always show labels
                height: 70, // Adjust height if needed
                indicatorColor: Colors.transparent, // Remove round indicator
                shadowColor: Colors.transparent, // Remove any shadow effect
              ),
            ),
          );
        },
      ),

      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedPageIndex,
          builder: (BuildContext context, int updatedIndex, Widget? _) {
            return _pages[updatedIndex];
          },
        ),
      ),
    );
  }
}
