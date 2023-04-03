import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({Key? key, this.title, this.icon, this.iconL, this.onTap})
      : super(key: key);
  final String? title;
  final IconData? iconL;
  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FaIcon(iconL),
        title: Text(title!),
        trailing: FaIcon(icon),
        onTap: onTap,
      ),
    );
  }
}

class SettingsTitle extends StatelessWidget {
  final String title;

  const SettingsTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(fontSize: 18, fontWeight: FontWeight.w300),
      ),
    );
  }
}
