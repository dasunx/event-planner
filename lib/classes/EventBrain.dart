import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/classes/ShoppingList.dart';
import 'package:event_planner/classes/ToDoList.dart';

class EventBrain {
  List<Event> eventList = [
    Event("Supun Birthday party", "Kurunegala", DateTime(2020, 11, 01),
        DateTime(2020, 11, 02), 50000.0, "1", [
      Guest('mwdasun@gmail.com', "Dasun Ekanayake", true,
          "Please call me if you can't join", "1"),
      Guest("johnDoe@gmail.com", "John Doe", false,
          "I hope you will attend to this party", "s")
    ], [
      ShoppingList(
          'item1', 'Balloons', 100, 500, 'Have to buy another set of balloons'),
      ShoppingList('item2', 'Cake', 1, 4000, null)
    ], [
      ToDoList("Go shopping", false, "Buy balloons from different colors"),
      ToDoList(
          "Invite bride's friends", true, "Office friends, school friends"),
    ]),
    Event("Banda's Wedding", "Colombo", DateTime(2020, 12, 06),
        DateTime(2020, 12, 09), 150000.0, "2", [], [], [])
    // Event("Mahesh Engagement party", DateTime(2020, 11, 12),
    //     DateTime(2020, 11, 12), 70000.0, "3"),
    // Event("Nolimt public gathering", DateTime(2020, 12, 01),
    //     DateTime(2020, 12, 02), 134000.0, "4"),
    // Event("Relational office meeting", DateTime(2021, 01, 01),
    //     DateTime(2020, 01, 02), 23000.0, "5"),
    // Event("Amila's Birthday", DateTime(2020, 02, 02), DateTime(2021, 02, 02),
    //     40000.0, "6")
  ];
}
