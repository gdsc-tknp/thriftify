import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/settings_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final user = this.user;
    // if (user != null) {
    //   final name = user.displayName;
    //   final email = user.email;
    //   final photoUrl = user.photoURL;
    //
    //   final emailVerified = user.emailVerified;
    //
    //   final uid = user.uid;
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        children: [
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
          const SizedBox(height: 30),
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.user),
                  title: Text('User'),
                  trailing: Text('user.uid'),
                ),
                Divider(
                  endIndent: 25,
                  indent: 25,
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.calendar),
                  title: Text('Date'),
                  trailing: Text('User_join_date'),
                ),
                Divider(
                  endIndent: 25,
                  indent: 25,
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.calendarXmark),
                  title: Text('Time'),
                  trailing: Text('User_join_time'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


