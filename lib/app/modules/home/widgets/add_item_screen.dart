import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:urban_cult/app/modules/home/controllers/home_controller.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key, required this.homeController});
  final HomeController homeController;

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    widget.homeController.getDropDownList();
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200)
        // Use `this` since our widget mixes in SingleTickerProviderStateMixin
        ); // Make the animation repeat
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  late final AnimationController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 232, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 232, 240),
      ),
      body: Stack(
        children: [
          ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      GetBuilder<HomeController>(builder: (context) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.homeController.pickImage();
                              },
                              child: CircleAvatar(
                                radius: 65,
                                backgroundColor:
                                    const Color.fromARGB(255, 79, 79, 79),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor:
                                      Color.fromARGB(255, 86, 35, 53),
                                  backgroundImage: widget
                                              .homeController.selectedImage !=
                                          null
                                      ? FileImage(
                                          widget.homeController.selectedImage!)
                                      : null,
                                  child: widget.homeController.selectedImage ==
                                          null
                                      ? Icon(Icons.camera_alt,
                                          size: 40, color: Colors.white)
                                      : null,
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  widget.homeController.selectedImage == null
                                      ? false
                                      : true,
                              child: TextButton.icon(
                                onPressed: () {
                                  widget.homeController.clearImage();
                                },
                                label: Text(
                                  "Clear",
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 217, 52, 41),
                                  ),
                                ),
                                icon: Icon(
                                  Icons.delete,
                                  color: const Color.fromARGB(255, 217, 52, 41),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      GetBuilder<HomeController>(builder: (contesxt) {
                        return DropdownButtonFormField<String>(
                          value: widget.homeController.dropDownValue,
                          items: widget.homeController.itemLists,
                          onChanged: (value) {
                            widget.homeController.name = value.toString();
                            log(widget.homeController.name!);
                          },
                          decoration: InputDecoration(
                            labelText: "Name of the Task",
                            hintText: "Name of the Task",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 86, 35, 53),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 245, 232, 240),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 86, 35, 53),
                                width: .2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 86, 35, 53),
                                width: .2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 86, 35, 53),
                                width: .2,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                          ),
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return 'Please select a task';
                            }
                            return null;
                          },
                          dropdownColor: Color.fromARGB(255, 245, 232, 240),
                          icon: Icon(Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 86, 35, 53)),
                        );
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: widget.homeController.descriptionController,
                        maxLines: 3,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          // prefixIcon: Icon(icon, color: Color.fromARGB(255, 86, 35, 53)),
                          labelText: "Description",
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 86, 35, 53),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 86, 35, 53),
                              width: .2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 86, 35, 53),
                              width: .2,
                            ),
                          ),
                          fillColor: Color.fromARGB(255, 245, 232, 240),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 86, 35, 53),
                              width: .2,
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: widget.homeController.isLoading.value
                            ? null
                            : () {
                                if (widget.homeController.selectedImage ==
                                    null) {
                                  return widget.homeController
                                      .showCupertinoAlert(context);
                                }
                                if (formKey.currentState!.validate()) {
                                  widget.homeController.addToDb();
                                }
                              },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 224, 211, 215)),
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          child: Obx(() {
                            return Center(
                              child: widget.homeController.isLoading.value
                                  ? SpinKitFadingFour(
                                      size: 40,
                                      color:
                                          const Color.fromARGB(255, 28, 19, 13),
                                      controller: _controller,
                                    )
                                  : Text(
                                      "Submit",
                                      style: GoogleFonts.epilogue(
                                          color: const Color.fromARGB(
                                              255, 28, 19, 13),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Obx(() {
            return Visibility(
                visible: widget.homeController.showLottie.value ? true : false,
                child: LottieBuilder.asset(
                  "assets/success.json",
                ));
          }),
        ],
      ),
    );
  }
}
