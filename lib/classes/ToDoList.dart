class ToDoList {
  final String title;
  bool completed;
  final String details;

  ToDoList(this.title, this.completed, this.details);

  Map<String, dynamic> toJson() =>
      {'title': title, 'completed': completed, 'details': details};
}
