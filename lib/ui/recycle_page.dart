import 'package:flutter/material.dart';

class RecyclePage extends StatefulWidget {
  const RecyclePage({Key? key}) : super(key: key);

  @override
  State<RecyclePage> createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recycle')),
      body: ListView(
        children: const [Center(child: Text('No Items to Recycle'))],
      ),
    );
  }
}
