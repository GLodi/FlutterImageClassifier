import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'package:flutter_image_classifier/domain/domain.dart';
import 'package:flutter_image_classifier/presentation/camera_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
        parent: _controller,
        curve: new Interval(0, 1, curve: Curves.elasticInOut)
    );
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
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(state.message),
                    RaisedButton(
                      child: Text("Open Camera"),
                      onPressed:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CameraApp()),
                        );
                      },
                    )
                  ],
                ),
              );
            }
            case CameraStateType.notInitialized : {
              return Center(child: CircularProgressIndicator());
            }
            case CameraStateType.error : {
              _controller.forward();
              return Center(
                child: Text(state.message),
              );
            }
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(0, 3),
            end: Offset.zero,
          ).animate(_animation),
          child: FloatingActionButton(
            onPressed: () {
              _controller.reverse();
              bloc.emitEvent(CameraEvent(type: CameraEventType.start));
            },
            tooltip: "Refresh",
            child: new Icon(Icons.refresh),
          ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}