import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbhss_library/utlis/enum/user.dart';
import 'package:gbhss_library/view_model/web_view_model.dart';
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
            child: const Center(child: FlutterLogo(size: 70)),
          ),
          drawerTile('Student', User.student),
          drawerTile('Teacher', User.teacher),
        ],
      ),
    );
  }

  Widget drawerTile(String title, User user) {
    return Material(
      color: currentUser == user ? Colors.grey[400] : null,
      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
      child: InkWell(
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
        child: ListTile(
          trailing: const Icon(CupertinoIcons.forward),
          title: Text(title),
        ),
        onTap: () {
          if (currentUser != user) {
            Provider.of<WebProvider>(context, listen: false).setUser(user);
          }
          // Close Drawer
          Navigator.pop(context);
        },
      ),
    );
  }
}
