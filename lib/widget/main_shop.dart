import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiabsales/utility/my_api.dart';
import 'package:jiabsales/widget/show_my_food.dart';
import 'package:jiabsales/widget/show_order.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  String nameLogin, emailLogin;
  Widget currentWidget;

  @override
  void initState() {
    super.initState();
    findLogin();
    currentWidget = ShowOrderShop();
  }

  Future<Null> findLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.currentUser().then((value) {
      setState(() {
        nameLogin = value.displayName;
        emailLogin = value.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(context),
      appBar: AppBar(
        title: Text(nameLogin == null ? 'Main Shop' : nameLogin),
      ),
      body: currentWidget,
    );
  }

  Drawer showDrawer(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              showHead(),
              menuOrder(),
              menuMyFood(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MyAPI().menuSignOut(context),
            ],
          )
        ],
      ),
    );
  }

  ListTile menuOrder() => ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowOrderShop();
          });
        },
        leading: Icon(Icons.restaurant_menu),
        title: Text('Show menu Order'),
      );

  ListTile menuMyFood() => ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowMyFood();
          });
        },
        leading: Icon(Icons.fastfood),
        title: Text('Show my Food'),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bookshop.jpg'), fit: BoxFit.cover)),
      accountName: Text(
        nameLogin == null ? 'Name' : nameLogin,
        style: TextStyle(color: Colors.pinkAccent),
      ),
      accountEmail: Text(
        emailLogin == null ? 'Email' : emailLogin,
        style: TextStyle(color: Colors.pinkAccent),
      ),
    );
  }
}
