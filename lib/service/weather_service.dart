import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:weather_task/modal/weather_response.dart';
import 'package:weather_task/utils/api_key.dart'; 

class WeatherService {
  String _apiKey = Weather_API_key; 
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
   Future<WeatherResponse?> fetchWeather(String city, String unit) async {
    
    final units = unit == 'Celsius' ? 'metric' : 'imperial';
    
    final url = '$_baseUrl/forecast?q=$city&units=$units&appid=$_apiKey';
    log('Fetching weather data with URL: $url');

    try {
      final response = await http.get(Uri.parse(url));

      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        log('Weather Response Data: $data');

        if (data != null && data['city'] != null && data['list'] != null) {
          return WeatherResponse.fromJson(data); 
        } else {
          log('Error: Missing required fields in the response data');
          return null;
        }
      } else {
        log('Error: API call failed with status code ${response.statusCode}');
        throw Exception('Failed to fetch weather data: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: Failed to fetch weather data - $e');
      return null;
    }
  }

  Future<WeatherResponse?> fetchWeatherr(String city) async {
    final url = '$_baseUrl/forecast?q=$city&units=metric&appid=$_apiKey';
    log('Fetching weather data with URL: $url');

    try {
      final response = await http.get(Uri.parse(url));


      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        log('Weather Response Data: $data');


        if (data != null && data['city'] != null && data['list'] != null) {
          return WeatherResponse.fromJson(
              data); 
        } else {
          log('Error: Missing required fields in the response data');
          return null;
        }
      } else {
        log('Error: API call failed with status code ${response.statusCode}');
        throw Exception('Failed to fetch weather data: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: Failed to fetch weather data - $e');
      return null;
    }
  }
}
