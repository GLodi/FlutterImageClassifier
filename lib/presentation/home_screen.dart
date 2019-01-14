import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:camera/camera.dart';

import 'package:flutter_image_classifier/domain/domain.dart';
import 'package:flutter_image_classifier/presentation/camera_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
    _cameraAnimCont =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

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

    _cameraAnimCont.forward();
  }

  @override
  Widget build(BuildContext context) {
    CameraBloc bloc = BlocProvider.of<CameraBloc>(context);
    bloc.emitEvent(CameraEvent(type: CameraEventType.start));

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
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _cameraAnimCont,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(_cameraAnim.value * width, 0, 0),
          child: new Container(
            child: new Column(
              children: <Widget>[
                new AspectRatio(
                  aspectRatio: 3/4,
                  child: new CameraPreview(_cameraController),
                ),
                new RaisedButton(
                  onPressed:null,
                ),
              ],
            ),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
            ),
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    _fabAnimCont.dispose();
    _cameraAnimCont.dispose();
    super.dispose();
  }

}