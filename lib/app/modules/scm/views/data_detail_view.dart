import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../../../shared/widgets/scm/data_detail_widgets.dart';
import '../controllers/scm_controller.dart';

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
                          ? const DataViewProgressArc()
                          : const RevenueViewContent(),
                      if (controller.isDataViewSelected.value)
                        _buildDataViewFilters(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildTopToggle(),
        ],
      ),
    );
  }

  Widget _buildDataViewFilters() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _filterChip(
                'Today Data',
                controller.isTodaySelected.value,
                () => controller.isTodaySelected.value = true,
              ),
              SizedBox(width: 12.w),
              _filterChip(
                'Custom Date Data',
                !controller.isTodaySelected.value,
                () => controller.isTodaySelected.value = false,
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: !controller.isTodaySelected.value
              ? _buildDatePickers()
              : const SizedBox.shrink(),
        ),
        SizedBox(height: 16.h),
        EnergyChartCard(
          title: 'Energy Chart',
          dataTotal: controller.isTodaySelected.value
              ? '20.05 kw'
              : '125.40 kw',
        ),
        if (!controller.isTodaySelected.value) ...[
          SizedBox(height: 16.h),
          const EnergyChartCard(title: 'Secondary Chart', dataTotal: '5.53 kw'),
        ],
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildTopToggle() {
    return Positioned(
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
            border: Border.all(color: AppColors.borderColor2),
          ),
          child: Obx(
            () => Row(
              children: [
                Expanded(
                  child: _toggleBtn(
                    'Data View',
                    controller.isDataViewSelected.value,
                    () => controller.isDataViewSelected.value = true,
                  ),
                ),
                Expanded(
                  child: _toggleBtn(
                    'Revenue View',
                    !controller.isDataViewSelected.value,
                    () => controller.isDataViewSelected.value = false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterChip(String label, bool isSelected, VoidCallback onTap) {
    final color = isSelected ? AppColors.primary : AppColors.textColor2;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color),
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
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleBtn(String label, bool selected, VoidCallback onTap) {
    final color = selected ? AppColors.primary : AppColors.borderColor2;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 14.w,
            height: 14.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color),
            ),
            child: Padding(
              padding: EdgeInsets.all(2.w),
              child: Container(
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: (selected ? h2 : h4).copyWith(
              fontSize: 16.sp,
              color: selected ? AppColors.primary : AppColors.textColor2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickers() {
    return Column(
      children: [
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Row(
            children: [
              Expanded(child: _dateContainer('From Date')),
              SizedBox(width: 5.w),
              Expanded(child: _dateContainer('To Date')),
              SizedBox(width: 5.w),
              Container(
                height: 36.h,
                width: 34.h,
                padding: const EdgeInsets.all(8).r,
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: AppColors.primary),
                ),
                child: SvgPicture.asset(AppAssets.searchIcon),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dateContainer(String label) => Container(
    height: 36.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.r),
      border: Border.all(color: AppColors.borderColor2),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: h4.copyWith(fontSize: 12.sp, color: AppColors.textColor2),
        ),
        const Spacer(),
        Icon(
          Icons.calendar_today_outlined,
          size: 18.w,
          color: AppColors.textColor2,
        ),
      ],
    ),
  );
}
