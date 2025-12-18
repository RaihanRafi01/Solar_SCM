import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../../../core/constants/app_assets.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../../../modules/scm/controllers/scm_controller.dart';

class CustomArcPainter extends CustomPainter {
  final Color foregroundColor, backgroundColor;
  final double strokeWidth, progress;

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
    final backgroundPaint = Paint()..color = backgroundColor..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;
    final foregroundPaint = Paint()..color = foregroundColor..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;

    const double startAngle = 5 * pi / 6;
    const double sweepAngle = 4 * pi / 3;

    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);
    canvas.drawArc(rect, startAngle, sweepAngle * progress, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(CustomArcPainter oldDelegate) => oldDelegate.progress != progress;
}

class DataViewProgressArc extends GetView<ScmController> {
  const DataViewProgressArc({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      double progress = controller.isTodaySelected.value ? 0.57 : 0.77;
      String value = controller.isTodaySelected.value ? '57.00' : '77.30';
      return SizedBox(
        width: 160.w, height: 160.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progress),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, val, _) => CustomPaint(
                size: Size(160.w, 160.w),
                painter: CustomArcPainter(
                  foregroundColor: AppColors.primary,
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  strokeWidth: 16.w,
                  progress: val,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: h3.copyWith(fontSize: 20.sp, color: AppColors.textColor4)),
                Text('kWh/Sqft', style: h3.copyWith(fontSize: 14.sp, color: AppColors.textColor4)),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class RevenueViewContent extends GetView<ScmController> {
  const RevenueViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        SizedBox(
          width: 160.w, height: 160.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(160.w, 160.w),
                painter: CustomArcPainter(foregroundColor: AppColors.primary, backgroundColor: AppColors.primary.withOpacity(0.15), strokeWidth: 16.w, progress: 0.9),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('8897455', style: h3.copyWith(fontSize: 20.sp, color: AppColors.textColor4)),
                  Text('tk', style: h3.copyWith(fontSize: 14.sp, color: AppColors.textColor4)),
                ],
              ),
            ],
          ),
        ),
        _buildExpandableCard(),
      ],
    ));
  }

  Widget _buildExpandableCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r), border: Border.all(color: AppColors.borderColor2)),
      child: Column(
        children: [
          InkWell(
            onTap: () => controller.isRevenueDataExpanded.value = !controller.isRevenueDataExpanded.value,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: AppColors.borderColor2)),
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.solarChart, height: 15.h, width: 16.13.w),
                  SizedBox(width: 8.w),
                  Text('Data & Cost Info', style: h2.copyWith(fontSize: 12.sp, color: AppColors.textColor4)),
                  const Spacer(),
                  AnimatedRotation(
                    turns: controller.isRevenueDataExpanded.value ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: SvgPicture.asset(controller.isRevenueDataExpanded.value ? AppAssets.minimizeIcon : AppAssets.expandIcon, height: 24.h),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  _row('Data 1', '2798.50 (29.53%)', '35689 ৳'),
                  SizedBox(height: 14.h),
                  _row('Data 2', '2798.50 (29.53%)', '35689 ৳'),
                  SizedBox(height: 14.h),
                  _row('Data 3', '2798.50 (29.53%)', '35689 ৳'),
                  SizedBox(height: 14.h),
                  _row('Data 4', '2798.50 (29.53%)', '35689 ৳'),
                ],
              ),
            ),
            crossFadeState: controller.isRevenueDataExpanded.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String val, String cost) {
    return Column(
      children: [
        Row(children: [
          Text(label, style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
          SizedBox(width: 8.w), Text(':', style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
          SizedBox(width: 8.w), Text(val, style: h2.copyWith(fontSize: 12.sp, color: AppColors.textColor4)),
        ]),
        SizedBox(height: 4.h),
        Row(children: [
          Text('Cost ${label.split(' ')[1]}', style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
          SizedBox(width: 8.w), Text(':', style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
          SizedBox(width: 8.w), Text(cost, style: h2.copyWith(fontSize: 12.sp, color: AppColors.textColor4)),
        ]),
      ],
    );
  }
}

class EnergyChartCard extends StatelessWidget {
  final String title, dataTotal;
  const EnergyChartCard({super.key, required this.title, required this.dataTotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: AppColors.borderColor2)),
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
          _item('Data A', AppColors.primary, '2798.50 (29.53%)', '35689 ৳'),
          SizedBox(height: 6.h),
          _item('Data B', AppColors.dataColor2, '72598.50 (35.39%)', '5259689 ৳'),
          SizedBox(height: 6.h),
          _item('Data C', AppColors.dataColor3, '6598.36 (83.90%)', '5698756 ৳'),
          SizedBox(height: 6.h),
          _item('Data D', AppColors.dataColor4, '6598.26 (36.59%)', '356987 ৳'),
        ],
      ),
    );
  }

  Widget _item(String label, Color color, String val, String cost) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), border: Border.all(color: AppColors.borderColor)),
      child: Row(
        children: [
          Column(children: [
            Container(width: 8.w, height: 8.w, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            SizedBox(height: 8.h),
            Text(label, style: h2.copyWith(fontSize: 12.sp, color: AppColors.textColor4)),
          ]),
          SizedBox(width: 10.w),
          Container(width: 1, height: 40.h, color: AppColors.borderColor),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dataLine('Data', val),
                SizedBox(height: 4.h),
                _dataLine('Cost', cost),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataLine(String label, String val) => Row(children: [
    Text(label, style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
    SizedBox(width: 12.w), Text(':', style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2)),
    SizedBox(width: 4.w), Text(val, style: h2.copyWith(fontSize: 12.sp, color: AppColors.textColor4)),
  ]);
}