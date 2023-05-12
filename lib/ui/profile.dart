import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../theme/theme.dart';
import '../utils/loading_util.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final logic = context.watch<AuthService>();
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        children: [
          if (logic.user!.photoURL != null)
            ClipOval(
              child: Material(
                child: Image.network(
                  logic.user!.photoURL!,
                  fit: BoxFit.fitHeight,
                  loadingBuilder: (context, child, load) {
                    if (load == null) return child;
                    return const LoadingUtil();
                  },
                ),
              ),
            )
          else
            Image.asset('assets/images/logo.png', height: 160),
          Center(
            child: Text(
              'Supro Vigilant',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.8),
            ),
          ),
          Center(
            child: Text(
              'Version 0.0.1.beta',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontSize: 15, fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color:
                  Get.theme.brightness == Brightness.dark ? d0 : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.user),
                  title: const Text('Name'),
                  trailing: Text(logic.user!.displayName!),
                ),
                const Divider(endIndent: 18, indent: 18),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.userCheck),
                  title: const Text('Email'),
                  trailing: Text(logic.user!.email!),
                ),
                const Divider(endIndent: 18, indent: 18),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.calendar),
                  title: const Text('Date'),
                  trailing: Text(
                      logic.user!.metadata.creationTime!.toUtc().toString()),
                ),
                const Divider(endIndent: 18, indent: 18),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.calendarXmark),
                  title: const Text('Time'),
                  trailing: Text(logic
                      .user!.metadata.creationTime!.microsecondsSinceEpoch
                      .toString()),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
