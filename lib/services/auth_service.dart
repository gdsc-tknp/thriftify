import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supro_vigilant/ui/home_page.dart';

import '../firebase_options.dart';
import '../ui/login_page.dart';

class AuthService extends ChangeNotifier {
  late bool _isSignIn = false;
  late bool _isFirstUser = false;
  late User? _user = FirebaseAuth.instance.currentUser;

  AuthService() {
    startLogic();
  }

  User? get user => _user;

  bool get isSignIn => _isSignIn;

  bool get isFirstUser => _isFirstUser;

  void startLogic() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignIn = sp.getBool('isSignIn') ?? false;
    _isFirstUser = sp.getBool('is_first_user') ?? false;
    notifyListeners();
  }

  Future<FirebaseApp> initializeFirebase() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (_user != null) {
      sp.setBool('is_first_user', true);
      Get.offAll(() => const HomePage());
    }
    return firebaseApp;
  }

  static Future signUpWithEmailPassword(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {Get.offAll(() => const HomePage())});
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  static Future signInWithEmailPassword(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {Get.offAll(() => const HomePage())});
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<User?> signInWithGoogle() async {
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

        _user = userCredential.user;
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
    return _user;
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

  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut().then((value) => {
            Get.snackbar(
              'Success',
              'Signing out',
              icon: const Icon(
                FontAwesomeIcons.circleCheck,
                color: Colors.tealAccent,
              ),
            ),
            Get.offAll(() => const LoginPage())
          });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error signing out. Try again later.',
        icon: const Icon(FontAwesomeIcons.exclamation, color: Colors.redAccent),
      );
    }
  }
}
