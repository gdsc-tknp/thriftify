import 'package:flutter/material.dart';

class ResalePage extends StatefulWidget {
  const ResalePage({Key? key}) : super(key: key);

  @override
  State<ResalePage> createState() => _ResalePageState();
}

class _ResalePageState extends State<ResalePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resale')),
      body: Column(
        children: const [
          Center(child: Text('Will be available in the Next Release'))
        ],
      ),
    );
  }
}
