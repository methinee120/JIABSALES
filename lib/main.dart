import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiabsales/widget/guest.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Guest(),
      title: 'Jiab Sales',
    );
  }
}
