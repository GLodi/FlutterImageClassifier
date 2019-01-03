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
          if (state.isInitialized) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(state.response),
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
          return Center(child: CircularProgressIndicator());
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