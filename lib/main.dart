import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:camera/camera.dart';

import 'package:flutter_image_classifier/data/data.dart';
import 'package:flutter_image_classifier/domain/domain.dart';
import 'package:flutter_image_classifier/presentation/home_screen.dart';
import 'package:flutter_image_classifier/presentation/camera_screen.dart';

void main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  cameras = await availableCameras();
  final injector = Injector.getInjector();
  injector.map<NetUtils>((i) =>
    new NetUtils(), isSingleton: true);
  injector.map<ApiHelper>((i) =>
    new ApiHelper(i.get<NetUtils>()), isSingleton: true);
  injector.map<DbHelper>((i) =>
    new DbHelper(), isSingleton: true);
  injector.map<CameraManager>((i) =>
    new CameraManager(i.get<ApiHelper>(), i.get<DbHelper>()));
  injector.map<CameraBloc>((i) =>
    new CameraBloc(i.get<CameraManager>()));

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BlocProvider(
          child: HomeScreen(),
          bloc: Injector.getInjector().get<CameraBloc>()
        ),
      ),
    );
  }
}