import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation'),
      ),
      body: ListView(
        children: const [Center(child: Text('No Items to Donate'))],
      ),
    );
  }
}
