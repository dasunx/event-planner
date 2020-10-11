import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/ShoppingList.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/functions/FirebaseHelper.dart';
import 'package:event_planner/screens/shoppinglist/view_shoppinglsit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddShoppingList extends StatefulWidget {
  static const String id = 'add_shoppinglist';
  @override
  _AddShoppingListState createState() => _AddShoppingListState();
}

class _AddShoppingListState extends State<AddShoppingList> {
  Event event;
  FocusNode myFocusNode;
  @override
  String name;
  int qty;
  double price;
  bool purchased = false;
  String note;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text('${event.title}', style: TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white)),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Add Shopping Item",
                    style: kTitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 28.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Item name", labelText: 'Name'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        qty = int.parse(value);
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Quantity", labelText: 'Quantity'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        price = double.parse(value);
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Total Price", labelText: 'Total price'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onChanged: (value) {
                        note = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Notes", labelText: 'Notes'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CupertinoSwitch(
                          activeColor: kMainColor,
                          value: purchased,
                          onChanged: (s) {
                            setState(() {
                              purchased = s;
                            });
                            print(s);
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Purchased :",
                          style: kTitleTextStyle.copyWith(
                              fontSize: 18, color: Colors.black87),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          purchased ? "yes" : "Not yet",
                          style:
                              kLabelTextStyle.copyWith(color: Colors.black45),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: button(
                  onPress: () {
                    FirebaseHelper fl = new FirebaseHelper();
                    ShoppingList sl =
                        ShoppingList(name, qty, price, note, purchased);
                    event.shoppingList.add(sl);
                    fl.addShoppingList(event.id, sl);

                    //Guest guest = Guest(email, name, _radioValue, note);
                    //event.guests.add(guest);
                    //fl.addGuest(event.id, guest, context);
                    Navigator.popAndPushNamed(context, ViewShoppingList.id,
                        arguments: event);
                    // showToast("Guest added");
                  },
                  title: "Save",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: button(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  title: "Cancel",
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
