import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// These imports are assumed to exist in your project
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../../../shared/widgets/gradient_scroll_thumb.dart';
import '../controllers/scm_controller.dart';

// Full ScmView Implementation
class ScmView extends GetView<ScmController> {
  const ScmView({super.key});

  @override
  Widget build(BuildContext context) {

    final double thumbThickness = 8.w;
    final double thumbRadius = 5.r;
    final double listHeight = 250.h; // Fixed height for calculation
    return Scaffold(
      backgroundColor: AppColors.scmBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'SCM',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined,
                    color: AppColors.textPrimary, size: 24.sp),
                onPressed: () {},
              ),
              Positioned(
                right: 12.w,
                top: 12.h,
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
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
                        _buildTab('Summary', true),
                        _buildTab('SLD', false),
                        _buildTab('Data', false),
                      ],
                    ),
                  ),
                  Divider(height: 0, color: AppColors.borderColor),

                  // Content Area
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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

                        // Power Circle
                        Center(
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
                        ),
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
                              _buildSourceLoadButton('Source', true),
                              _buildSourceLoadButton('Load', false),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),

                        SizedBox(
                          height: listHeight,
                          child: NotificationListener<ScrollNotification>(
                            // 1. Listen for scroll events to update reactive variables
                            onNotification: (notification) {
                              if (notification is ScrollUpdateNotification) {
                                controller.scrollOffset.value = notification.metrics.pixels;
                              } else if (notification.metrics.maxScrollExtent > 0) {
                                // Update dimensions when scroll metrics are available
                                controller.maxScrollExtent.value = notification.metrics.maxScrollExtent;
                                controller.viewportSize.value = notification.metrics.viewportDimension;
                              }
                              return false; // Allow notification to bubble up
                            },
                            child: Stack(
                              children: [
                                // List View
                                ListView(
                                  controller: controller.scrollController, // Attach controller
                                  padding: EdgeInsets.only(right: 16.w),
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  children: [
                                    _buildDataCard('Data View', 'assets/images/solar-cell_icon.png', true, '55505.63', '58805.63', AppColors.appColor3),
                                    SizedBox(height: 12.h),
                                    _buildDataCard('Data Type 2', 'assets/images/power_icon.png', true, '55505.63', '58805.63', AppColors.orange),
                                    SizedBox(height: 12.h),
                                    _buildDataCard('Data Type 3', 'assets/images/power_grid_icon.png', false, '55505.63', '58805.63', AppColors.appColor3),
                                    SizedBox(height: 12.h),
                                    _buildDataCard('Data View', 'assets/images/solar-cell_icon.png', true, '55505.63', '58805.63', AppColors.appColor3),
                                    SizedBox(height: 12.h),
                                    _buildDataCard('Data Type 2', 'assets/images/power_icon.png', true, '55505.63', '58805.63', AppColors.orange),
                                    SizedBox(height: 12.h),
                                    _buildDataCard('Data Type 3', 'assets/images/power_grid_icon.png', false, '55505.63', '58805.63', AppColors.appColor3),
                                  ],
                                ),

                                // 2. Custom Gradient Thumb (Reactive)
                                Obx(() => GradientScrollThumb(
                                  thickness: thumbThickness,
                                  radius: thumbRadius,
                                  trackHeight: listHeight, // Use trackHeight instead of height
                                  totalScrollExtent: controller.maxScrollExtent.value,
                                  viewportDimension: controller.viewportSize.value,
                                  currentScrollOffset: controller.scrollOffset.value,
                                  scrollController: controller.scrollController, // NEW: Pass the controller
                                  trackColor: AppColors.borderColor, // Example track color
                                ),
                                ),
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildActionButton('📊', 'Analysis Pro')),
                      SizedBox(width: 12.w),
                      Expanded(child: _buildActionButton('🔧', 'G. Generator')),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(child: _buildActionButton('⚡', 'Plant Summary')),
                      SizedBox(width: 12.w),
                      Expanded(child: _buildActionButton('🔥', 'Natural Gas')),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(child: _buildActionButton('🔧', 'D. Generator')),
                      SizedBox(width: 12.w),
                      Expanded(child: _buildActionButton('🚰', 'Water Process')),
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

  Widget _buildTab(String title, bool isActive) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.textColor2,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSourceLoadButton(String title, bool isActive) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(25.r),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.textHint,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCard(
      String title,
      String icon,
      bool isActive,
      String data1,
      String data2,
      Color indicatorColor,
      ) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: AppColors.cardColor1,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.borderColor2,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Image.asset(icon,height: 24.h,width: 24.h,),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: indicatorColor,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      title,
                      style: h3.copyWith(
                        color: AppColors.textColor4,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      isActive ? '(Active)' : '(Inactive)',
                      style: h3.copyWith(
                        color: isActive ? AppColors.primary : AppColors.red,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Data 1    : ', style: h4.copyWith(fontSize: 12,color: AppColors.textColor2)),
                      TextSpan(text: data1, style: h4.copyWith(fontSize: 12)), // This part is BLACK
                    ],
                  ),
                ),
                SizedBox(height: 2.h),

                // --- Data 2 with Rich Text ---
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Data 2    : ', style: h4.copyWith(fontSize: 12,color: AppColors.textColor2)),
                      TextSpan(text: data2, style: h4.copyWith(fontSize: 12)), // This part is BLACK
                    ],
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset('assets/images/right_icon.svg')
        ],
      ),
    );
  }

  Widget _buildActionButton(String icon, String title) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: TextStyle(fontSize: 24.sp)),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}