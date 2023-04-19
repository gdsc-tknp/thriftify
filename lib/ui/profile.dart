import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/loading_util.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        children: [
          Column(
            children: [
              if (_user.photoURL != null)
                ClipOval(
                  child: Material(
                    child: Image.network(
                      _user.photoURL!,
                      fit: BoxFit.fitHeight,
                      loadingBuilder: (context, child, load) {
                        if (load == null) return child;
                        return const LoadingUtil();
                      },
                    ),
                  ),
                )
              else
                Flexible(
                  flex: 1,
                  child: Image.asset('assets/images/logo.png', height: 160),
                ),
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
              children: [
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.user),
                  title: const Text('User'),
                  trailing: Text(_user.displayName!),
                ),
                const Divider(
                  endIndent: 25,
                  indent: 25,
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.user),
                  title: const Text('Email'),
                  trailing: Text(_user.email!),
                ),
                const Divider(
                  endIndent: 25,
                  indent: 25,
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.calendar),
                  title: const Text('Date'),
                  trailing:
                      Text(_user.metadata.creationTime!.toUtc().toString()),
                ),
                const Divider(
                  endIndent: 25,
                  indent: 25,
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.calendarXmark),
                  title: const Text('Time'),
                  trailing:
                      Text(_user.metadata.creationTime!.toString().trim()),
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
    _user = widget._user;
    super.initState();
  }
}
