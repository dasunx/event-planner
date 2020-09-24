import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/ShoppingList.dart';
import 'package:event_planner/components/EmptyList.dart';
import 'package:event_planner/components/SearchBar.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/shoppinglist/add_shoppinglist.dart';
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
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.shopping_basket,
                  color: kMainColor,
                ),
              ),
              Text(
                item.name,
              ),
              Spacer(),
              Text(
                "LKR  ${item.price.toString()}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
