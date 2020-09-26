import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/classes/ToDoList.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/functions/FirebaseHelper.dart';
import 'package:event_planner/screens/todolist/view_todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  static const String id = 'add_todo';
  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  Event event;
  FocusNode myFocusNode;
  @override
  bool _switched = false;
  String email;
  String name;
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
                    "Add Todo",
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
                          hintText: "Todo Item", labelText: 'Item Title'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "State :",
                          style: kTitleTextStyle.copyWith(
                              fontSize: 18, color: Colors.black87),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CupertinoSwitch(
                          activeColor: kMainColor,
                          value: _switched,
                          onChanged: (s) {
                            setState(() {
                              _switched = s;
                            });
                            print(s);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _switched ? "Completed" : "Not completed",
                          style:
                              kLabelTextStyle.copyWith(color: Colors.black45),
                        ),
                      ],
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
                          hintText: "Details", labelText: 'Details'),
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
                    ToDoList td = ToDoList(name, _switched, note);

                    event.todoList.add(td);
                    fl.addTodo(event.id, td, context);
                    // fl.addGuest(event.id, guest, context);
                    Navigator.pushNamed(context, ViewToDo.id, arguments: event);
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
