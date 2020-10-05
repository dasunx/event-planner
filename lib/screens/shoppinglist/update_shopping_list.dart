import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/Toast.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/shoppinglist/view_shoppinglsit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateShoppingList extends StatefulWidget {
  static const String id = 'update_shoppingItem';
  @override
  _UpdateShoppingListState createState() => _UpdateShoppingListState();
}

class _UpdateShoppingListState extends State<UpdateShoppingList> {
  TextEditingController txName = new TextEditingController();
  TextEditingController txQty = new TextEditingController();
  TextEditingController txPrice = new TextEditingController();
  TextEditingController txNote = new TextEditingController();
  Event event;
  FocusNode myFocusNode;
  @override
  String name;
  int qty;
  double price;
  bool purchased = false;
  String note;
  int time = 1;
  int index;
  UpdateGuestArguments upArgs;
  @override
  Widget build(BuildContext context) {
    if (time == 1) {
      upArgs = ModalRoute.of(context).settings.arguments;
      event = upArgs.event;
      index = upArgs.index;
      setState(() {
        txName..text = event.shoppingList[index].name;
        txQty..text = event.shoppingList[index].qty.toString();
        txPrice..text = event.shoppingList[index].price.toString();
        txNote..text = event.shoppingList[index].note;
        name = event.shoppingList[index].name;
        qty = event.shoppingList[index].qty;
        price = event.shoppingList[index].price;
        note = event.shoppingList[index].note;
        purchased = event.shoppingList[index].purchased;
      });
    }
    time++;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${event.title}',
        ),
      ),
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
                    "Update Shopping Item",
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
                      controller: txName,
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
                      controller: txQty,
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
                      controller: txPrice,
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
                      controller: txNote,
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
                    if (name != null &&
                        qty != null &&
                        price != null &&
                        note != null) {
                      event.shoppingList[index].name = name;
                      event.shoppingList[index].qty = qty;
                      event.shoppingList[index].price = price;
                      event.shoppingList[index].note = note;
                      event.shoppingList[index].purchased = purchased;
                      Navigator.popAndPushNamed(context, ViewShoppingList.id,
                          arguments: event);
                      showToast("item updated");
                    } else {
                      showToast("Please complete inputs");
                    }
                  },
                  title: "update",
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
