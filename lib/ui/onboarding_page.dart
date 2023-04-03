import 'package:flutter/material.dart';
import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:supro_vigilant/theme/theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoOnboarding(
      onPressedOnLastPage: () => Navigator.pop(context),
      pages: [
        WhatsNewPage(
          title: const Text("What's New in Supro Vigilante"),
          features: const [
            WhatsNewFeature(
              icon: Icon(
                Icons.account_balance_wallet,
                // color: CupertinoColors.systemRed.resolveFrom(context),
              ),
              title: Text('Found Market'),
              description: Text(
                'SV suggests efficiency  consumption products, Messages, and Safari, so you can add them easily, such as flight reservations and hotel bookings.',
              ),
            ),
            WhatsNewFeature(
              icon: Icon(
                Icons.recycling,
                // color: CupertinoColors.systemRed.resolveFrom(context),
              ),
              title: Text('Time to Recycle'),
              description: Text(
                "SV uses Apple Maps to look up consumable, traffic conditions, and reliable options to tell you when it's time to recycle.",
              ),
            ),
          ],
        )
      ],
    );
  }
}
