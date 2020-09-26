import 'package:event_planner/classes/Event.dart';

class Guest {
  final String email;
  final String name;
  final bool gender;
  final String note;

  Guest(this.email, this.name, this.gender, this.note);

  Map<String, dynamic> toJson() =>
      {'email': email, 'name': name, 'gender': gender, 'note': note};
}
