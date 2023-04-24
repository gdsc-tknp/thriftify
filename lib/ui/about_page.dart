import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Supro Vigilant')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
        children: [
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
          const SizedBox(height: 20),
          const Center(
            child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Supro Vigilant is an app that is capable of promoting transition of a circular economy where waste is minimized and resources are used in a sustainable way.',
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () =>
                    launchUrl(Uri.parse('https://bit.ly/gdsc-tknp')),
                icon: const Image(
                  image: AssetImage("assets/images/gdsc.png"),
                  height: 20.0,
                ),
              ),
              IconButton(
                onPressed: () =>
                    launchUrl(Uri.parse('https://github.com/gdsctknp')),
                icon: const FaIcon(
                  FontAwesomeIcons.github,
                  color: Color(0xff5cd3d4),
                ),
              ),
              IconButton(
                onPressed: () =>
                    launchUrl(Uri.parse('https://twitter.com/gdsctknp')),
                icon: const FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Color(0xff5cd3d4),
                ),
              ),
              IconButton(
                onPressed: () => launchUrl(
                    Uri.parse('https://linkedin.com/company/gdsctknp')),
                icon: const FaIcon(
                  FontAwesomeIcons.linkedinIn,
                  color: Color(0xff5cd3d4),
                ),
              ),
              IconButton(
                onPressed: () =>
                    launchUrl(Uri.parse('https://wa.com/gdsctknp')),
                icon: const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Color(0xff5cd3d4),
                ),
              ),
              IconButton(
                onPressed: () =>
                    launchUrl(Uri.parse('https://youtube.com/gdsctknp')),
                icon: const FaIcon(
                  FontAwesomeIcons.youtube,
                  color: Color(0xff5cd3d4),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
