import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_colors.dart';
import '../../../shared/widgets/scm/action_screen_widgets.dart';
import '../controllers/scm_controller.dart';

class ActionScreenView extends GetView<ScmController> {
  const ActionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scmBackground,
      child: const Center(child: NoDataPlaceholder()),
    );
  }
}
