import 'package:flutter/widgets.dart';

import '../model/todo_model.dart';

class TodoProvider extends ChangeNotifier{
  final List<TodoModel> _todoList=[];
  List<TodoModel> get allTodoList=>_todoList;
  void addTodoList(TodoModel todoModel){
    _todoList.add(todoModel);
    notifyListeners();
  }
  void todoStatusChange(TodoModel todoModel){
    final index=_todoList.indexOf(todoModel);
    _todoList[index].toggleComplete();
    notifyListeners();
  }
  void removeTodoList(TodoModel todoModel){
    final index=_todoList.indexOf(todoModel);
    _todoList.removeAt(index);
    notifyListeners();
  }
}
