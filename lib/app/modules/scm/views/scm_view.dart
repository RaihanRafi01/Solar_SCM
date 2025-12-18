import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_styles.dart';
import '../../../shared/widgets/scm/scm_widgets.dart';
import '../controllers/scm_controller.dart';
import 'action_screen_view.dart';
import 'data_detail_view.dart';

class ScmView extends GetView<ScmController> {
  const ScmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scmBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textColor4,
            size: 24.sp,
          ),
          onPressed: () =>
              controller.activeView.value != ScmContentView.initialSummary
              ? controller.navigateToSummary()
              : Get.back(),
        ),
        title: Text(
          'SCM',
          style: h3.copyWith(color: AppColors.textColor4, fontSize: 24.sp),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16).r,
            child: SvgPicture.asset(
              AppAssets.bellIcon,
              height: 20.h,
              width: 20.h,
            ),
          ),
        ],
      ),
      body: Obx(() {
        switch (controller.activeView.value) {
          case ScmContentView.initialSummary:
            return const ScmSummaryContent();
          case ScmContentView.actionScreen:
            return const ActionScreenView();
          case ScmContentView.dataDetail:
            return const DataDetailView();
        }
      }),
    );
  }
}
