// views/authentication_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scube_task/app/modules/scm/views/scm_view.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primary,
        child: Column(
          children: [
            // Top Section - Logo
            Expanded(
              flex: 45,
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.appIcon,
                      scale: 4,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'SCUBE',
                      style: h2.copyWith(color: Colors.white, fontSize: 24.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Control & Monitoring System',
                      style: h2.copyWith(color: Colors.white, fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom White Card
            Expanded(
              flex: 55,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                ),
                padding: EdgeInsets.fromLTRB(32.w, 24.h, 32.w, 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: h1.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Username Field
                    CustomTextField(hint: 'Username'),

                    SizedBox(height: 16.h),

                    // Password Field with SVG toggle
                    Obx(() => CustomTextField(
                      hint: 'Password',
                      obscureText: !controller.isPasswordVisible.value,
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          controller.isPasswordVisible.value
                              ? AppAssets.visibilityIcon
                              : AppAssets.visibilityOffIcon,
                          width: 22.w,
                          height: 22.h,
                          colorFilter: ColorFilter.mode(
                            Colors.grey[600]!,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    )),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget password?',
                          style: h3.copyWith(
                            color: AppColors.textHint,
                            fontSize: 12.sp,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Login Button
                    CustomButton(
                      text: 'Login',
                      onPressed: () {
                        Get.offAll(ScmView());
                      },
                    ),

                    SizedBox(height: 8.h),

                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have any account? ",
                          style: h3.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 12.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            'Register Now',
                            style: h3.copyWith(
                              color: AppColors.primary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}