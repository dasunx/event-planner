import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/classes/ShoppingList.dart';
import 'package:event_planner/classes/ToDoList.dart';
import 'package:event_planner/components/Toast.dart';
import 'package:event_planner/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';

class FirebaseHelper {
  final _instance = FirebaseFirestore.instance;

  void addEvent(Event ev, BuildContext context) {
    _instance.runTransaction((transaction) async {
      var res = await _instance.collection('events').add(ev.toJson());
      if (res.id != null) {
        showToast("Event added Successfully");
        Navigator.popAndPushNamed(
          context,
          HomeScreen.id,
        );
      }
    });
  }

  void addGuest(String id, Guest guest, BuildContext context) {
    List obj = [guest.toJson()];
    _instance.runTransaction((transaction) async {
      var res = await _instance
          .collection('events')
          .doc(id)
          .update({'guests': FieldValue.arrayUnion(obj)});
    });
    showToast("Guest added");
  }

  void addTodo(String id, ToDoList todo, BuildContext context) {
    List obj = [todo.toJson()];
    _instance.runTransaction((transaction) async {
      var res = await _instance
          .collection('events')
          .doc(id)
          .update({'todoList': FieldValue.arrayUnion(obj)});
      showToast("Todo item added");
    });
  }

  void addShoppingList(String id, ShoppingList shoppingList) {
    List obj = [shoppingList.toJson()];
    _instance.runTransaction((transaction) async {
      var res = await _instance
          .collection('events')
          .doc(id)
          .update({'shoppingList': FieldValue.arrayUnion(obj)});
      showToast("Shopping item added");
    });
  }
}
