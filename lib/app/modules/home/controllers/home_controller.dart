import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../data/beauty_db_helper.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List<DropdownMenuItem<String>> itemLists = [
    DropdownMenuItem(
      value: 'Face Wash',
      child: Text('Face Wash'),
    ),
    DropdownMenuItem(
      value: 'Toner',
      child: Text('Toner'),
    ),
    DropdownMenuItem(
      value: 'Lip Balm',
      child: Text('Lip Balm'),
    ),
    DropdownMenuItem(
      value: 'moisturizer',
      child: Text('moisturizer'),
    ),
    DropdownMenuItem(
      value: 'Sunscreen',
      child: Text('Sunscreen'),
    ),
  ];

  File? selectedImage;
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update();
    }
  }

  clearImage() {
    selectedImage = null;
    update();
  }

  String? name;
  String? dropDownValue;
  final TextEditingController descriptionController = TextEditingController();
  var isLoading = false.obs;
  var showLottie = false.obs;
  addToDb() async {
    final dbHelper = BeautyDatabaseHelper();
    isLoading.value = true;
    // Insert data
    await dbHelper.insertItem({
      'name': name,
      'description': descriptionController.text,
      'media': selectedImage!.path, // Can be image/video path
      'date': DateTime.now().toIso8601String(),
    }).then(
      (value) {
        descriptionController.clear();
        selectedImage = null;
        dropDownValue = null;
        update();
      },
    );
    showLottie.value = true;
    Future.delayed(Duration(seconds: 2), () {
      showLottie.value = false;
    }).then(
      (value) {
        Get.back();
      },
    );

    await checkDb();

    // Retrieve data

    isLoading.value = false;
    print('Beauty Items: $items');
  }

  RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;

  var isDailyCompleted = false.obs;

  checkDb() async {
    final dbHelper = BeautyDatabaseHelper();
    isDailyCompleted.value = await dbHelper.isDailyRoutineCompleted();
    final data = await dbHelper.getTodayEntries();
    items.assignAll(data);

    log(items.toString());

    log(itemLists.toString());
  }

  getDropDownList() async {
    final dbHelper = BeautyDatabaseHelper();
    isDailyCompleted.value = await dbHelper.isDailyRoutineCompleted();
    final data = await dbHelper.getTodayEntries();
    items.assignAll(data);
    itemLists.removeWhere((dropdownItem) {
      String dropdownItemName = dropdownItem.value!;
      return items.any((dbItem) => dbItem['name'] == dropdownItemName);
    });
    var uniqueItems = itemLists.toSet().toList();

    itemLists = uniqueItems;
  }

  void showCupertinoAlert(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Alert'),
          content: Column(
            children: [
              LottieBuilder.asset("assets/smartphone-camera.json"),
              Text("Please upload the picture")
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true, // Red text for destructive action
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Handle confirm action
                // Add your action here
              },
            ),
          ],
        );
      },
    );
  }
}
