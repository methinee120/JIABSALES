import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiabsales/widget/guest.dart';

class MyAPI {
  Widget menuSignOut(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.red),
      child: ListTile(
        leading: Icon(
          Icons.exit_to_app,
          color: Colors.white,
          size: 36.0,
        ),
        title: Text(
          'Sign Out',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'Sign out and Rout To Guest',
          style: TextStyle(color: Colors.white),
        ),
        onTap: () async {
          Navigator.pop(context);
          FirebaseAuth auth = FirebaseAuth.instance;
          await auth.signOut().then((value) => {});
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Guest(),
          );
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        },
      ),
    );
  }

  MyAPI();
}
