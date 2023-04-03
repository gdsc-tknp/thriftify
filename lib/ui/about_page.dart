import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('About SV'),),
      body: const Center(
        child: Card(margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'SV is your Resource Efficient helper in production and consumption',style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
