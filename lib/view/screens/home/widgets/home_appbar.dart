import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:libray/utlis/enum/user.dart';
import 'package:libray/view_model/application_provider.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/web_provider.dart';
import '../../settings/settings_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(
      builder: (context, provider, child) {
        return AppBar(
          title: Text('LibRay (${provider.title})'),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return [
                  if (provider.user == User.staff)
                    PopupMenuItem<String>(
                      value: 'Scan',
                      child: Text('Scan'),
                    ),
                  PopupMenuItem<String>(
                    value: 'Settings',
                    child: Text('Settings'),
                  ),
                ];
              },
              onSelected: (selected) async {
                switch (selected) {
                  case 'Scan':
                    scanBarcodeAndApply(context);
                    break;
                  case 'Settings':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
                    break;
                }
              },
            ),
          ],
        );
      },
    );
  }

  void scanBarcodeAndApply(BuildContext context) async {
    String result = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      false,
      ScanMode.BARCODE,
    );
    final webViewController = Provider.of<WebProvider>(context, listen: false).webViewController;
    // Apply text
    if (result != '-1' && webViewController != null) {
      webViewController.runJavascript('document.getElementById("ret_barcode").value = "$result";');
    }
  }
}
