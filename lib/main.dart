import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task/app/core/bindings/initial_binding.dart';
import 'package:scube_task/app/core/themes/app_theme.dart';
import 'package:scube_task/app/routes/app_pages.dart';

void main() {
  runApp(const MainApp());
}

/// Main Application Widget
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'scube_task',

      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Navigation configuration
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,

      // Global bindings
      initialBinding: InitialBinding(),

      // App configuration
      debugShowCheckedModeBanner: false,
      enableLog: true,

      // Localization (uncomment if needed)
      // locale: const Locale('en', 'US'),
      // translations: AppTranslations(),

      // Global middlewares
      routingCallback: (routing) {
        // Add global route logging or analytics here
        debugPrint('[Navigation] ${routing?.current}');
      },
    );
  }
}
