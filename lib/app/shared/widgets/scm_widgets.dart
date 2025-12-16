// shared/widgets/scm_widgets.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_text_styles.dart';
import '../../modules/scm/controllers/scm_controller.dart';

mixin ScmWidgets {
  Widget buildTab(String title, bool isActive) {
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

  Widget buildSourceLoadButton(String title, bool isActive) {
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

  Widget buildDataCard(
      String title,
      String icon,
      bool isActive,
      String data1,
      String data2,
      Color indicatorColor,
      ) {
    return InkWell(
      onTap: () {
        Get.find<ScmController>().navigateToDataDetail();
      },
      child: Container(
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
                        TextSpan(text: data1, style: h4.copyWith(fontSize: 12)),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Data 2    : ', style: h4.copyWith(fontSize: 12,color: AppColors.textColor2)),
                        TextSpan(text: data2, style: h4.copyWith(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset('assets/images/right_icon.svg')
          ],
        ),
      ),
    );
  }

  Widget buildActionButton(String icon, String title) {
    return InkWell(
      onTap: () {
        Get.find<ScmController>().navigateToActionScreen();
      },
      child: Container(
        height: 42.h,
        width: 148.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(icon,height: 24.h,width: 24.h,),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  title,
                  style: h2.copyWith(
                    color: AppColors.textColor2,
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}