import 'package:flutter/material.dart';

import 'package:flutter_image_classifier/domain/blocs/camera_bloc.dart';
import 'package:flutter_image_classifier/domain/blocs/bloc_provider.dart';
import 'package:flutter_image_classifier/presentation/camera_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CameraBloc bloc = BlocProvider.of<CameraBloc>(context);

    return Scaffold(
      body: StreamBuilder<String>(
        stream: bloc.availability,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(snapshot.data.toString()),
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
        onPressed: () { bloc.fetchAvailability.add(0); },
        tooltip: "Refresh",
        child: new Icon(Icons.refresh),
      ),
    );
  }

}