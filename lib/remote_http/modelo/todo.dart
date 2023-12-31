class Todo {
  int userId;
  int id;
  String title;
  bool completed;
  
  Todo(this.userId, this.id, this.title, this.completed);

  Todo.fromJson(Map<String, dynamic> json)
    : userId = json['userId']??1, 
      id = json['id']??0,
      title = json['title'],
      completed = json['completed']?? false;

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'completed': completed,
  };
}