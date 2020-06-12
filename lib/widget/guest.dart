import 'package:flutter/material.dart';
import 'package:jiabsales/widget/signin.dart';
import 'package:jiabsales/widget/signup.dart';

class Guest extends StatefulWidget {
  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ยินดีต้อนรับ'),
      ),
      drawer: Drawer(
        child: showDrawer(),
      ),
    );
  }

  Column showDrawer() {
    return Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('Guest'),
          accountEmail: Text('Please Login'),
        ),
        signInMenu(),
        signUpMenu(),
      ],
    );
  }

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(Icons.fingerprint),
      title: Text('Sign In'),
      subtitle: Text('การลงชื่อเข้าใช้'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => SignIn(),
        );
        Navigator.push(context, route);
      },
    );
  }

  ListTile signUpMenu() {
    return ListTile(
      leading: Icon(Icons.account_circle),
      title: Text('Sign Up'),
      subtitle: Text('สมัครเข้าใช้งาน'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => SignUp(),
        );
        Navigator.push(context, route);
      },
    );
  }
}
