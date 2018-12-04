import 'package:flutter/material.dart';
import 'ui/camera_screen.dart';

void main(){
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: CameraScreen(),
      ),
    );
  }
}