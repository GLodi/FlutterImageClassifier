import 'package:rxdart/rxdart.dart';
import 'package:flutter_image_classifier/data/data.dart';

class CameraBloc {
  final _weatherPrediction = PublishSubject<String>();

  Observable<String> get weatherPrediction => _weatherPrediction.stream;

  fetchWeatherPrediction() async {
    final prediction = await _repository.fetchWeatherPrediction();
    _weatherPrediction.sink.add(prediction);
  }

  dispose() {
    _weatherPrediction.close();
  }

}

final bloc = CameraBloc();