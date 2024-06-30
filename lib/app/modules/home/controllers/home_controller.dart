import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  StreamController<int> controller = StreamController<int>();

  RxList<String> items = [''].obs;

  int seed = 0;

  List<Color> colors = [
    Colors.blue.shade600,
    Colors.red.shade600,
    Colors.green.shade600,
    Colors.orange.shade600,
  ];

  TextEditingController itemController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    setDefaultItems();
  }

  setItems(String text) {
    final witems = text.split('\n');
    if (witems.length >= 2) {
      items.clear();
      for (var e in witems) {
        if (e.isNotEmpty) {
          items.add(e);
        }
      }
    } else {
      Get.snackbar('Error', 'Should have at least 2 items');
    }
  }

  void setDefaultItems() {
    items.value = [
      'Grogu',
      'Mace Windu',
      'Obi-Wan Kenobi',
      'Han Solo',
      'Luke Skywalker',
      'Darth Vader',
      'Yoda',
      'Ahsoka Tano',
    ];

    String itemText = '';

    for (var e in items) {
      itemText = '$itemText$e\n';
    }

    itemController.text = itemText;
  }
}
