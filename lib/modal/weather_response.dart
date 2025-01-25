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
