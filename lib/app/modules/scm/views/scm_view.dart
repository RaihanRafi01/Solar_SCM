import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../controllers/scm_controller.dart';
import '../../../shared/widgets/scm_widgets.dart';
import 'action_screen_view.dart';
import 'data_detail_view.dart';

class ScmView extends GetView<ScmController> with ScmWidgets {
  const ScmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scmBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor4, size: 24.sp),
          onPressed: () {
            if (controller.activeView.value != ScmContentView.initialSummary) {
              controller.navigateToSummary();
            } else {
              Get.back();
            }
          },
        ),
        title: Text(
          'SCM',
          style: h3.copyWith(color: AppColors.textColor4, fontSize: 24.sp),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16).r,
            child: SvgPicture.asset(
              AppAssets.bellIcon,
              height: 20.h,
              width: 20.h,
            ),
          )
        ],
      ),
      body: Obx(() {
        switch (controller.activeView.value) {
          case ScmContentView.initialSummary:
            return _buildInitialSummaryContent(context);
          case ScmContentView.actionScreen:
            return const ActionScreenView();
          case ScmContentView.dataDetail:
            return const DataDetailView();
          default:
            return _buildInitialSummaryContent(context);
        }
      }),
    );
  }

  Widget _buildInitialSummaryContent(BuildContext context) {
    const double listHeight = 250;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderColor, width: 1),
            ),
            child: Column(
              children: [
                // TAB SELECTION SECTION
                Obx(() => Container(
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                  ),
                  child: Row(
                    children: [
                      _internalTab('Summary'),
                      _internalTab('SLD'),
                      _internalTab('Data'),
                    ],
                  ),
                )),
                Divider(height: 0, color: AppColors.borderColor),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Electricity',
                        style: h2.copyWith(
                          color: AppColors.textColor3,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Divider(height: 1.h, color: AppColors.textColor3),
                      SizedBox(height: 30.h),
                      SizedBox(height: 150.h, child: _buildPowerCircle()),
                      SizedBox(height: 24.h),

                      // SOURCE / LOAD SELECTION SECTION
                      Obx(() => Container(
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8EDF2),
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          children: [
                            _internalSourceLoadBtn('Source'),
                            _internalSourceLoadBtn('Load'),
                          ],
                        ),
                      )),

                      SizedBox(height: 6.h),
                      Divider(height: 2.h, color: AppColors.textColor3, thickness: 2),
                      SizedBox(height: 12.h),

                      // SCROLLABLE LIST AREA
                      SizedBox(
                        height: listHeight.h,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollUpdateNotification) {
                              controller.scrollOffset.value = notification.metrics.pixels;
                            }
                            if (notification is ScrollMetricsNotification || notification is OverscrollNotification) {
                              if (notification.metrics.maxScrollExtent > 0) {
                                controller.maxScrollExtent.value = notification.metrics.maxScrollExtent;
                                controller.viewportSize.value = notification.metrics.viewportDimension;
                              }
                            }
                            return true;
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.r),
                                  child: Stack(
                                    children: [
                                      ListView(
                                        controller: controller.scrollController,
                                        physics: const ClampingScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        children: [
                                          buildDataCard('Data View', AppAssets.solarCellIcon, true, '55505.63', '58805.63', AppColors.appColor3),
                                          SizedBox(height: 12.h),
                                          buildDataCard('Data Type 2', AppAssets.powerIcon, true, '55505.63', '58805.63', AppColors.orange),
                                          SizedBox(height: 12.h),
                                          buildDataCard('Data Type 3', AppAssets.powerGridIcon, false, '55505.63', '58805.63', AppColors.appColor3),
                                          SizedBox(height: 12.h),
                                          buildDataCard('Data View', AppAssets.solarCellIcon, true, '55505.63', '58805.63', AppColors.appColor3),
                                          SizedBox(height: 12.h),
                                          buildDataCard('Data Type 2', AppAssets.powerIcon, true, '55505.63', '58805.63', AppColors.orange),
                                          SizedBox(height: 12.h),
                                          buildDataCard('Data Type 3', AppAssets.powerGridIcon, false, '55505.63', '58805.63', AppColors.appColor3),
                                        ],
                                      ),
                                      _buildBottomGradient(),
                                    ],
                                  ),
                                ),
                              ),
                              _buildCustomScrollbar(listHeight),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  // Helper to build Top Tabs
  Widget _internalTab(String label) {
    bool isSelected = controller.selectedTab.value == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectTab(label),
        child: buildTab(label, isSelected),
      ),
    );
  }

  // Helper to build Source/Load Buttons
  Widget _internalSourceLoadBtn(String label) {
    bool isSelected = controller.selectedSourceLoad.value == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectSourceLoad(label),
        child: buildSourceLoadButton(label, isSelected),
      ),
    );
  }

  Widget _buildBottomGradient() {
    return Positioned(
      left: 0, right: 0, bottom: 0,
      child: IgnorePointer(
        child: Container(
          height: 30.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppColors.startColor, AppColors.endColor.withOpacity(0)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomScrollbar(double listHeight) {
    return Align(
      alignment: Alignment.centerRight,
      child: Obx(() {
        final double trackHeight = listHeight.h;
        const double thumbHeight = 33.0;
        final double maxExtent = controller.maxScrollExtent.value;
        final double scrollOffset = controller.scrollOffset.value;
        final double scrollPercent = maxExtent > 0 ? (scrollOffset / maxExtent).clamp(0.0, 1.0) : 0.0;
        final double topPosition = (trackHeight - thumbHeight.h) * scrollPercent;

        return Container(
          width: 4.w,
          height: trackHeight,
          margin: EdgeInsets.only(right: 4.w),
          decoration: BoxDecoration(
            color: AppColors.borderColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Stack(
            children: [
              Positioned(
                top: topPosition, left: 0, right: 0,
                child: Container(
                  height: thumbHeight.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    gradient: const LinearGradient(
                      colors: [AppColors.indicatorColor1, AppColors.indicatorColor2],
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: buildActionButton(AppAssets.analysisIcon, 'Analysis Pro')),
              SizedBox(width: 12.w),
              Expanded(child: buildActionButton(AppAssets.generatorIcon, 'G. Generator')),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(child: buildActionButton(AppAssets.chargeIcon, 'Plant Summary')),
              SizedBox(width: 12.w),
              Expanded(child: buildActionButton(AppAssets.fireIcon, 'Natural Gas')),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(child: buildActionButton(AppAssets.generatorIcon, 'D. Generator')),
              SizedBox(width: 12.w),
              Expanded(child: buildActionButton(AppAssets.faucetIcon, 'Water Process')),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildPowerCircle() {
    return Center(
      child: SizedBox(
        width: 150.w,
        height: 150.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200.w,
              height: 200.h,
              child: CircularProgressIndicator(
                value: 1,
                strokeWidth: 28.w,
                backgroundColor: const Color(0xFFE8EDF2),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.appColor2),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Total Power', style: h4.copyWith(color: AppColors.textColor4, fontSize: 12.sp)),
                SizedBox(height: 4.h),
                Text('5.53 kw', style: h2.copyWith(color: AppColors.textColor4, fontSize: 16.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}