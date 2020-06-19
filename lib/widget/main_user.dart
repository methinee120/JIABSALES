import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiabsales/main.dart';
import 'package:jiabsales/utility/my_api.dart';
import 'package:jiabsales/widget/guest.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child:  Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
              ],
            ), Column(mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MyAPI().menuSignOut(context),
              ],
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Main User'),
      ),
    );
  }
}
