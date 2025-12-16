import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// Assuming these imports are correct based on your snippet
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../controllers/scm_controller.dart';

class DataDetailView extends GetView<ScmController> {
  const DataDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller is available as 'controller'
    return Container(
      color: const Color(0xFFD7E3F0),
      child: Stack(
        children: [
          // Main curved card with all content
          Positioned.fill(
            top: 40.h, // Half of the toggle button height
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Obx(
                      () => Column(
                    children: [
                      SizedBox(height: 50.h),

                      // Conditional Content based on View Selection
                      controller.isDataViewSelected.value
                          ? _buildDataViewContent() // Data View Content
                          : _buildRevenueViewContent(), // Revenue View Content

                      SizedBox(height: 30.h),

                      // Date Filter Section - Centered and Functional
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, // CENTERED
                          children: [
                            // Today Data Filter
                            GestureDetector(
                              onTap: () => controller.isTodaySelected.value = true,
                              child: _buildDateFilterChip(
                                label: 'Today Data',
                                isSelected: controller.isTodaySelected.value,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Custom Date Data Filter
                            GestureDetector(
                              onTap: () => controller.isTodaySelected.value = false,
                              child: _buildDateFilterChip(
                                label: 'Custom Date Data',
                                isSelected: !controller.isTodaySelected.value,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Date Pickers Row - Conditional
                      if (!controller.isTodaySelected.value)...[
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16).r,
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildDatePickerContainer('From Date'),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: _buildDatePickerContainer('To Date'),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  Icons.search,
                                  size: 20.w,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ], // ONLY SHOW on Custom Date


                      SizedBox(height: 16.h),

                      // Energy Chart Card 1
                      _buildEnergyChartCard(
                        title: 'Energy Chart',
                        dataTotal: '20.05 kw',
                      ),

                      SizedBox(height: 20.h),

                      // Energy Chart Card 2
                      _buildEnergyChartCard(
                        title: 'Energy Chart',
                        dataTotal: '5.53 kw',
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // View Toggle Buttons - positioned on top center of curved card
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.borderColor2, width: 1),
                ),
                child: Obx(
                      () => Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Data View Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.isDataViewSelected.value = true,
                          child: _buildToggleButton(
                            label: 'Data View',
                            isSelected: controller.isDataViewSelected.value,
                          ),
                        ),
                      ),
                      // Revenue View Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.isDataViewSelected.value = false,
                          child: _buildToggleButton(
                            label: 'Revenue View',
                            isSelected: !controller.isDataViewSelected.value,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Builders for Abstraction and Re-use ---

  // Build the content for Data View (CircularProgressIndicator from top)
  Widget _buildDataViewContent() {
    return SizedBox(
      width: 160.w,
      height: 160.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 160.w,
            height: 160.w,
            child: CircularProgressIndicator(
              value: 0.7,
              strokeWidth: 12.w,
              backgroundColor: const Color(0xFFE3F2FD),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '57.00',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F1E32),
                ),
              ),
              Text(
                'kWh/Sqft',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF757575),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build the content for Revenue View (Opposite-U CircularProgressIndicator)
  Widget _buildRevenueViewContent() {
    return SizedBox(
      width: 160.w,
      height: 160.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Custom CircularProgressIndicator (Opposite of U shape)
          // Starts from left (pi), goes to right (2*pi or 0), then to pi/2 (top)
          Transform.rotate(
            angle: -3.14159, // Rotate by 180 degrees (to start from left and make it opposite U)
            child: SizedBox(
              width: 160.w,
              height: 160.w,
              child: CircularProgressIndicator(
                value: 0.7, // Example value
                strokeWidth: 12.w,
                backgroundColor: const Color(0xFFE3F2FD),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                strokeCap: StrokeCap.round,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '12,500',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F1E32),
                ),
              ),
              Text(
                'Revenue/Sqft',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF757575),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Date Filter Chip Builder (Same circle logic)
  Widget _buildDateFilterChip({required String label, required bool isSelected}) {
    final color = isSelected ? AppColors.primary :  AppColors.textColor2;

    return Row(
      children: [
        Container(
          width: 14.w,
          height: 14.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: h4.copyWith(
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? AppColors.primary : color,
          ),
        ),
      ],
    );
  }

  // Date Picker Container Builder
  Widget _buildDatePickerContainer(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF757575),
            ),
          ),
          const Spacer(),
          Icon(
            Icons.calendar_today_outlined,
            size: 16.w,
            color: const Color(0xFF757575),
          ),
        ],
      ),
    );
  }

  // View Toggle Button Builder
  Widget _buildToggleButton({required String label, required bool isSelected}) {
    final color = isSelected ? AppColors.primary : AppColors.borderColor2;
    final textColor = isSelected ? AppColors.primary : AppColors.textColor2;
    final textStyle = isSelected ? h2 : h4;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 14.w,
          height: 14.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: textStyle.copyWith(
            fontSize: 16.sp,
            color: textColor,
          ),
        ),
      ],
    );
  }

  // Energy Chart Card Builder
  Widget _buildEnergyChartCard({required String title, required String dataTotal}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor1,
                ),
              ),
              Text(
                dataTotal,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F1E32),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Data Cards
          _buildDataCard('Data A', const Color(0xFF2196F3), '2798.50 (29.53%)', '35689 ৳'),
          SizedBox(height: 12.h),
          _buildDataCard('Data B', const Color(0xFF42C5F5), '72598.50 (35.39%)', '5259689 ৳'),
          SizedBox(height: 12.h),
          _buildDataCard('Data C', const Color(0xFF9C27B0), '6598.36 (83.90%)', '5698756 ৳'),
          SizedBox(height: 12.h),
          _buildDataCard('Data D', const Color(0xFFFF9800), '6598.26 (36.59%)', '356987 ৳'),
        ],
      ),
    );
  }

  // Data Card Builder (from your original code)
  Widget _buildDataCard(String label, Color color, String dataValue, String costValue) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
      ),
      child: Row(
        children: [
          // Color indicator and label
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 1,
                height: 40.h,
                color: const Color(0xFFE0E0E0),
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor1,
                ),
              ),
            ],
          ),

          SizedBox(width: 16.w),

          // Data and Cost
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Data',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textColor2,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      ':',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textColor2,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      dataValue,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      'Cost',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textColor2,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      ':',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textColor2,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      costValue,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}