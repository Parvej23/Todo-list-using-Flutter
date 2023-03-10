class TodoModel{
  String title;
  bool isComplete;

  TodoModel({
    required this.title,
    required this.isComplete
});

  void toggleComplete(){
    isComplete=!isComplete;
  }
}
