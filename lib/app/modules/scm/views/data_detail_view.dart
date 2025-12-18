import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);

    canvas.drawArc(
        rect, startAngle, sweepAngle * progress, false, foregroundPaint);
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
      color: AppColors.scmBackground,
      child: Stack(
        children: [
          Positioned.fill(
            top: 40.h,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
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
                      if (controller.isDataViewSelected.value) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                controller.isTodaySelected.value = true,
                                child: _buildDateFilterChip(
                                  label: 'Today Data',
                                  isSelected: controller.isTodaySelected.value,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              GestureDetector(
                                onTap: () =>
                                controller.isTodaySelected.value = false,
                                child: _buildDateFilterChip(
                                  label: 'Custom Date Data',
                                  isSelected: !controller.isTodaySelected.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          child: !controller.isTodaySelected.value
                              ? Column(
                            children: [
                              SizedBox(height: 12.h),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 16.r),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _buildDatePickerContainer(
                                          'From Date'),
                                    ),
                                    SizedBox(width: 5.w),
                                    Expanded(
                                      child: _buildDatePickerContainer(
                                          'To Date'),
                                    ),
                                    SizedBox(width: 5.w),
                                    Container(
                                        height: 36.h,
                                        width: 34.h,
                                        padding: EdgeInsets.all(8).r,
                                        decoration: BoxDecoration(
                                            color: AppColors.cream,
                                            borderRadius:
                                            BorderRadius.circular(6.r),
                                            border: Border.all(
                                                color: AppColors.primary)),
                                        child: SvgPicture.asset(
                                            'assets/images/search_icon.svg')),
                                  ],
                                ),
                              ),
                            ],
                          )
                              : const SizedBox.shrink(),
                        ),
                        SizedBox(height: 16.h),
                        _buildEnergyChartCard(
                          title: 'Energy Chart',
                          dataTotal: controller.isTodaySelected.value
                              ? '20.05 kw'
                              : '125.40 kw',
                        ),
                        if (!controller.isTodaySelected.value) ...[
                          SizedBox(height: 16.h),
                          _buildEnergyChartCard(
                            title: 'Secondary Chart',
                            dataTotal: '5.53 kw',
                          ),
                        ],
                        SizedBox(height: 20.h),
                      ],
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
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                          controller.isDataViewSelected.value = true,
                          child: _buildToggleButton(
                            label: 'Data View',
                            isSelected: controller.isDataViewSelected.value,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                          controller.isDataViewSelected.value = false,
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
    return Obx(() {
      double progress = controller.isTodaySelected.value ? 0.57 : 0.77;
      String value = controller.isTodaySelected.value ? '57.00' : '77.30';

      return SizedBox(
        width: 160.w,
        height: 160.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progress),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return CustomPaint(
                  size: Size(160.w, 160.w),
                  painter: CustomArcPainter(
                    foregroundColor: AppColors.primary,
                    backgroundColor: AppColors.primary.withOpacity(0.15),
                    strokeWidth: 16.w,
                    progress: value,
                  ),
                );
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: h3.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.textColor4,
                  ),
                ),
                Text(
                  'kWh/Sqft',
                  style: h3.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.textColor4,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildRevenueViewContent() {
    return Obx(() => Column(
      children: [
        SizedBox(
          width: 160.w,
          height: 160.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(160.w, 160.w),
                painter: CustomArcPainter(
                  foregroundColor: AppColors.primary,
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  strokeWidth: 16.w,
                  progress: 0.9,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '8897455',
                    style: h3.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.textColor4,
                    ),
                  ),
                  Text(
                    'tk',
                    style: h3.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.textColor4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.borderColor2, width: 1),
          ),
          child: Column(
            children: [
              // Header
              InkWell(
                onTap: () => controller.isRevenueDataExpanded.value =
                !controller.isRevenueDataExpanded.value,
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.borderColor2, width: 1),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/solar_chart-bold_icon.svg',
                        height: 15.h,
                        width: 16.13.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Data & Cost Info',
                        style: h2.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.textColor4,
                        ),
                      ),
                      const Spacer(),
                      AnimatedRotation(
                        turns: controller.isRevenueDataExpanded.value ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: SvgPicture.asset(
                          controller.isRevenueDataExpanded.value
                              ? 'assets/images/minimize_icon.svg'
                              : 'assets/images/expand_icon.svg',
                          height: 24.h,
                          width: 24.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Expandable Content with smooth transition
              AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity),
                secondChild: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    children: [
                      _buildRevenueDataRow('Data 1', '2798.50 (29.53%)', '35689 ৳'),
                      SizedBox(height: 14.h),
                      _buildRevenueDataRow('Data 2', '2798.50 (29.53%)', '35689 ৳'),
                      SizedBox(height: 14.h),
                      _buildRevenueDataRow('Data 3', '2798.50 (29.53%)', '35689 ৳'),
                      SizedBox(height: 14.h),
                      _buildRevenueDataRow('Data 4', '2798.50 (29.53%)', '35689 ৳'),
                    ],
                  ),
                ),
                crossFadeState: controller.isRevenueDataExpanded.value
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildRevenueDataRow(String label, String dataValue, String costValue) {
    return Column(
      children: [
        Row(
          children: [
            Text(label, style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
            SizedBox(width: 8.w),
            Text(':', style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
            SizedBox(width: 8.w),
            Text(dataValue, style: h2.copyWith(fontSize: 12.sp, color: AppColors.textColor4)),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Text('Cost ${label.split(' ')[1]}', style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
            SizedBox(width: 8.w),
            Text(':', style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
            SizedBox(width: 8.w),
            Text(costValue, style: h2.copyWith(fontSize: 12.sp, color: AppColors.textColor4)),
          ],
        ),
      ],
    );
  }

  Widget _buildDateFilterChip({required String label, required bool isSelected}) {
    final color = isSelected ? AppColors.primary : AppColors.textColor2;
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Container(
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        ),
        SizedBox(width: 4.w),
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
      height: 36.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.borderColor2),
      ),
      child: Row(
        children: [
          Text(label, style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
          const Spacer(),
          Icon(Icons.calendar_today_outlined, size: 18.w, color: AppColors.textColor2),
        ],
      ),
    );
  }

  Widget _buildToggleButton({required String label, required bool isSelected}) {
    final color = isSelected ? AppColors.primary : AppColors.borderColor2;
    final textColor = isSelected ? AppColors.primary : AppColors.textColor2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 14.w,
          height: 14.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Container(decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          ),
        ),
        SizedBox(width: 8.w),
        Text(label, style: (isSelected ? h2 : h4).copyWith(fontSize: 16.sp, color: textColor)),
      ],
    );
  }

  Widget _buildEnergyChartCard({required String title, required String dataTotal}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.borderColor2, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(title, style: h2.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w700, color: AppColors.textColor4)),
              Text(dataTotal, style: h2.copyWith(fontSize: 32.sp, fontWeight: FontWeight.w700, color: const Color(0xFF0F1E32))),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDataCard('Data A', AppColors.primary, '2798.50 (29.53%)', '35689 ৳'),
          SizedBox(height: 6.h),
          _buildDataCard('Data B', AppColors.dataColor2, '72598.50 (35.39%)', '5259689 ৳'),
          SizedBox(height: 6.h),
          _buildDataCard('Data C', AppColors.dataColor3, '6598.36 (83.90%)', '5698756 ৳'),
          SizedBox(height: 6.h),
          _buildDataCard('Data D', AppColors.dataColor4, '6598.26 (36.59%)', '356987 ৳'),
        ],
      ),
    );
  }

  Widget _buildDataCard(String label, Color color, String dataValue, String costValue) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(width: 8.w, height: 8.w, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                  SizedBox(height: 8.h),
                  Text(label, style: h2.copyWith(fontSize: 12.sp, color: AppColors.textColor4)),
                ],
              ),
              SizedBox(width: 10.w),
              Container(width: 1, height: 40.h, color: AppColors.borderColor),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Data', style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
                    SizedBox(width: 12.w),
                    Text(':', style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
                    SizedBox(width: 4.w),
                    Text(dataValue, style: h2.copyWith(fontSize: 12.sp, color: AppColors.textColor4)),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text('Cost', style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
                    SizedBox(width: 12.w),
                    Text(':', style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
                    SizedBox(width: 4.w),
                    Text(costValue, style: h2.copyWith(fontSize: 12.sp, color: AppColors.textColor4)),
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