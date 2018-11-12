import 'package:flutter/material.dart';
import 'package:flutter_image_classifier/ui/mvp/todolist.dart';
import 'package:flutter_image_classifier/utils/mvicore.dart';

class HomeScreen extends StatefulWidget {
  final MviPresenter<TodoListModel> Function(TodoListView) initPresenter;

  HomeScreen(this.initPresenter);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }

}

class HomeScreenState extends State<HomeScreen> implements TodoListView {
  TodoListPresenter presenter;

  @override
    void didChangeDependencies() {
      if (presenter == null) {
        presenter = widget.initPresenter != null ? 
          widget.initPresenter(this) : 
          TodoListPresenter(
            
          );
        presenter.setup();
      }
      super.didChangeDependencies();
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    );
  }

  @override
  Future unsubscribe() {
    // TODO: implement unsubscribe
    return null;
  }

}