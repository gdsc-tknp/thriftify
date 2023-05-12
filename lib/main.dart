import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:supro_vigilant/services/auth_service.dart';
import 'package:supro_vigilant/theme/theme.dart';
import 'package:supro_vigilant/theme/theme_controller.dart';
import 'package:supro_vigilant/ui/home_page.dart';
import 'package:supro_vigilant/ui/login_page.dart';
import 'package:supro_vigilant/ui/onboarding_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<ThemeController>(() => ThemeController());
  ThemeController.to.getThemeModeFromPreferences();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AuthService())],
      child: const SuproApp(),
    ),
  );
}

class SuproApp extends StatefulWidget {
  const SuproApp({super.key});

  @override
  State<SuproApp> createState() => _SuproAppState();
}

class _SuproAppState extends State<SuproApp> {
  @override
  void initState() {
    // AuthService().initializeFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final logic = context.watch<AuthService>();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // if (logic.isFirstUser != true && logic.isSignIn != true) {}
    return GetMaterialApp(
      title: 'Supro Vigilante',
      theme: theme,
      darkTheme: themed,
      themeMode: ThemeController.to.themeMode,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
