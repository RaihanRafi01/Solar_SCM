import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ScmContentView {
  initialSummary,
  actionScreen,
  dataDetail
}

class ScmController extends GetxController {

  final ScrollController scrollController = ScrollController();
  final maxScrollExtent = 0.0.obs;
  final viewportSize = 0.0.obs;
  final scrollOffset = 0.0.obs;

  final activeView = ScmContentView.initialSummary.obs;

  @override
  void onReady() {
    super.onReady();
    _ensureScrollbarVisibility();
  }

  void _ensureScrollbarVisibility() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients && scrollController.position.maxScrollExtent > 0) {
        maxScrollExtent.value = scrollController.position.maxScrollExtent;
        viewportSize.value = scrollController.position.viewportDimension;
      } else if (scrollController.hasClients) {
        final double initialOffset = scrollController.offset;
        scrollController.jumpTo(initialOffset + 0.1);
        scrollController.jumpTo(initialOffset);
      }
    });
  }

  // 3. Navigation Methods
  void navigateToActionScreen() {
    activeView.value = ScmContentView.actionScreen;
  }

  void navigateToDataDetail() {
    activeView.value = ScmContentView.dataDetail;
  }

  void navigateToSummary() {
    activeView.value = ScmContentView.initialSummary;
  }
}
