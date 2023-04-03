import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:supro_vigilant/theme/theme.dart';
import 'package:supro_vigilant/ui/login_page.dart';
import 'firebase_options.dart';

void main() async {
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
      debugShowCheckedModeBanner: false,
      home: const LoginPge(),
    );
  }
}
