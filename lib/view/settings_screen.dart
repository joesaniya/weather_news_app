import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Settings',
          style: GoogleFonts.metrophobic(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1,
            color: Colors.white,
            decorationStyle: TextDecorationStyle.solid,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Temperature Unit: ',
                  style: GoogleFonts.metrophobic(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1,
                    color: Colors.black,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
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
                      child: Text(
                        value,
                        style: GoogleFonts.metrophobic(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          color: Colors.black,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              'Select News Categories:',
              style: GoogleFonts.metrophobic(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1,
                color: Colors.black,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
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

                    log('Catenews:${newsProvider.selectedCategories}');
                    /*    final keyword = getNewsKeyword(weatherProvider
                        .weather!.forecasts.first.weatherDescription);*/
                    final keyword = newsProvider.selectedCategories[0];
                    newsProvider.fetchNews(keyword);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: newsProvider.selectedCategories.contains(category)
                          ? Colors.blueGrey
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
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        decorationStyle: TextDecorationStyle.solid,
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
