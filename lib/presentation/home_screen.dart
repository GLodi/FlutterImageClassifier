import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_image_classifier/domain/domain.dart';

List<CameraDescription> cameras;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  CameraBloc bloc;
  AnimationController _fabAnimCont, _cameraAnimCont;
  Animation _fabAnim, _cameraAnim;
  CameraController _cameraController;

  @override
  void initState() {
    super.initState();

    // FAB animation
    _fabAnimCont = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fabAnim = CurvedAnimation(
      parent: _fabAnimCont,
      curve: Curves.elasticInOut,
    );

    // Camera container animation
    _cameraAnimCont = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
    );
    _cameraAnim = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _cameraAnimCont,
      curve: Curves.fastOutSlowIn,
    ));

    // Camera controller
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    _cameraController.initialize().then((_) {
      if (!mounted) { return; }
      setState(() {});
    });

    bloc = BlocProvider.of<CameraBloc>(context);
    bloc.setup();
    bloc.emitEvent(CameraEvent(type: CameraEventType.start));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocEventStateBuilder<CameraEvent, CameraState>(
        bloc: bloc,
        builder: (context, state) {
          switch (state.type) {
            case CameraStateType.initialized : {
              return initializedScreen();
            }
            case CameraStateType.notInitialized : {
              return Center(child: CircularProgressIndicator());
            }
            case CameraStateType.error : {
              _fabAnimCont.forward();
              return Center(
                child: Text(
                  state.message,
                  style: new TextStyle(
                    color: Theme.of(context).hintColor,
                    fontFamily: "Roboto",
                    fontSize: 20.0,
                  ),
                ),
              );
            }
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0, 3),
          end: const Offset(0, -0.5),
        ).animate(_fabAnim),
        child: FloatingActionButton(
          onPressed: () {
            _fabAnimCont.reverse();
            bloc.emitEvent(CameraEvent(type: CameraEventType.start));
          },
          tooltip: "Refresh",
          child: new Icon(Icons.refresh),
        ),
      ),
    );
  }

  Widget initializedScreen() {
    _cameraAnimCont.forward();
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _cameraAnimCont,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(_cameraAnim.value * width, 0, 0),
          child: new Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new AspectRatio(
                  aspectRatio: 3/4,
                  child: new CameraPreview(_cameraController),
                ),
                StreamBuilder<String> (
                  stream: bloc.prediction,
                  initialData: "Prediction",
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data,
                      style: new TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Roboto",
                        fontSize: 20.0,
                      ),
                    );
                  },
                ),
                new Align(
                  child: RaisedButton(
                    child: new IconButton(
                      iconSize: 48,
                      icon: const Icon(Icons.camera_alt),
                    ),
                    color: Theme.of(context).backgroundColor,
                    onPressed: () {
                      takePicture();
                    },
                  ),
                ),
              ],
            ),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
              boxShadow: [new BoxShadow(
                color: Colors.black,
                blurRadius: 20.0,
              ),]
            ),
          ),
        );
      }
    );
  }

  Future<String> takePicture() async {
    if (!_cameraController.value.isInitialized) {
      //showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (_cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await _cameraController.takePicture(filePath);
      bloc.takePhoto.add(filePath);
    } on CameraException catch (e) {
      //_showCameraException(e);
      return null;
    }
    return filePath;
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void dispose() {
    _fabAnimCont.dispose();
    _cameraAnimCont.dispose();
    super.dispose();
  }

}