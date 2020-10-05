class ToDoList {
  String title;
  bool completed;
  String details;

  ToDoList(this.title, this.completed, this.details);

  Map<String, dynamic> toJson() =>
      {'title': title, 'completed': completed, 'details': details};
}
