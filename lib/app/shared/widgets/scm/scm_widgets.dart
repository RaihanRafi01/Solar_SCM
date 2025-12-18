import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../../../modules/scm/controllers/scm_controller.dart';

class ScmSummaryContent extends GetView<ScmController> {
  const ScmSummaryContent({super.key});

  @override
  Widget build(BuildContext context) {
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
                _buildTopTabs(),
                const Divider(height: 0, color: AppColors.borderColor),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      Text('Electricity', style: h2.copyWith(color: AppColors.textColor3, fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      SizedBox(height: 6.h),
                      Divider(height: 1.h, color: AppColors.textColor3),
                      SizedBox(height: 30.h),
                      const PowerCircleIndicator(),
                      SizedBox(height: 24.h),
                      _buildSourceLoadToggle(),
                      SizedBox(height: 6.h),
                      Divider(height: 2.h, color: AppColors.textColor3, thickness: 2),
                      SizedBox(height: 12.h),
                      const ScmDataListView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const ScmActionGrid(),
        ],
      ),
    );
  }

  Widget _buildTopTabs() {
    return Obx(() => SizedBox(
      height: 38.h,
      child: Row(
        children: [
          _TabItem(label: 'Summary', isActive: controller.selectedTab.value == 'Summary', onTap: () => controller.selectTab('Summary')),
          _TabItem(label: 'SLD', isActive: controller.selectedTab.value == 'SLD', onTap: () => controller.selectTab('SLD')),
          _TabItem(label: 'Data', isActive: controller.selectedTab.value == 'Data', onTap: () => controller.selectTab('Data')),
        ],
      ),
    ));
  }

  Widget _buildSourceLoadToggle() {
    return Obx(() => Container(
      height: 32.h,
      decoration: BoxDecoration(color: const Color(0xFFE8EDF2), borderRadius: BorderRadius.circular(25.r)),
      child: Row(
        children: [
          _ToggleBtn(label: 'Source', isActive: controller.selectedSourceLoad.value == 'Source', onTap: () => controller.selectSourceLoad('Source')),
          _ToggleBtn(label: 'Load', isActive: controller.selectedSourceLoad.value == 'Load', onTap: () => controller.selectSourceLoad('Load')),
        ],
      ),
    ));
  }
}

class PowerCircleIndicator extends StatelessWidget {
  const PowerCircleIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Center(
        child: SizedBox(
          width: 150.w, height: 150.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200.w, height: 200.h,
                child: CircularProgressIndicator(value: 1, strokeWidth: 28.w, backgroundColor: const Color(0xFFE8EDF2), valueColor: AlwaysStoppedAnimation(AppColors.appColor2)),
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
      ),
    );
  }
}

class ScmDataListView extends GetView<ScmController> {
  const ScmDataListView({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (n is ScrollUpdateNotification) controller.scrollOffset.value = n.metrics.pixels;
          if (n is ScrollMetricsNotification || n is OverscrollNotification) {
            if (n.metrics.maxScrollExtent > 0) {
              controller.maxScrollExtent.value = n.metrics.maxScrollExtent;
              controller.viewportSize.value = n.metrics.viewportDimension;
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
                        _DataCard('Data View', AppAssets.solarCellIcon, true, '55505.63', '58805.63', AppColors.appColor3),
                        SizedBox(height: 12.h),
                        _DataCard('Data Type 2', AppAssets.powerIcon, true, '55505.63', '58805.63', AppColors.orange),
                        SizedBox(height: 12.h),
                        _DataCard('Data Type 3', AppAssets.powerGridIcon, false, '55505.63', '58805.63', AppColors.appColor3),
                        SizedBox(height: 12.h),
                        _DataCard('Data View', AppAssets.solarCellIcon, true, '55505.63', '58805.63', AppColors.appColor3),
                      ],
                    ),
                    const _BottomGradient(),
                  ],
                ),
              ),
            ),
            const _CustomScrollbar(),
          ],
        ),
      ),
    );
  }
}

