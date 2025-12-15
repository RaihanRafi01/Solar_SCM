import 'package:get/get.dart';

import '../controllers/scm_controller.dart';

class ScmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScmController>(
      () => ScmController(),
    );
  }
}
