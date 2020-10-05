import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/classes/ShoppingList.dart';
import 'package:event_planner/components/AlertDialog.dart';
import 'package:event_planner/components/EmptyList.dart';
import 'package:event_planner/components/SearchBar.dart';
import 'package:event_planner/components/Toast.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/shoppinglist/add_shoppinglist.dart';
import 'package:event_planner/screens/shoppinglist/update_shopping_list.dart';
import 'package:flutter/material.dart';

class ViewShoppingList extends StatefulWidget {
  static const String id = 'view_shoppinglist';
  @override
  _ViewShoppingListState createState() => _ViewShoppingListState();
}

class _ViewShoppingListState extends State<ViewShoppingList> {
  TextEditingController myCon = TextEditingController();
  var total = 0.0;
  Event event;
  var time = 1;
  FocusNode myFocusNode;
  var shopList;
  var shopItems = List<ShoppingList>();
  bool conditionx = false;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  void filterResult(String query) {
    List<ShoppingList> searchList = List<ShoppingList>();
    searchList.addAll(shopList);
    if (query.isNotEmpty) {
      List<ShoppingList> dummyList = List<ShoppingList>();
      searchList.forEach((item) {
        if (item.name.toLowerCase().contains(query)) {
          dummyList.add(item);
        }
      });
      setState(() {
        shopItems.clear();
        shopItems.addAll(dummyList);
      });
      return;
    } else {
      setState(() {
        shopItems.clear();
        shopItems.addAll(shopList);
      });
    }
  }

  void deleteItem(int index) {
    //todo add firebase function
    event.shoppingList.removeAt(index);
    setState(() {
      shopItems.clear();
      shopItems.addAll(event.shoppingList);
      if (shopItems != null) {
        if (shopItems.length <= 0) {
          conditionx = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (time == 1) {
      time++;
      event = ModalRoute.of(context).settings.arguments;
      if (event.shoppingList != null) {
        shopList = event.shoppingList;
        shopItems.addAll(shopList);
        shopItems.forEach((element) {
          total += element.price;
        });
        if (event.shoppingList.length > 0) {
          conditionx = true;
        }
      }
    }
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          '${event.title}',
        ),
      ),
      floatingActionButton: new Visibility(
        visible: conditionx,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, AddShoppingList.id,
                  arguments: event);
            },
            backgroundColor: kMainColor,
            elevation: 10,
            child: Icon(
              Icons.add,
              size: 34,
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "View Shopping List",
                  style: kTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              visible: conditionx,
              child: Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 40, right: 40),
                  child:
                      buildSearch(myFocusNode, "search shopping item", (value) {
                    filterResult(value);
                  }, myCon),
                ),
              ),
            ),
            conditionx
                ? Expanded(
                    flex: 8,
                    child: Container(
                      child: new ListView.builder(
                        itemCount: shopItems.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildShoppingItemList(context, index),
                      ),
                    ),
                  )
                : EmptyList(
                    title: "No Items yet!",
                    onPress: () {
                      Navigator.popAndPushNamed(context, AddShoppingList.id,
                          arguments: event);
                    },
                    buttonText: "Add Shopping item",
                  ),
            Visibility(
              visible: conditionx,
              child: Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(12),
                  color: kMainColorOpacity,
                  child: Row(
                    children: [
                      Text(
                        "Total",
                        style: kTitleTextStyle,
                      ),
                      Spacer(),
                      Text(
                        "LKR $total",
                        style: kTitleTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildShoppingItemList(BuildContext context, int index) {
    var item = shopItems[index];

    return Container(
      margin: EdgeInsets.only(right: 6, left: 6, top: 10),
      child: Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Checkbox(
                  value: item.purchased,
                  onChanged: (value) {
                    item.purchased = value;
                    myFocusNode.unfocus();
                    myCon.clear();
                    setState(() {
                      item.purchased = value;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 12,
                child: Card(
                  elevation: 5,
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name.toString(),
                            style: TextStyle(
                                decoration: item.purchased
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                            visible: item.purchased,
                            child: Chip(
                              backgroundColor: kMainColor,
                              avatar: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.done),
                              ),
                              label: Text("Purchased"),
                            ),
                          ),
                        )
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              'LKR ${item.price.toString()}',
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, UpdateShoppingList.id,
                                    arguments:
                                        UpdateGuestArguments(index, event));
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                showAlertDialog(
                                    context,
                                    "Delete Shopping list item",
                                    "Are you sure, do you need to delete this item?",
                                    "Delete",
                                    "No", () {
                                  deleteItem(index);
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  showToast("Item deleted");
                                }, () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                });
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