class ScmActionGrid extends StatelessWidget {
  const ScmActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Column(
        children: [
          // Row 1
          _row(
            _ActionBtn(AppAssets.analysisIcon, 'Analysis Pro'),
            _ActionBtn(AppAssets.generatorIcon, 'G. Generator'),
          ),
          SizedBox(height: 12.h),
          // Row 2
          _row(
            _ActionBtn(AppAssets.chargeIcon, 'Plant Summary'),
            _ActionBtn(AppAssets.fireIcon, 'Natural Gas'),
          ),
          SizedBox(height: 12.h),
          // Row 3
          _row(
            _ActionBtn(AppAssets.generatorIcon, 'D. Generator'),
            _ActionBtn(AppAssets.faucetIcon, 'Water Process'),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _row(Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: left),
        SizedBox(width: 12.w),
        Expanded(child: right),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label; final bool isActive; final VoidCallback onTap;
  const _TabItem({required this.label, required this.isActive, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(color: isActive ? AppColors.primary : Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(10.r))),
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(color: isActive ? Colors.white : AppColors.textColor2, fontSize: 16.sp, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final String label; final bool isActive; final VoidCallback onTap;
  const _ToggleBtn({required this.label, required this.isActive, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(color: isActive ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(25.r)),
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(color: isActive ? Colors.white : AppColors.textHint, fontSize: 16.sp, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class _DataCard extends StatelessWidget {
  final String title, icon, d1, d2; final bool active; final Color color;
  const _DataCard(this.title, this.icon, this.active, this.d1, this.d2, this.color);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.find<ScmController>().navigateToDataDetail(),
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(color: AppColors.cardColor1, borderRadius: BorderRadius.circular(4.r), border: Border.all(color: AppColors.borderColor2)),
        child: Row(
          children: [
            Image.asset(icon, height: 24.h, width: 24.h),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(width: 12.w, height: 12.h, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2.r))),
                      SizedBox(width: 8.w),
                      Text(title, style: h3.copyWith(color: AppColors.textColor4, fontSize: 14.sp)),
                      SizedBox(width: 8.w),
                      Text(active ? '(Active)' : '(Inactive)', style: h3.copyWith(color: active ? AppColors.primary : AppColors.red, fontSize: 10.sp)),
                    ],
                  ),
                  Text.rich(TextSpan(children: [TextSpan(text: 'Data 1    : ', style: h4.copyWith(fontSize: 12, color: AppColors.textColor2)), TextSpan(text: d1, style: h4.copyWith(fontSize: 12))])),
                  Text.rich(TextSpan(children: [TextSpan(text: 'Data 2    : ', style: h4.copyWith(fontSize: 12, color: AppColors.textColor2)), TextSpan(text: d2, style: h4.copyWith(fontSize: 12))])),
                ],
              ),
            ),
            SvgPicture.asset(AppAssets.rightIcon)
          ],
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String icon, title;
  const _ActionBtn(this.icon, this.title);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.find<ScmController>().navigateToActionScreen(),
      child: Container(
        height: 42.h,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: AppColors.borderColor)),
        padding: EdgeInsets.all(10.r),
        child: Row(
          children: [
            Image.asset(icon, height: 24.h, width: 24.h),
            SizedBox(width: 8.w),
            Flexible(child: Text(title, style: h2.copyWith(color: AppColors.textColor2, fontSize: 14.sp), maxLines: 1, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}

class _BottomGradient extends StatelessWidget {
  const _BottomGradient();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0, right: 0, bottom: 0,
      child: IgnorePointer(
        child: Container(
          height: 30.h,
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [AppColors.startColor, AppColors.endColor.withOpacity(0)])),
        ),
      ),
    );
  }
}

class _CustomScrollbar extends GetView<ScmController> {
  const _CustomScrollbar();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Obx(() {
        final double trackHeight = 250.h;
        const double thumbHeight = 33.0;
        final double scrollPercent = controller.maxScrollExtent.value > 0 ? (controller.scrollOffset.value / controller.maxScrollExtent.value).clamp(0.0, 1.0) : 0.0;
        return Container(
          width: 4.w, height: trackHeight, margin: EdgeInsets.only(right: 4.w),
          decoration: BoxDecoration(color: AppColors.borderColor.withOpacity(0.3), borderRadius: BorderRadius.circular(4.r)),
          child: Stack(
            children: [
              Positioned(
                top: (trackHeight - thumbHeight.h) * scrollPercent, left: 0, right: 0,
                child: Container(height: thumbHeight.h, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), gradient: const LinearGradient(colors: [AppColors.indicatorColor1, AppColors.indicatorColor2]))),
              ),
            ],
          ),
        );
      }),
    );
  }
}