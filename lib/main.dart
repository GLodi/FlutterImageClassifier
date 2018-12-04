import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'ui/home_screen.dart';
import 'ui/camera_screen.dart';


void main() async {
  cameras = await availableCameras();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}