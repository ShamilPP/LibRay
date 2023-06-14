import 'package:flutter/material.dart';
import 'package:gbhss_library/view/screens/splash/splash_screen.dart';
import 'package:gbhss_library/view_model/application_provider.dart';
import 'package:gbhss_library/view_model/book_provider.dart';
import 'package:gbhss_library/view_model/web_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApplicationProvider()),
        ChangeNotifierProvider(create: (_) => WebProvider()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ],
      child: MaterialApp(
        title: 'GBHSS Library',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const SplashScreen(),
      ),
    );
  }
}
