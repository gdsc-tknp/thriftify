import 'package:flutter/material.dart';
import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:supro_vigilant/ui/login_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoOnboarding(
      onPressedOnLastPage: () => Get.offAll(() => const LoginPage()),
      bottomButtonBorderRadius: BorderRadius.circular(8),
      bottomButtonChild:
          const Text('Continue', style: TextStyle(fontFamily: 'Poppins')),
      pages: [
        WhatsNewPage(
          title: const Text("Recycle", style: TextStyle(fontFamily: 'Poppins')),
          features: const [
            WhatsNewFeature(
              icon: Icon(FontAwesomeIcons.recycle),
              title: Text('Find Recycler',
                  style: TextStyle(fontFamily: 'Poppins')),
              description: Text(
                  'SV suggests efficiency recycling dealers, based on different products on you data',
                  style: TextStyle(fontFamily: 'Poppins')),
            ),
            WhatsNewFeature(
              icon: Icon(Icons.recycling),
              title: Text('Time to Recycle'),
              description: Text(
                "SV uses data provide to suggest dor you a suitable way to recycle your products, it aso provides with notification on proper consumption.",
              ),
            ),
          ],
        ),
        WhatsNewPage(
          title: const Text("Donate", style: TextStyle(fontFamily: 'Poppins')),
          features: [
            const WhatsNewFeature(
              icon: Icon(Icons.account_balance_wallet),
              title: Text('Find Donation Center',
                  style: TextStyle(fontFamily: 'Poppins')),
              description: Text(
                  'SV suggests efficiency  consumption products, Messages, and Safari, so you can add them easily, such as flight reservations and hotel bookings.',
                  style: TextStyle(fontFamily: 'Poppins')),
            ),
            const WhatsNewFeature(
              icon: Icon(FontAwesomeIcons.circleDollarToSlot),
              title: Text('Time to Donate',
                  style: TextStyle(fontFamily: 'Poppins')),
              description: Text(
                  "SV uses Apple Maps to look up consumable, traffic conditions, and reliable options to tell you when it's time to recycle.",
                  style: TextStyle(fontFamily: 'Poppins')),
            ),
            Lottie.asset('assets/lottie/donate.json')
          ],
        ),
        WhatsNewPage(
          title: const Text("Resale", style: TextStyle(fontFamily: 'Poppins')),
          features: const [
            WhatsNewFeature(
              icon: Icon(Icons.account_balance_wallet),
              title:
                  Text('Find Market', style: TextStyle(fontFamily: 'Poppins')),
              description: Text(
                  'SV suggests efficiency  consumption products, Messages, and Safari, so you can add them easily, such as flight reservations and hotel bookings.',
                  style: TextStyle(fontFamily: 'Poppins')),
            ),
            WhatsNewFeature(
              icon: Icon(FontAwesomeIcons.dollarSign),
              title: Text('Time to Resale',
                  style: TextStyle(fontFamily: 'Poppins')),
              description: Text(
                  "SV uses Apple Maps to look up markets, traffic conditions, and reliable options to tell you when it's time to recycle.",
                  style: TextStyle(fontFamily: 'Poppins')),
            ),
          ],
        ),
      ],
    );
  }
}
