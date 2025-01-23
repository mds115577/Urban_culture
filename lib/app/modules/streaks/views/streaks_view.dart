import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_cult/app/modules/streaks/widget/helper_widget_chart.dart';

import '../controllers/streaks_controller.dart';

class StreaksView extends GetView<StreaksController> {
  StreaksView({super.key});

  final StreaksController streaksController = Get.put(StreaksController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 232, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 232, 240),
        title: Text(
          'Streaks',
          style:
              GoogleFonts.epilogue(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: streaksController.getCount(),
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Goal: ${streaksController.streakCount.value} streak days",
                        style: GoogleFonts.epilogue(
                            color: const Color.fromARGB(255, 28, 19, 13),
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 224, 211, 215)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Streak Days",
                                style: GoogleFonts.epilogue(
                                    color:
                                        const Color.fromARGB(255, 28, 19, 13),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${streaksController.streakCount.value}",
                                style: GoogleFonts.epilogue(
                                    color:
                                        const Color.fromARGB(255, 28, 19, 13),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Daily Streak",
                        style: GoogleFonts.epilogue(
                            color: const Color.fromARGB(255, 28, 19, 13),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${streaksController.streakCount.value}",
                        style: GoogleFonts.epilogue(
                            color: const Color.fromARGB(255, 28, 19, 13),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text("Last 30 Days",
                              style: GoogleFonts.epilogue(
                                color: const Color.fromARGB(255, 150, 79, 102),
                                fontSize: 16,
                              )),
                          Obx(() {
                            return Text(
                                "+${streaksController.streakPercent.value}%",
                                style: GoogleFonts.epilogue(
                                  color: const Color.fromARGB(255, 8, 135, 89),
                                  fontSize: 16,
                                ));
                          })
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 50), // Top padding
                          SizedBox(
                            height: 150,
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(show: false),
                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  leftTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                      getTitlesWidget: (value, meta) {
                                        switch (value.toInt()) {
                                          case 1:
                                            return buildLabel('1D');
                                          case 2:
                                            return buildLabel('1W');
                                          case 3:
                                            return buildLabel('1M');
                                          case 4:
                                            return buildLabel('3M');
                                          case 5:
                                            return buildLabel('1Y');
                                          default:
                                            return const Text('');
                                        }
                                      },
                                      interval: 1,
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: [
                                      FlSpot(1, 3),
                                      FlSpot(2, 2.8),
                                      FlSpot(3, 3.5),
                                      FlSpot(4, 2.5),
                                      FlSpot(5, 3.8),
                                      FlSpot(6, 3.2),
                                      FlSpot(7, 4.0),
                                      FlSpot(8, 3.1),
                                      FlSpot(9, 3.6),
                                    ],
                                    isCurved: true,
                                    color: const Color(
                                        0xFF814C59), // Brownish color from image
                                    barWidth: 2,
                                    dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(show: false),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Custom buttons for time range selection
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildTextButton('1D'),
                              buildTextButton('1W'),
                              buildTextButton('1M'),
                              buildTextButton('3M'),
                              buildTextButton('1Y'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Keep it up! You're on a roll.",
                        style: GoogleFonts.epilogue(
                          color: const Color.fromARGB(255, 28, 19, 13),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 224, 211, 215)),
                          height: 40,
                          width: MediaQuery.sizeOf(context).width,
                          child: Center(
                            child: Text(
                              "Get Started",
                              style: GoogleFonts.epilogue(
                                  color: const Color.fromARGB(255, 28, 19, 13),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
