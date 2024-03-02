import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todoModel = [];
  List<TodoModel> get todoModel => _todoModel;

  void setTodo(String todoModel) {
    _todoModel = todoModelFromJson(todoModel);
    notifyListeners();
  }

  void setTodoFromModel(List<TodoModel> todoModel) {
    _todoModel = todoModel;
    notifyListeners();
  }

}
