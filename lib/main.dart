import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_image_classifier/pages/home_page.dart';
import 'package:flutter_image_classifier/models/app_state.dart';
import 'package:flutter_image_classifier/reducers/app_reducers.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  String title = 'Flutter Redux';
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
    middleware: [],
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
          title: title,
          theme: new ThemeData.dark(),
          home: new HomePage(title),
      ),
    );
  }
}