import 'package:flutter/material.dart';
import 'package:jiabsales/utility/my_api.dart';

class MainRider extends StatefulWidget {
  @override
  _MainRiderState createState() => _MainRiderState();
}

class _MainRiderState extends State<MainRider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[MyAPI().menuSignOut(context)],
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Main Rider'),
      ),
    );
  }
}
