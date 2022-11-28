import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/web_view_model.dart';

class FailedView extends StatelessWidget {
  const FailedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.grey[700],
            size: 40,
          ),
          const SizedBox(height: 10),
          const Text('Oops..! Failed to connect server', style: TextStyle(fontSize: 15)),
          const SizedBox(height: 10),
          const Text('Please connect to WIFI and Try again', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Try again'),
            onPressed: () {
              Provider.of<WebProvider>(context, listen: false).checkConnectivity();
            },
          ),
        ],
      ),
    );
  }
}
