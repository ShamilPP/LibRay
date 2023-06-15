import 'package:flutter/material.dart';
import 'package:libray/utlis/constants.dart';
import 'package:libray/utlis/enum/user.dart';
import 'package:libray/view_model/application_provider.dart';
import 'package:libray/view_model/web_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    init(context);
    return Scaffold(
      body: Center(
        child: Image.asset('assets/icon.png', width: 150, height: 150),
      ),
    );
  }

  void init(BuildContext context) async {
    var webProvider = Provider.of<WebProvider>(context, listen: false);
    var appProvider = Provider.of<ApplicationProvider>(context, listen: false);
    // Get ip, port, title and userType receive from local
    SharedPreferences preference = await SharedPreferences.getInstance();
    if (!preference.containsKey('user')) {
      await preference.setInt('user', 1);
    }
    if (!preference.containsKey('ip')) {
      await preference.setString('ip', Default.DEFAULT_IP);
    }
    if (!preference.containsKey('port')) {
      await preference.setString('port', Default.DEFAULT_STUDENT_PORT);
    }
    if (!preference.containsKey('title')) {
      await preference.setString('title', 'GBHSS MPM');
    }
    webProvider.setIp(preference.getString('ip')!);
    webProvider.setPort(preference.getString('port')!);
    appProvider.setTitle(preference.getString('title')!);
    if (preference.getInt('user') == 1) {
      appProvider.setUser(User.student);
    } else {
      appProvider.setUser(User.staff);
    }

    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }
}
