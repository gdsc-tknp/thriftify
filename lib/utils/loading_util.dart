import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class LoadingUtil extends StatefulWidget {
  const LoadingUtil({Key? key}) : super(key: key);

  @override
  State<LoadingUtil> createState() => _LoadingUtilState();
}

class _LoadingUtilState extends State<LoadingUtil> {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: _composition,
      builder: (context, snapshot) {
        var composition = snapshot.data;
        return Center(child: Lottie(composition: composition));
      },
    );
  }
}
