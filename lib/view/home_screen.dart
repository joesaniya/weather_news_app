import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_task/provider/News_Provider.dart';
import 'package:weather_task/provider/Weather_Provider.dart';
import 'package:weather_task/utils/Weather-Based-News-Filtering.dart';
import 'package:weather_task/utils/custom_navigation.dart';
import 'package:weather_task/view/settings_screen.dart';

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
      await weatherProvider.fetchWeather(
          weatherProvider.city, weatherProvider.selectedUnit);

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
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Weather & News App',
          style: GoogleFonts.metrophobic(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1,
            color: Colors.white,
            decorationStyle: TextDecorationStyle.solid,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(SettingsScreen()));
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: weatherProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : weatherProvider.weather == null
              ? Center(child: Text('Loading....'))
              : Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/weather_bg.jpg'),
                              fit: BoxFit.cover)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'City: ${weatherProvider.weather!.cityName}',
                                style: GoogleFonts.metrophobic(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                  color: Colors.white,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    final keyword = getNewsKeyword(
                                        weatherProvider.weather!.forecasts.first
                                            .weatherDescription);
                                    newsProvider.fetchNews(keyword);
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          Text(
                            'Temperature: ${weatherProvider.weather!.forecasts.first.temperature}°${weatherProvider.selectedUnit == 'Celsius' ? 'C' : 'F'}',
                            style: GoogleFonts.metrophobic(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1,
                              color: Colors.white,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                          Text(
                            'Condition: ${weatherProvider.weather!.forecasts.first.weatherDescription}',
                            style: GoogleFonts.metrophobic(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1,
                              color: Colors.white,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    newsProvider.isLoading
                        ? CircularProgressIndicator()
                        : Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Breaking News',
                                    style: GoogleFonts.metrophobic(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      color: Colors.black,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: newsProvider.articles.length,
                                      itemBuilder: (context, index) {
                                        final article =
                                            newsProvider.articles[index];
                                        return GestureDetector(
                                          onTap: () {
                                            log('Link:${article.url}');
                                            newsProvider.launchURL(article.url);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 5),
                                            child: Column(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: article.urlToImage,
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                ),
                                                Text(
                                                  article.title,
                                                  style:
                                                      GoogleFonts.metrophobic(
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1,
                                                    color: Colors.black,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .solid,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                ),
                                                Text(
                                                  article.description,
                                                  style:
                                                      GoogleFonts.metrophobic(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1,
                                                    color: Colors.black,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .solid,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
    );
  }
}
