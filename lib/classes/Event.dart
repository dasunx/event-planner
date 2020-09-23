import 'package:event_planner/classes/Guest.dart';

class Event {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final double budget;
  final String id;
  List<Guest> guests;

  Event(this.title, this.startDate, this.endDate, this.budget, this.id,
      this.guests);

  set guestsList(Guest guest) {
    guests.add(guest);
  }
}
