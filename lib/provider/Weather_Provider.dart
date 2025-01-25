import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_task/modal/weather_response.dart';
import 'package:weather_task/service/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherResponse? weather;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _location = 'Getting location...';
  String city = 'Fetching city...';

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

   
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _location = 'Location services are disabled';
      notifyListeners();
      return;
    }

    
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _location = 'Location permission denied';
        notifyListeners();
        return;
      }
    }


    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

   
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    _location =
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    city = place.locality ?? 'City not found'; 
    log('City: $city');
    notifyListeners();
  }

  Future<void> fetchWeather(String city) async {
    log('Fetching weather for city: $city');
    if (city.isEmpty) {
      throw Exception("City cannot be empty.");
    }

    _isLoading = true;
    notifyListeners(); 

    try {
      weather = await WeatherService().fetchWeather(city); 
      log('Weather fetched: $weather');
      notifyListeners(); 
    } catch (e) {
      weather = null; 
      log('Error fetching weather: $e');
      rethrow; 
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }

  
}
