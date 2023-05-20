import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbhss_library/utlis/enum/user.dart';
import 'package:gbhss_library/view_model/web_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenDrawer extends StatefulWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  late User currentUser;

  @override
  void initState() {
    currentUser = Provider.of<WebProvider>(context, listen: false).currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: Center(child: Image.asset('assets/icon.png', width: 80, height: 80)),
          ),
          drawerTile('Student', User.student),
          drawerTile('Teacher', User.teacher),
        ],
      ),
    );
  }

  Widget drawerTile(String title, User user) {
    return ListTile(
      tileColor: currentUser == user ? Colors.grey[400] : null,
      title: Text(title),
      onTap: () {
        if (currentUser != user) {
          Provider.of<WebProvider>(context, listen: false).setUser(user);
        }
        // Close Drawer
        Navigator.pop(context);
      },
    );
  }
}
