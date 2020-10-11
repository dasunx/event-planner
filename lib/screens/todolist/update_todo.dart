import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/classes/ToDoList.dart';
import 'package:event_planner/components/Toast.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/todolist/view_todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateToDo extends StatefulWidget {
  static const String id = 'update_todo';
  @override
  _UpdateToDoState createState() => _UpdateToDoState();
}

class _UpdateToDoState extends State<UpdateToDo> {
  TextEditingController txName = new TextEditingController();
  TextEditingController txNote = new TextEditingController();
  int time = 1;
  Event event;
  UpdateGuestArguments ug;
  String name;
  String note;
  int index;
  bool state = false;
  @override
  Widget build(BuildContext context) {
    if (time == 1) {
      ug = ModalRoute.of(context).settings.arguments;
      event = ug.event;
      index = ug.index;
      setState(() {
        txName..text = event.todoList[index].title;
        txNote..text = event.todoList[index].details;
        name = event.todoList[index].title;
        note = event.todoList[index].details;
        state = event.todoList[index].completed;
      });
    }
    time++;
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
                    "Update Todo",
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
                          value: state,
                          onChanged: (s) {
                            setState(() {
                              state = s;
                            });
                            print(s);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          state ? "Completed" : "Not completed",
                          style:
                              kLabelTextStyle.copyWith(color: Colors.black45),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: txNote,
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
                    //todo firebase function{
                    // FirebaseHelper fl = new FirebaseHelper();
                    // ToDoList td = ToDoList(name, state, note);

                    // event.todoList.add(td);
                    // fl.addTodo(event.id, td, context);
                    //}
                    // fl.addGuest(event.id, guest, context);
                    if (name != null && note != null) {
                      if (name != event.todoList[index].title ||
                          note != event.todoList[index].details ||
                          state != event.todoList[index].completed) {
                        event.todoList[index].title = name;
                        event.todoList[index].details = note;
                        event.todoList[index].completed = state;
                        showToast("Item updated");
                      } else {
                        showToast("Nothing changed");
                        Navigator.pop(context);
                      }
                    } else {
                      showToast("Please fill details");
                    }
                    Navigator.popAndPushNamed(context, ViewToDo.id,
                        arguments: event);
                  },
                  title: "Update",
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
