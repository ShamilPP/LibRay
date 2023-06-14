import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gbhss_library/view_model/application_provider.dart';
import 'package:gbhss_library/view_model/web_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ApplicationProvider, WebProvider>(builder: (context, appProvider, webProvider, child) {
      return Scaffold(
        appBar: AppBar(title: Text('Settings')),
        body: Column(
          children: [
            ListTile(
              title: Text('Title'),
              subtitle: Text('Change app title (${appProvider.title})'),
              onTap: () {
                showChangeDialog(context, 'Title', appProvider.title, (text) {
                  if (text != '') {
                    if (text != appProvider.title) {
                      appProvider.setTitle(text);
                      Fluttertoast.showToast(msg: 'Updated', backgroundColor: Colors.green);
                    }
                  } else {
                    Fluttertoast.showToast(msg: 'Failed', backgroundColor: Colors.red);
                  }
                });
              },
            ),
            Divider(height: 0),
            ListTile(
              title: Text('IP'),
              subtitle: Text('Change IP (${webProvider.ip})'),
              onTap: () {
                showChangeDialog(context, 'IP', webProvider.ip, (text) {
                  if (text != '') {
                    if (text != webProvider.ip) {
                      webProvider.setIp(text);
                      webProvider.updateConnectivity();
                      Fluttertoast.showToast(msg: 'Updated', backgroundColor: Colors.green);
                    }
                  } else {
                    Fluttertoast.showToast(msg: 'Failed', backgroundColor: Colors.red);
                  }
                });
              },
            ),
            ListTile(
              title: Text('Port'),
              subtitle: Text('Change PORT (${webProvider.port})'),
              onTap: () {
                showChangeDialog(context, 'PORT', webProvider.port, (text) {
                  if (text != '' && (int.tryParse(text)) != null) {
                    if (text != webProvider.port) {
                      webProvider.setPort(text);
                      webProvider.updateConnectivity();
                      Fluttertoast.showToast(msg: 'Updated', backgroundColor: Colors.green);
                    }
                  } else {
                    Fluttertoast.showToast(msg: 'Failed', backgroundColor: Colors.red);
                  }
                });
              },
            ),
          ],
        ),
      );
    });
  }

  showChangeDialog(BuildContext context, String title, String oldText, void Function(String) onTap) {
    final controller = TextEditingController(text: oldText);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: title, border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
              onPressed: () {
                onTap(controller.text);
                Navigator.pop(context);
              },
              child: Text('Save')),
        ],
      ),
    );
  }
}
