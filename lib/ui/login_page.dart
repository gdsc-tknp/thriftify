import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:supro_vigilant/services/auth_service.dart';
import 'package:supro_vigilant/ui/home_page.dart';

class LoginPge extends StatefulWidget {
  const LoginPge({Key? key}) : super(key: key);

  @override
  State<LoginPge> createState() => _LoginPgeState();
}

class _LoginPgeState extends State<LoginPge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 20.0, top: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(),
                Expanded(
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      Text(
                        'Supro Vigilante',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.8),
                      ),
                      Text(
                        'Version 0.0.1.beta',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                    future: AuthService.initializeFirebase(context: context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text(
                            'Check your Internet Connection and Try again');
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return const GoogleSignInButton();
                      }
                      return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                      );
                    }),
              ],
            ),
          ),
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
  Future<LottieComposition>? _composition;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();
  }

  Future<LottieComposition> _loadComposition() async {
    var data = await rootBundle.load('assets/lottie/infinite-google.json');
    return await LottieComposition.fromByteData(data);
  }

  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? FutureBuilder<LottieComposition>(
              future: _composition,
              builder: (context, snapshot) {
                var composition = snapshot.data;
                return Center(child: Lottie(composition: composition));
              },
            )
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
                User? user =
                    await AuthService.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });
                if (user != null) {
                  Get.off(() => const HomePage());
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
                      height: 35.0,
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
