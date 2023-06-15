import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:libray/view_model/application_provider.dart';
import 'package:libray/view_model/web_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                showChangeDialog(context, 'Title', appProvider.title, (text) async {
                  if (text != '') {
                    if (text != appProvider.title) {
                      appProvider.setTitle(text);
                      SharedPreferences preference = await SharedPreferences.getInstance();
                      await preference.setString('title', text);
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
                showChangeDialog(context, 'IP', webProvider.ip, (text) async {
                  if (text != '') {
                    if (text != webProvider.ip) {
                      webProvider.setIp(text);
                      webProvider.updateConnectivity();
                      SharedPreferences preference = await SharedPreferences.getInstance();
                      await preference.setString('ip', text);
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
              title: Text('Port'),
              subtitle: Text('Change PORT (${webProvider.port})'),
              onTap: () {
                showChangeDialog(context, 'PORT', webProvider.port, (text) async {
                  if (text != '' && (int.tryParse(text)) != null) {
                    if (text != webProvider.port) {
                      webProvider.setPort(text);
                      webProvider.updateConnectivity();
                      SharedPreferences preference = await SharedPreferences.getInstance();
                      await preference.setString('port', text);
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
