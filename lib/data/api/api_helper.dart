import 'dart:async';
import 'package:http/http.dart' show Client;

class ApiHelper {
  Client client = Client();
  final _baseUrl = "http://api.openweathermap.org/data/2.5/weather?q=Milan";
  
  Future<String> fetchWeather() async {
    final response = await client.get(_baseUrl);
    return response.body.toString();
  }
}