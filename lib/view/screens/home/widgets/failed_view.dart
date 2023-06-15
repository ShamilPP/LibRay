import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/web_provider.dart';

class FailedView extends StatelessWidget {
  const FailedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, color: Colors.grey[700], size: 40),
          const SizedBox(height: 10),
          Text('Oops..! Failed to connect to the server', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('Please connect to Wi-Fi and try again', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          const SizedBox(height: 15),
          ElevatedButton(
            child: const Text('Try Again'),
            onPressed: () {
              Provider.of<WebProvider>(context, listen: false).updateConnectivity();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              textStyle: const TextStyle(fontSize: 14),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
