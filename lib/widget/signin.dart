import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiabsales/utility/normal_dialog.dart';
import 'package:jiabsales/widget/main_rider.dart';
import 'package:jiabsales/widget/main_shop.dart';
import 'package:jiabsales/widget/main_user.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email, password;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => checkAuthen(),
        child: Icon(Icons.navigate_next),
      ),
      appBar: AppBar(
        title: Text('ลงชื่อใช้งาน'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[emailForm(), passwordForm()],
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    if (email == null ||
        email.isEmpty ||
        password == null ||
        password.isEmpty) {
      normalDialog(context, 'Have space? Please fill everyBlank');
    } else {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        String uid = value.user.uid;
        print('uid ====>>  $uid');

        Firestore firestore = Firestore.instance;
        await firestore
            .collection('User')
            .document(uid)
            .snapshots()
            .listen((event) {
          String type = event.data['Type'];
          print('Type ===>> $type');
          chooseType(type);
        });
      }).catchError((value) {
        String string = value.message;
        normalDialog(context, string);
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

  Widget emailForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email : ',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextField(
              obscureText: true,
              onChanged: (value) => password = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password : ',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
