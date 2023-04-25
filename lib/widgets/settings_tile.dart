import 'package:flutter/cupertino.dart';
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
    return ListTile(
      leading: FaIcon(iconL),
      title: Text(title!),
      trailing: FaIcon(icon),
      onTap: onTap,
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
            .copyWith(fontWeight: FontWeight.w300),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool? value;
  final ValueChanged<bool>? onChanged;

  const SettingsButton({
    Key? key,
    @required this.title,
    @required this.subtitle,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title!),
      subtitle: Text(subtitle!),
      trailing: CupertinoSwitch(value: value!, onChanged: onChanged),
    );
  }
}
