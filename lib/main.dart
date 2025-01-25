import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_task/provider/News_Provider.dart';
import 'package:weather_task/provider/Weather_Provider.dart';
import 'package:weather_task/provider/provider_common.dart';
import 'package:weather_task/view/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* return MaterialApp(
      title: 'Weather & News Aggregator',
      
    );*/
    return MultiProvider(
      providers: ProviderHelperClass.instance.providerLists,
      child: MaterialApp(
        title: 'Lost Found App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
