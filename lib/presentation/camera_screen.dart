import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return new Scaffold(
      appBar: new AppBar(title: new Text('Capture')),
      body: new Transform.scale(
          scale: 1 / controller.value.aspectRatio,
          child: new Center(
            child: new AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: new CameraPreview(controller)),
          )),
    );
  }
}