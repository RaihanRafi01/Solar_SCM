import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/scm_controller.dart';

class ScmView extends GetView<ScmController> {
  const ScmView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScmView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ScmView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
