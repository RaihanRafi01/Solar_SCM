import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ScmContentView { initialSummary, actionScreen, dataDetail }

class ScmController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final maxScrollExtent = 0.0.obs;
  final viewportSize = 0.0.obs;
  final scrollOffset = 0.0.obs;

  final activeView = ScmContentView.initialSummary.obs;
  final isRevenueDataExpanded = false.obs;

  // New Observables for UI Selection
  final selectedTab = 'Summary'.obs; // Options: 'Summary', 'SLD', 'Data'
  final selectedSourceLoad = 'Source'.obs; // Options: 'Source', 'Load'

  RxBool isDataViewSelected = true.obs;
  RxBool isTodaySelected = true.obs;

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
      }
    });
  }

  void navigateToActionScreen() => activeView.value = ScmContentView.actionScreen;
  void navigateToDataDetail() => activeView.value = ScmContentView.dataDetail;
  void navigateToSummary() => activeView.value = ScmContentView.initialSummary;

  // Selection Methods
  void selectTab(String tabName) => selectedTab.value = tabName;
  void selectSourceLoad(String type) => selectedSourceLoad.value = type;
}