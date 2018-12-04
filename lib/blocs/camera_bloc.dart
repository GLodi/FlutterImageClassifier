import 'package:rxdart/rxdart.dart';
import 'package:flutter_image_classifier/repositories/api_repo.dart';

class CameraBloc {
  final _repository = ApiRepo();
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