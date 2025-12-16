// scm_controller.dart (Assuming this is your controller file)

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScmController extends GetxController {
  // ... (Your existing variables)
  final ScrollController scrollController = ScrollController();
  final maxScrollExtent = 0.0.obs;
  final viewportSize = 0.0.obs;
  final scrollOffset = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    // Call the method to ensure the scrollbar is visible on load
    _ensureScrollbarVisibility();
  }

  void _ensureScrollbarVisibility() {
    // Wait until the end of the current frame to ensure the ListView is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // If the list is scrollable, the maxScrollExtent should be > 0.
      if (scrollController.hasClients && scrollController.position.maxScrollExtent > 0) {
        // If it's already calculated, update the reactive variables immediately.
        maxScrollExtent.value = scrollController.position.maxScrollExtent;
        viewportSize.value = scrollController.position.viewportDimension;
      } else if (scrollController.hasClients) {
        // HACK: If the metrics are zero, a slight programmatic scroll often forces 
        // the NotificationListener to fire with the correct dimensions.
        // We scroll a tiny amount and immediately snap back.
        // This is necessary because sometimes NotificationListener fails to fire initially.
        final double initialOffset = scrollController.offset;

        scrollController.jumpTo(initialOffset + 0.1);
        scrollController.jumpTo(initialOffset);
      }
    });
  }
}