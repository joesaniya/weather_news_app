import 'package:weather_task/modal/weather_forecast.dart';


class WeatherResponse {
  final String cityName;
  final String country;
  final List<WeatherForecast> forecasts;

  WeatherResponse({
    required this.cityName,
    required this.country,
    required this.forecasts,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      cityName: json['city']['name'],
      country: json['city']['country'],
      forecasts: (json['list'] as List)
          .map((forecast) => WeatherForecast.fromJson(forecast))
          .toList(),
    );
  }
}
/*
class WeatherResponsee {
  final String cityName;
  final double temperature;
  final String weatherDescription;
  final List<WeatherForecast> forecasts;

  WeatherResponse({
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
    required this.forecasts,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      weatherDescription: json['weather'][0]['description'],
      forecasts: (json['list'] as List)
          .map((forecast) => WeatherForecast.fromJson(forecast))
          .toList(),
    );
  }
}
*/