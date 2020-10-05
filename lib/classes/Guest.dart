import 'package:event_planner/classes/Event.dart';

class Guest {
  String email;
  String name;
  bool gender;
  String note;
  bool invited;

  Guest(this.email, this.name, this.gender, this.note, this.invited);

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'gender': gender,
        'note': note,
        'invited': invited
      };
}
