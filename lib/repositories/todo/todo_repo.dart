import 'package:flutter_image_classifier/models/todo.dart';

abstract class TodoRepo {

  Future<List<Todo>> loadTodoList();

  Future saveTodoList(List<Todo> todoList);

}