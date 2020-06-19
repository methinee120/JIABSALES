import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiabsales/widget/signin.dart';
import 'package:jiabsales/widget/signup.dart';

import 'main_rider.dart';
import 'main_shop.dart';
import 'main_user.dart';

class Guest extends StatefulWidget {
  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }



  Future<Null> checkLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();
    if (firebaseUser != null) {
      String uid = firebaseUser.uid;
      print('uid = $uid');
      Firestore firestore = Firestore.instance;
      await firestore
          .collection('User')
          .document(uid)
          .snapshots()
          .listen((event) {
        String type = event.data['Type'];

        chooseType(type);
      });
    }
  }


void chooseType(String type) {
    switch (type) {
      case 'User':
        routeToService(MainUser());
        break;
      case 'Shop':
        routeToService(MainShop());
        break;

      case 'Rider':
        routeToService(MainRider());
        break;

      default:
    }
  }

 void routeToService(Widget widget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }



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
