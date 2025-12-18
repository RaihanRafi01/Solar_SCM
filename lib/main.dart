import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scube_task/app/core/bindings/initial_binding.dart';
import 'package:scube_task/app/core/themes/app_theme.dart';
import 'package:scube_task/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'scube_task',

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,

          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,

          initialBinding: InitialBinding(),

          debugShowCheckedModeBanner: false,
          enableLog: true,

          routingCallback: (routing) {
            debugPrint('[Navigation] ${routing?.current}');
          },
        );
      },
    );
  }
}
