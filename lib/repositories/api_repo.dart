import 'package:flutter_image_classifier/repositories/api_provider.dart';

class ApiRepo {
  final _apiProvider = ApiProvider();

  Future<String> fetchWeatherPrediction() => _apiProvider.fetchWeather();
}