import 'package:event_planner/classes/Event.dart';

class User {
  final String name;
  final String email;
  final String password;
  List<Event> events;

  User(this.name, this.email, this.password);

  set addEvent(Event event) {
    events.add(event);
  }
}
