import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:supro_vigilant/services/auth_service.dart';
import 'package:supro_vigilant/ui/about_page.dart';
import 'package:supro_vigilant/ui/profile.dart';

import '../theme/theme_controller.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late User _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8.0,
        ),
        children: [
          const SettingsTitle(title: 'APPEARANCE'),
          Container(
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SettingsButton(
              title: 'Dark Mode',
              subtitle: 'Switch to join the dark side',
              value: false,
              onChanged: (bool value) {
                ThemeController.to.updateTheme(ThemeMode.dark);
              },
            ),
          ),
          const SettingsTitle(title: 'SUPPORT'),
          Container(
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SettingsTile(
                  title: 'FAQ',
                  iconL: FontAwesomeIcons.circleQuestion,
                  icon: FontAwesomeIcons.angleRight,
                ),
                const Divider(color: Colors.black12),
                const SettingsTile(
                  title: 'User Guide',
                  iconL: FontAwesomeIcons.circleInfo,
                  icon: FontAwesomeIcons.angleRight,
                ),
                const Divider(color: Colors.black12),
                SettingsTile(
                  title: 'About SV',
                  iconL: FontAwesomeIcons.fileCircleCheck,
                  icon: FontAwesomeIcons.angleRight,
                  onTap: () => Get.to(() => const AboutPage()),
                ),
                const Divider(color: Colors.black12),
                const SettingsTile(
                  title: 'Contact Us',
                  iconL: FontAwesomeIcons.phone,
                  icon: FontAwesomeIcons.angleRight,
                ),
                const Divider(color: Colors.black12),
                SettingsTile(
                  title: 'Profile',
                  iconL: FontAwesomeIcons.user,
                  icon: FontAwesomeIcons.angleRight,
                  onTap: () => Get.to(() => ProfilePage(user: _user)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SettingsTile(
              title: 'Log Out',
              iconL: FontAwesomeIcons.arrowRightFromBracket,
              onTap: () => AuthService.signOut(),
            ),
          ),
          const SizedBox(height: 50),
          Column(
            children: [
              Image.asset('assets/images/logo0.png', scale: 30),
              Text(
                'Supro Vigilante',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.8),
              ),
              Text(
                'Version 0.0.1.beta',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }
}
