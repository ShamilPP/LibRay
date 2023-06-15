import 'package:flutter/material.dart';
import 'package:libray/view/screens/home/widgets/failed_view.dart';
import 'package:libray/view/screens/home/widgets/home_appbar.dart';
import 'package:libray/view_model/web_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../model/result.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => Provider.of<WebProvider>(context, listen: false).updateConnectivity());
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer<WebProvider>(
        builder: (ctx, provider, child) {
          if (provider.webStatus == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.webStatus == Status.success) {
            return WebView(
              initialUrl: provider.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                provider.setController(webViewController);
              },
            );
          } else {
            return const FailedView();
          }
        },
      ),
    );
  }
}
