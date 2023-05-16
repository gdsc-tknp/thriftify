import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:supro_vigilant/services/auth_service.dart';
import 'package:supro_vigilant/ui/home_page.dart';

import '../utils/loading_util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, bottom: 20.0, top: 50),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(),
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.asset('assets/images/logo.png', height: 160),
                  ),
                  Text(
                    'Thriftify',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.8),
                  ),
                  Text(
                    'Version 1.0',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            FutureBuilder(
                future: AuthService().initializeFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                        'Check your Internet Connection and Try again');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return const GoogleSignInButton();
                  }
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                  );
                }),
          ]),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? const LoadingUtil()
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });
                User? user = await AuthService().signInWithGoogle();
                setState(() {
                  _isSigningIn = false;
                });
                if (user != null) {
                  Get.snackbar(
                    'Congratulation ${user.displayName!}',
                    'Account creation was successful',
                    icon: const Icon(
                      FontAwesomeIcons.circleCheck,
                      color: Colors.tealAccent,
                    ),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  Get.offAll(() => const HomePage());
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      image: AssetImage("assets/images/google_logo.png"),
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
