import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_colors.dart';
import '../../../shared/widgets/auth/auth_widgets.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.primary,
      body: Column(children: [AuthHeader(), AuthLoginForm()]),
    );
  }
}
