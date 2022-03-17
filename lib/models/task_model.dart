class Task {
  int id;
  String title;
  String description;
  String priority;
  DateTime date;
  int status; //0-->incomplete 1->complete

  Task({this.title, this.description, this.date, this.priority, this.status});
  Task.withId(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.priority,
      this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if(id!=null)
        map['_id'] = id;

    map['title'] = title;
    map['description'] = description;
    map['date'] = date.toIso8601String();
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id : map['_id'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      priority: map['priority'],
      status: map['status'],
    );
  }
}
