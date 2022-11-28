import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../utlis/enum/user.dart';
import '../../../../view_model/web_view_model.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Library'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {},
        ), //IconButton
        Consumer<WebProvider>(builder: (ctx, provider, child) {
          if (provider.currentUser == User.teacher) {
            return PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return [const PopupMenuItem<String>(value: 'Scan', child: Text('Scan'))];
              },
              onSelected: (selected) async {
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666',
                  'Cancel',
                  false,
                  ScanMode.BARCODE,
                );
                Fluttertoast.showToast(msg: barcodeScanRes);
              },
            );
          } else {
            return const SizedBox();
          }
        }),
      ],
    );
  }
}
