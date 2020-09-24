import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/Guest.dart';

class EventBrain {
  List<Event> eventList = [
    Event("Supun Birthday party", DateTime(2020, 11, 01),
        DateTime(2020, 11, 02), 50000.0, "1", [
      Guest('mwdasun@gmail.com', "Dasun Ekanayake", true,
          "Please call me if you can't join", "1"),
      Guest("johnDoe@gmail.com", "John Doe", false,
          "I hope you will attend to this party", "s")
    ]),
    Event("Banda's Wedding", DateTime(2020, 12, 06), DateTime(2020, 12, 09),
        150000.0, "2", null),
    Event("Mahesh Engagement party", DateTime(2020, 11, 12),
        DateTime(2020, 11, 12), 70000.0, "3", null),
    Event("Nolimt public gathering", DateTime(2020, 12, 01),
        DateTime(2020, 12, 02), 134000.0, "4", null),
    Event("Relational office meeting", DateTime(2021, 01, 01),
        DateTime(2020, 01, 02), 23000.0, "5", null),
    Event("Amila's Birthday", DateTime(2020, 02, 02), DateTime(2021, 02, 02),
        40000.0, "6", null)
  ];
}
