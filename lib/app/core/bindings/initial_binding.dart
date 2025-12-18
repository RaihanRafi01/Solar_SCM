import 'package:get/get.dart';
import 'package:scube_task/app/modules/authentication/controllers/authentication_controller.dart';
import '../../modules/scm/controllers/scm_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationController());
    Get.put(ScmController());
  }
}
