import 'package:flutter/material.dart';
import 'package:gbhss_library/utlis/constants.dart';
import 'package:gbhss_library/view_model/web_provider.dart';
import 'package:provider/provider.dart';

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
    var webProvider = Provider.of<WebProvider>(context, listen: false);
    // Get ip and user receive from local
    webProvider.setIp(Default.DEFAULT_IP);
    webProvider.setPort(Default.DEFAULT_STUDENT_PORT);
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }
}
