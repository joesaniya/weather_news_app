

class WeatherForecast {
  final double temperature;
  final String weatherDescription;
  final String dateTime;

  WeatherForecast({
    required this.temperature,
    required this.weatherDescription,
    required this.dateTime,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      temperature: json['main']['temp'].toDouble(),
      weatherDescription: json['weather'][0]['description'],
      dateTime: json['dt_txt'],
    );
  }
}
