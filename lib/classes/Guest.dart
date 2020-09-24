import 'package:event_planner/classes/Event.dart';

class Guest {
  final String email;
  final String name;
  final bool gender;
  final String note;
  final String eventId;

  Guest(this.email, this.name, this.gender, this.note, this.eventId);
}
