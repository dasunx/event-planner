import 'package:flutter/material.dart';

class AddShoppingList extends StatefulWidget {
  static const String id = 'add_shoppinglist';
  @override
  _AddShoppingListState createState() => _AddShoppingListState();
}

class _AddShoppingListState extends State<AddShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
          "Add shopping list item",
        ),
      ),
    );
  }
}
