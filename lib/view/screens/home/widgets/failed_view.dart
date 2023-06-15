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
          Icon(Icons.cloud_off, color: Colors.grey[700], size: 60),
          const SizedBox(height: 20),
          Text('Oops..! Failed to connect to the server', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('Please connect to Wi-Fi and try again', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('Try Again'),
            onPressed: () {
              Provider.of<WebProvider>(context, listen: false).updateConnectivity();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              textStyle: const TextStyle(fontSize: 16),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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
