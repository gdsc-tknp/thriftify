import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

import '../theme/theme.dart';

class RoundCustomBtn extends StatelessWidget {
  final List<Widget>? children;
  final IconData? icon;

  const RoundCustomBtn({Key? key, this.icon, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showPopover(
            width: 180,
            height: 260,
            context: context,
            backgroundColor:
                Get.theme.brightness == Brightness.dark ? d0 : Colors.white,
            bodyBuilder: (context) => ListItems(children: children));
      },
      splashRadius: 1,
      icon: const FaIcon(FontAwesomeIcons.ellipsis),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key, this.children}) : super(key: key);
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: children!,
      ),
    );
  }
}

class MItems extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final String? text;

  const MItems({Key? key, this.text, this.onTap, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        constraints: BoxConstraints(minHeight: height / 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [FaIcon(icon), const SizedBox(width: 7), Text(text!)],
        ),
      ),
    );
  }
}
