import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_task/provider/News_Provider.dart';
import 'package:weather_task/provider/Weather_Provider.dart';
import 'package:weather_task/utils/Weather-Based-News-Filtering.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('Temperature Unit: '),
                DropdownButton<String>(
                  value: weatherProvider.unit,
                  onChanged: (String? newUnit) {
                    weatherProvider.setUnit(newUnit!);
                    weatherProvider.fetchWeather(
                        weatherProvider.city, weatherProvider.selectedUnit);
                  },
                  items: <String>['Celsius', 'Fahrenheit']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Select News Categories:'),
            Wrap(
              children: <String>[
                'Business',
                'Technology',
                'Health',
                'Entertainment',
                'Sports',
              ].map((category) {
                return GestureDetector(
                  onTap: () {
                    newsProvider.toggleCategory(category);

                    final keyword = getNewsKeyword(weatherProvider
                        .weather!.forecasts.first.weatherDescription);
                    newsProvider.fetchNews(keyword);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: newsProvider.selectedCategories.contains(category)
                          ? Colors.blue
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color:
                            newsProvider.selectedCategories.contains(category)
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
