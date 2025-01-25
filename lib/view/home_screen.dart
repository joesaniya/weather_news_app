import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_task/provider/News_Provider.dart';
import 'package:weather_task/provider/Weather_Provider.dart';
import 'package:weather_task/utils/Weather-Based-News-Filtering.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchWeatherAndNews();
  }

  Future<void> _fetchWeatherAndNews() async {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);

    try {
      await weatherProvider.getLocation();
      await weatherProvider.fetchWeather(weatherProvider.city);

      if (weatherProvider.weather != null) {
        final description =
            weatherProvider.weather!.forecasts.first.weatherDescription ??
                'clear sky';
        log('Weather desc: $description');
        final keyword = getNewsKeyword(description);
        log('Weather keyword: $keyword');
        await newsProvider.fetchNews(keyword);
      } else {
        log('No weather data available');
      }
    } catch (e) {
      log('Error fetching weather or news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather & News Aggregator'),
      ),
      body: weatherProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : weatherProvider.weather == null
              ? Center(child: Text('Failed to load weather data'))
              : Column(
                  children: [
                    Text(
                      'City: ${weatherProvider.weather!.cityName}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                        'Temperature: ${weatherProvider.weather!.forecasts.first.temperature}°C'),
                    Text(
                        'Condition: ${weatherProvider.weather!.forecasts.first.weatherDescription}'),
                    ElevatedButton(
                      onPressed: () {
                        final keyword = getNewsKeyword(weatherProvider
                            .weather!.forecasts.first.weatherDescription);
                        newsProvider.fetchNews(keyword);
                      },
                      child: Text('Fetch News'),
                    ),
                    newsProvider.isLoading
                        ? CircularProgressIndicator()
                        : Expanded(
                            child: ListView.builder(
                              itemCount: newsProvider.articles.length,
                              itemBuilder: (context, index) {
                                final article = newsProvider.articles[index];
                                return ListTile(
                                  title: Text(article.title),
                                  subtitle: Text(article.description),
                                  onTap: () {},
                                );
                              },
                            ),
                          ),
                  ],
                ),
    );
  }
}
