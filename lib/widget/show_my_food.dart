import 'package:flutter/material.dart';
import 'package:jiabsales/widget/add_food_menu.dart';

class ShowMyFood extends StatefulWidget {
  @override
  _ShowMyFoodState createState() => _ShowMyFoodState();
}

class _ShowMyFoodState extends State<ShowMyFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => AddFoodMenu(),
          );
          Navigator.push(context, route);
        },
        child: Icon(Icons.add),
      ),
      body: Text('This is my food'),
    );
  }
}
