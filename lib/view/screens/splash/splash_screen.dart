import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    init(context);
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 125),
      ),
    );
  }

  void init(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }
}
