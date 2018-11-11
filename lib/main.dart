import 'package:flutter/material.dart';
import 'package:flutter_image_classifier/repositories/injector.dart';

void main() {
  Injector.configure(RepoType.MOCK);
  runApp(new Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}