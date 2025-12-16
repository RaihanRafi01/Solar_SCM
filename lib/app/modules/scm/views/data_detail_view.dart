import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../controllers/scm_controller.dart';

class CustomArcPainter extends CustomPainter {
  final Color foregroundColor;
  final Color backgroundColor;
  final double strokeWidth;
  final double progress;

  CustomArcPainter({
    required this.foregroundColor,
    required this.backgroundColor,
    required this.strokeWidth,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final foregroundPaint = Paint()
      ..color = foregroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const double startAngle = 5 * pi / 6;

    const double sweepAngle = 4 * pi / 3;

    canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        backgroundPaint
    );

    canvas.drawArc(
        rect,
        startAngle,
        sweepAngle * progress,
        false,
        foregroundPaint
    );
  }

  @override
  bool shouldRepaint(CustomArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}


class DataDetailView extends GetView<ScmController> {
  const DataDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD7E3F0),
      child: Stack(
        children: [
          Positioned.fill(
            top: 40.h,
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
                      controller.isDataViewSelected.value
                          ? _buildDataViewContent()
                          : _buildRevenueViewContent(),

                      SizedBox(height: 30.h),
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
                      ],

                      SizedBox(height: 16.h),

                      _buildEnergyChartCard(
                        title: 'Energy Chart',
                        dataTotal: '20.05 kw',
                      ),

                      SizedBox(height: 20.h),

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

  Widget _buildDataViewContent() {
    return SizedBox(
      width: 160.w,
      height: 160.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(160.w, 160.w),
            painter: CustomArcPainter(
              foregroundColor: AppColors.primary,
              backgroundColor: const Color(0xFFE3F2FD),
              strokeWidth: 12.w,
              progress: 0.7,
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

  Widget _buildRevenueViewContent() {
    return SizedBox(
      width: 160.w,
      height: 160.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(160.w, 160.w),
            painter: CustomArcPainter(
              foregroundColor: AppColors.primary,
              backgroundColor: const Color(0xFFE3F2FD),
              strokeWidth: 12.w,
              progress: 0.9,
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