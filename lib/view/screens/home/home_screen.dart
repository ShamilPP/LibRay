import 'package:flutter/material.dart';
import 'package:gbhss_library/utlis/constants.dart';
import 'package:gbhss_library/utlis/enum/status.dart';
import 'package:gbhss_library/utlis/enum/user.dart';
import 'package:gbhss_library/view/screens/home/widgets/failed_view.dart';
import 'package:gbhss_library/view/screens/home/widgets/home_appbar.dart';
import 'package:gbhss_library/view/screens/home/widgets/home_screen_drawer.dart';
import 'package:gbhss_library/view_model/web_view_model.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => Provider.of<WebProvider>(context, listen: false).checkConnectivity());
    return Scaffold(
      appBar: const HomeAppBar(),
      drawer: const HomeScreenDrawer(),
      body: Consumer<WebProvider>(
        builder: (ctx, provider, child) {
          if (provider.webStatus == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.webStatus == Status.success) {
          return WebView(
              initialUrl: provider.currentUser == User.student ? studentUrl : teacherUrl,
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