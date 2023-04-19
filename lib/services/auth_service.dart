import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supro_vigilant/ui/home_page.dart';

import '../firebase_options.dart';
import '../ui/login_page.dart';

class AuthService extends ChangeNotifier {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.offAll(() => HomePage(user: user));
    }
    return firebaseApp;
  }

  static Future signUpWithEmailPassword(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
              (value) => {Get.offAll(() => HomePage(user: auth.currentUser!))});
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  static Future signInWithEmailPassword(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
              (value) => {Get.offAll(() => HomePage(user: auth.currentUser!))});
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  static Future<User?> signInWithGoogle() async {
    User? user;
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser != null) {
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Get.snackbar('Error',
              'The account already exists with a different credential.');
        } else if (e.code == 'invalid-credential') {
          Get.snackbar('Error',
              'Error occurred while accessing credentials. Try again.');
        }
      } catch (e) {
        Get.snackbar(
            'Error', 'Error occurred using Google Sign-In. Try again.');
      }
    }
    return user;
  }

  static Future phoneVerify({required BuildContext context}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    MultiFactorSession session =
        await FirebaseAuth.instance.currentUser!.multiFactor.getSession();
    await auth.verifyPhoneNumber(
      multiFactorSession: session,
      verificationCompleted: (_) {},
      verificationFailed: (_) {},
      codeSent: (String verificationId, int? resendToken) async {
        final smsCode = await AuthService.getSmsCodeFromUser(context);
        if (smsCode != null) {
          final credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          try {
            final user = auth.currentUser;
            await user!.multiFactor.enroll(
              PhoneMultiFactorGenerator.getAssertion(credential),
            );
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  static Future<String?> getSmsCodeFromUser(BuildContext context) async {
    String? smsCode;
    await showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('SMS code:'),
            actions: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('Sign in'),
              ),
              OutlinedButton(
                onPressed: () {
                  smsCode = null;
                  Get.back();
                },
                child: const Text('Cancel'),
              )
            ],
            content: Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (value) {
                  smsCode = value;
                },
                textAlign: TextAlign.center,
                autofocus: true,
              ),
            ),
          );
        });
    return smsCode;
  }

  static Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance
          .signOut()
          .then((value) => {Get.offAll(() => const LoginPge())});
    } catch (e) {
      Get.snackbar('Error', 'Error signing out. Try again.');
    }
  }
}
