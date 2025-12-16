import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// Assuming these imports exist in your project structure
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../controllers/scm_controller.dart';

// Import the refactored custom widgets
import '../../../shared/widgets/gradient_scroll_thumb.dart';
import '../../../shared/widgets/scm_widgets.dart';

class ScmView extends GetView<ScmController> with ScmWidgets {
  const ScmView({super.key});

  @override
  Widget build(BuildContext context) {
    final double thumbThickness = 5.w;
    final double thumbRadius = 5.r;
    final double listHeight = 250.h; // Fixed height for calculation

    // --- Define the Gradient Colors (Assuming they are not in AppColors) ---
    // If these were moved to AppColors, replace the definitions below
    const Color startColor = Color(0x9919416E); // Deep Blue with 60% opacity
    const Color endColor = Color(0x002F548C);   // Transparent

    return Scaffold(
      backgroundColor: AppColors.scmBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor4, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'SCM',
          style: h3.copyWith(
            color: AppColors.textColor4,
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16).r,
            child: SvgPicture.asset('assets/images/bell_icon.svg',height: 20.h,width: 20.h,),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main White Card Container
            Container(
              margin: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.borderColor, width: 1),
              ),
              child: Column(
                children: [
                  // Tabs
                  Container(
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
                        buildTab('Summary', true),
                        buildTab('SLD', false),
                        buildTab('Data', false),
                      ],
                    ),
                  ),
                  Divider(height: 0, color: AppColors.borderColor),

                  // Content Area
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
                        SizedBox(height: 40.h),

                        SizedBox(height: 150.h, child: _buildPowerCircle()),
                        SizedBox(height: 24.h),

                        // Source / Load Toggle
                        Container(
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8EDF2),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Row(
                            children: [
                              buildSourceLoadButton('Source', true),
                              buildSourceLoadButton('Load', false),
                            ],
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Divider(height: 2.h, color: AppColors.textColor3,thickness: 2,),
                        SizedBox(height: 12.h),

                        // List View and Scrollbar (The complex part)
                        SizedBox(
                          height: listHeight,
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is ScrollUpdateNotification) {
                                controller.scrollOffset.value = notification.metrics.pixels;
                              } else if (notification.metrics.maxScrollExtent > 0) {
                                controller.maxScrollExtent.value = notification.metrics.maxScrollExtent;
                                controller.viewportSize.value = notification.metrics.viewportDimension;
                              }
                              return false;
                            },
                            child: Stack(
                              children: [
                                // 1. Clipped List View and Gradient Overlay
                                Padding(
                                  padding: EdgeInsets.only(right: thumbThickness + 6.w), // Space for scrollbar
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Stack(
                                      children: [
                                        // List View
                                        ListView(
                                          controller: controller.scrollController,
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          children: [
                                            buildDataCard('Data View', 'assets/images/solar-cell_icon.png', true, '55505.63', '58805.63', AppColors.appColor3),
                                            SizedBox(height: 12.h),
                                            buildDataCard('Data Type 2', 'assets/images/power_icon.png', true, '55505.63', '58805.63', AppColors.orange),
                                            SizedBox(height: 12.h),
                                            buildDataCard('Data Type 3', 'assets/images/power_grid_icon.png', false, '55505.63', '58805.63', AppColors.appColor3),
                                            SizedBox(height: 12.h),
                                            buildDataCard('Data View', 'assets/images/solar-cell_icon.png', true, '55505.63', '58805.63', AppColors.appColor3),
                                            SizedBox(height: 12.h),
                                            buildDataCard('Data Type 2', 'assets/images/power_icon.png', true, '55505.63', '58805.63', AppColors.orange),
                                            SizedBox(height: 12.h),
                                            buildDataCard('Data Type 3', 'assets/images/power_grid_icon.png', false, '55505.63', '58805.63', AppColors.appColor3),
                                            SizedBox(height: 12.h),
                                            buildDataCard('Data View', 'assets/images/solar-cell_icon.png', true, '55505.63', '58805.63', AppColors.appColor3),
                                            SizedBox(height: 12.h),
                                            buildDataCard('Data Type 2', 'assets/images/power_icon.png', true, '55505.63', '58805.63', AppColors.orange),
                                            SizedBox(height: 12.h),
                                            buildDataCard('Data Type 3', 'assets/images/power_grid_icon.png', false, '55505.63', '58805.63', AppColors.appColor3),
                                          ],
                                        ),

                                        // Bottom Fading Gradient Shadow (clipped)
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: IgnorePointer(
                                              child: DecoratedBox(
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      startColor, // Use local colors
                                                      endColor,
                                                    ],
                                                    stops: [0.0, 1.0],
                                                  ),
                                                ),
                                                child: SizedBox(height: 30.h, width: double.infinity),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // 2. Custom Gradient Scroll Thumb (Separated)
                                Obx(() => GradientScrollThumb( // *** NO Positioned WRAPPING HERE ***
                                  thickness: thumbThickness,
                                  radius: thumbRadius,
                                  trackHeight: listHeight,
                                  totalScrollExtent: controller.maxScrollExtent.value,
                                  viewportDimension: controller.viewportSize.value,
                                  currentScrollOffset: controller.scrollOffset.value,
                                  scrollController: controller.scrollController,
                                  trackColor: Colors.black.withOpacity(0.1), // Increased visibility
                                )),
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

            // Bottom Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: buildActionButton('assets/images/analysis_icon.png', 'Analysis Pro')),
                      SizedBox(width: 12.w),
                      Expanded(child: buildActionButton('assets/images/generator_icon.png', 'G. Generator')),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(child: buildActionButton('assets/images/charge_icon.png', 'Plant Summary')),
                      SizedBox(width: 12.w),
                      Expanded(child: buildActionButton('assets/images/fire_icon.png', 'Natural Gas')),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(child: buildActionButton('assets/images/generator_icon.png', 'D. Generator')),
                      SizedBox(width: 12.w),
                      Expanded(child: buildActionButton('assets/images/faucet_icon.png', 'Water Process')),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
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
                value: 0.75,
                strokeWidth: 28.w,
                backgroundColor: const Color(0xFFE8EDF2),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.appColor2),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total Power',
                  style: h4.copyWith(color: AppColors.textColor4, fontSize: 12.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  '5.53 kw',
                  style: h2.copyWith(color: AppColors.textColor4, fontSize: 16.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}