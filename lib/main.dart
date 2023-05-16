import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:supro_vigilant/services/auth_service.dart';
import 'package:supro_vigilant/theme/theme.dart';
import 'package:supro_vigilant/theme/theme_controller.dart';

import 'package:supro_vigilant/ui/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<ThemeController>(() => ThemeController());
  ThemeController.to.getThemeModeFromPreferences();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AuthService())],
      child: const ThriftApp(),
    ),
  );
}

class ThriftApp extends StatefulWidget {
  const ThriftApp({super.key});

  @override
  State<ThriftApp> createState() => _ThriftAppState();
}

class _ThriftAppState extends State<ThriftApp> {
  @override
  void initState() {
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
      title: 'Thriftify',
      theme: theme,
      darkTheme: themed,
      themeMode: ThemeController.to.themeMode,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
