/*class WeatherForecast {
  final DateTime dateTime;
  final double temp;

  WeatherForecast({
    required this.dateTime,
    required this.temp,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      dateTime: DateTime.parse(json['dt_txt']),
      temp: json['main']['temp'].toDouble(),
    );
  }
}*/

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
