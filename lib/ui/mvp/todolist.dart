import 'package:flutter_image_classifier/models/todo.dart';
import 'package:flutter_image_classifier/models/user.dart';
import 'package:flutter_image_classifier/models/visibility_filter.dart';
import 'package:flutter_image_classifier/utils/mvicore.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class TodoListModel {
  final VisibilityFilter filter;
  final List<Todo> todoList;
  final bool loading;
  final User user;

  TodoListModel({this.filter, this.todoList, this.loading, this.user});

  factory TodoListModel.initial() => TodoListModel(loading : true);

}

class TodoListView implements MviView {

  @override
  Future unsubscribe() {
    // TODO: implement unsubscribe
    return null;
  }

}

class TodoListPresenter extends MviPresenter<TodoListModel> {

  

  TodoListPresenter({@required TodoListView view});

  @override
    void setup() {
      
      super.setup();
    }

}