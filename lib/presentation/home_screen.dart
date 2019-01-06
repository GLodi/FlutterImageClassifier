import 'package:flutter/material.dart';

import 'package:flutter_image_classifier/domain/domain.dart';
import 'package:flutter_image_classifier/presentation/camera_screen.dart';

class HomeScreen extends StatelessWidget {
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
              return Center(
                child: Text(state.message),
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { bloc.emitEvent(CameraEvent(type: CameraEventType.start)); },
        tooltip: "Refresh",
        child: new Icon(Icons.refresh),
      ),
    );
  }

}