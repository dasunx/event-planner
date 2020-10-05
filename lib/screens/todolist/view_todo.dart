import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/classes/ToDoList.dart';
import 'package:event_planner/components/AlertDialog.dart';
import 'package:event_planner/components/EmptyList.dart';
import 'package:event_planner/components/SearchBar.dart';
import 'package:event_planner/components/Toast.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/todolist/add_todo.dart';
import 'package:event_planner/screens/todolist/update_todo.dart';
import 'package:flutter/material.dart';

class ViewToDo extends StatefulWidget {
  static const String id = 'view_todo';

  @override
  _ViewToDoState createState() => _ViewToDoState();
}

class _ViewToDoState extends State<ViewToDo> {
  TextEditingController myCon = TextEditingController();
  Event event;
  FocusNode myFocusNode;
  var time = 1;

  var toDoLists;
  var toDoItems = List<ToDoList>();
  bool conditionx = false;
  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  void filterResult(String query) {
    List<ToDoList> searchList = List<ToDoList>();
    searchList.addAll(toDoLists);
    if (query.isNotEmpty) {
      List<ToDoList> dummyList = List<ToDoList>();
      searchList.forEach((item) {
        if (item.title.toLowerCase().contains(query) ||
            item.details.toLowerCase().contains(query)) {
          dummyList.add(item);
        }
      });
      setState(() {
        toDoItems.clear();
        toDoItems.addAll(dummyList);
      });
      return;
    } else {
      setState(() {
        toDoItems.clear();
        toDoItems.addAll(toDoLists);
      });
    }
  }

  void deleteItem(int index) {
    //todo add firebase function
    event.todoList.removeAt(index);
    setState(() {
      toDoItems.clear();
      toDoItems.addAll(event.todoList);
      if (toDoItems != null) {
        if (toDoItems.length <= 0) {
          conditionx = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (time == 1) {
      event = ModalRoute.of(context).settings.arguments;
      if (event.todoList != null) {
        toDoLists = event.todoList;
        toDoItems.addAll(toDoLists);
        if (event.todoList.length > 0) {
          conditionx = true;
        }
      }
    }

    time++;
    return Scaffold(
      floatingActionButton: new Visibility(
        visible: conditionx,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, AddToDo.id, arguments: event);
          },
          backgroundColor: kMainColor,
          elevation: 10,
          child: Icon(
            Icons.add,
            size: 34,
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          '${event.title}',
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          child: GestureDetector(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "View Todo",
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
                      child: buildSearch(myFocusNode, "search guest", (value) {
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
                            itemCount: toDoItems.length,
                            itemBuilder: (BuildContext context, int index) =>
                                buildTodoList(context, index),
                          ),
                        ),
                      )
                    : EmptyList(
                        title: "It's empty out here!",
                        onPress: () {
                          Navigator.popAndPushNamed(context, AddToDo.id,
                              arguments: event);
                        },
                        buttonText: "Add Todo",
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTodoList(BuildContext context, int index) {
    var item = toDoItems[index];
    bool check = item.completed;
    return Container(
      margin: EdgeInsets.only(right: 6, left: 6, top: 10),
      child: Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Checkbox(
                  value: check,
                  onChanged: (value) {
                    myFocusNode.unfocus();
                    myCon.clear();
                    setState(() {
                      item.completed = value;
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
                            item.title.toString(),
                            style: TextStyle(
                                decoration: item.completed
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                            visible: item.completed,
                            child: Chip(
                              backgroundColor: kMainColor,
                              avatar: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.done),
                              ),
                              label: Text("Completed"),
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
                              item.details,
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, UpdateToDo.id,
                                    arguments:
                                        UpdateGuestArguments(index, event));
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                showAlertDialog(
                                    context,
                                    "Delete Todo item",
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
