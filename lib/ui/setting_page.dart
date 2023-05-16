import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:supro_vigilant/services/auth_service.dart';
import 'package:supro_vigilant/ui/about_page.dart';
import 'package:supro_vigilant/ui/profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/theme.dart';
import '../theme/theme_controller.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    // final logic = context.watch<AuthService>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
        children: [
          const SettingsTitle(title: 'APPEARANCE'),
          Container(
            decoration: BoxDecoration(
              color:
                  Get.theme.brightness == Brightness.dark ? d0 : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        ThemeController.to.updateTheme(ThemeMode.dark);
                      });
                    },
                    child: const Text('Dark'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        ThemeController.to.updateTheme(ThemeMode.light);
                      });
                    },
                    child: const Text('Light'),
                  ),
                ),
              ],
            ),
          ),
          const SettingsTitle(title: 'SUPPORT'),
          Container(
            decoration: BoxDecoration(
              color:
                  Get.theme.brightness == Brightness.dark ? d0 : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SettingsTile(
                  title: 'User Guide',
                  iconL: FontAwesomeIcons.circleInfo,
                  icon: FontAwesomeIcons.angleRight,
                  onTap: () =>
                      // todo: find in app youtube player
                      launchUrl(Uri.parse('https://youtube.com/gdcstknp/thriftify')),
                ),
                const Divider(),
                SettingsTile(
                  title: 'FAQ',
                  iconL: FontAwesomeIcons.circleQuestion,
                  icon: FontAwesomeIcons.angleRight,
                  onTap: () =>
                      launchUrl(Uri.parse('https://github.com/gdcstknp')),
                ),
                const Divider(),
                SettingsTile(
                  title: 'About Thriftify',
                  iconL: FontAwesomeIcons.fileCircleCheck,
                  icon: FontAwesomeIcons.angleRight,
                  onTap: () => Get.to(() => const AboutPage()),
                ),
                const Divider(),
                SettingsTile(
                  title: 'Contact Us',
                  iconL: FontAwesomeIcons.phone,
                  icon: FontAwesomeIcons.angleRight,
                  onTap: () => launchUrl(Uri.parse('https://twitter.com/gdcstknp')),
                ),
                const Divider(),
                SettingsTile(
                  title: 'Profile',
                  iconL: FontAwesomeIcons.user,
                  icon: FontAwesomeIcons.angleRight,
                  onTap: () => Get.to(() => const ProfilePage()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color:
                  Get.theme.brightness == Brightness.dark ? d0 : Colors.white,
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
                'Thriftify',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 18,color: r6.withOpacity(.8),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.8),
              ),
              Text(
                'Version 1.0',
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
    super.initState();
  }
}
