import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scube_task/app/core/constants/app_assets.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../controllers/scm_controller.dart';

class ActionScreenView extends GetView<ScmController> {
  const ActionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scmBackground,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(24).r,
          height: double.maxFinite,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.borderColor,
              width: 1.w,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppAssets.noDataImage, scale: 4),
              SizedBox(height: 16.h),
              Text(
                'No data is here,\nplease wait.',
                textAlign: TextAlign.center,
                style: h4.copyWith(
                  color: AppColors.textHint,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}