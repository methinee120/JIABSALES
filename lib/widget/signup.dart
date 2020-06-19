import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiabsales/utility/normal_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String type;
  String name = '', user = '', password = '';

  Future<Null> registerThrade() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth
        .createUserWithEmailAndPassword(email: user, password: password)
        .then((value) async {
      print('Register Success');
      FirebaseUser firebaseUser = value.user;
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = name;
      firebaseUser.updateProfile(info);
      String uid = firebaseUser.uid;
      print('uid = $uid');

      Firestore firestore = Firestore.instance;
      Map<String, dynamic> map = Map();
      map['Name'] = name;
      map['Type'] = type;

      await firestore
          .collection('User')
          .document(uid)
          .setData(map)
          .then((value) {
        Navigator.pop(context);
      });
    }).catchError((value) {
      String string = value.message;
      normalDialog(context, string);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (name.isEmpty || user.isEmpty || password.isEmpty) {
            normalDialog(context, 'โปรดกรอกทุกช่อง');
          } else if (type == null) {
            normalDialog(context, 'โปรดเลือกชนิดสมาชิก');
          } else {
            registerThrade();
          }
        },
        child: Icon(Icons.cloud_upload),
      ),
      appBar: AppBar(
        title: Text('สมัครสมาชิค'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            nameForm(),
            userRadio(),
            shopRadio(),
            riderRadio(),
            userForm(),
            passwordForm(),
          ],
        ),
      ),
    );
  }

  Widget userRadio() => Container(
        width: 200.0,
        child: Row(
          children: <Widget>[
            Radio(
              value: 'User',
              groupValue: type,
              onChanged: (value) {
                setState(() {
                  type = value;
                });
              },
            ),
            Text('ผู้สั่งอาหาร')
          ],
        ),
      );

  Widget shopRadio() => Container(
        width: 200.0,
        child: Row(
          children: <Widget>[
            Radio(
              value: 'Shop',
              groupValue: type,
              onChanged: (value) {
                setState(() {
                  type = value;
                });
              },
            ),
            Text('ผู้ขายอาหาร')
          ],
        ),
      );

  Widget riderRadio() => Container(
        width: 200.0,
        child: Row(
          children: <Widget>[
            Radio(
              value: 'Rider',
              groupValue: type,
              onChanged: (value) {
                setState(() {
                  type = value;
                });
              },
            ),
            Text('ผู้ส่งอาหาร')
          ],
        ),
      );

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                labelText: 'ชื่อ :',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextField(
              onChanged: (value) => user = value.trim(),
              decoration: InputDecoration(
                labelText: 'User :',
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
              onChanged: (value) => password = value.trim(),
              decoration: InputDecoration(
                labelText: 'Password :',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
