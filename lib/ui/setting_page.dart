import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:supro_vigilant/ui/about_page.dart';
import 'package:supro_vigilant/ui/profile.dart';

import '../widgets/settings_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        children: [
          const SettingsTitle(title: 'Support'),
          const SettingsTile(
            title: 'FAQ',
            iconL: FontAwesomeIcons.circleQuestion,
            icon: FontAwesomeIcons.angleRight,
          ),
          const SettingsTile(
            title: 'User Guide',
            iconL: FontAwesomeIcons.circleInfo,
            icon: FontAwesomeIcons.angleRight,
          ),
          SettingsTile(
            title: 'About SV',
            iconL: FontAwesomeIcons.fileCircleCheck,
            icon: FontAwesomeIcons.angleRight,
            onTap: () => Get.to(() => const AboutPage()),
          ),
          const SettingsTile(
            title: 'Contact Us',
            iconL: FontAwesomeIcons.phone,
            icon: FontAwesomeIcons.angleRight,
          ),
          const SizedBox(height: 15),
          SettingsTile(
            title: 'Profile',
            iconL: FontAwesomeIcons.user,
            icon: FontAwesomeIcons.angleRight,
            onTap: () => Get.to(() => const ProfilePage()),
          ),
          const SizedBox(height: 15),
          const SettingsTile(
            title: 'Log Out',
            iconL: FontAwesomeIcons.arrowRightFromBracket,
          ),
          const SizedBox(height: 50),
          Column(
            children: [
              Image.asset('assets/images/logo.png', scale: 30),
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
}
