import 'package:get/get.dart';
import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/scm/bindings/scm_binding.dart';
import '../modules/scm/views/scm_view.dart';

part 'app_routes.dart';
class AppPages {
  AppPages._();
  static const INITIAL = Routes.AUTHENTICATION;
  static final routes = <GetPage>[
    GetPage(
      name: _Paths.SCM,
      page: () => const ScmView(),
      binding: ScmBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
  ];
}
