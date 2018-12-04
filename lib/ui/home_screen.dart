import 'package:flutter/material.dart';
import 'package:flutter_image_classifier/blocs/camera_bloc.dart';
import 'package:flutter_image_classifier/ui/camera_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    bloc.fetchWeatherPrediction();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
      ),
      body: StreamBuilder(
        stream: bloc.weatherPrediction,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(snapshot.toString()),
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
          else if (snapshot.hasError) {
            return Center(child: Text("error"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { bloc.fetchWeatherPrediction(); },
        tooltip: "Refresh",
        child: new Icon(Icons.refresh),
      ),
    );
  }

}