import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supro_vigilant/theme/theme.dart';
import 'package:supro_vigilant/theme/theme_controller.dart';
import 'package:supro_vigilant/ui/login_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<ThemeController>(() => ThemeController());
  ThemeController.to.getThemeModeFromPreferences();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SuproApp());
}

class SuproApp extends StatelessWidget {
  const SuproApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Supro Vigilante',
      theme: theme,
      darkTheme: themed,
      themeMode: ThemeController.to.themeMode,
      debugShowCheckedModeBanner: false,
      home: const LoginPge(),
    );
  }
}
