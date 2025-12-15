import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScmController extends GetxController {
  //TODO: Implement ScmController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final ScrollController scrollController = ScrollController();

  final RxDouble scrollOffset = 0.0.obs;
  final RxDouble maxScrollExtent = 0.0.obs;
  final RxDouble viewportSize = 0.0.obs;

  void increment() => count.value++;
}
