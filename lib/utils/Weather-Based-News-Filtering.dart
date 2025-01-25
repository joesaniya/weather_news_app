String getNewsKeyword(String weatherDescription) {
  if (weatherDescription.contains('cold')) {
    return 'depressing';
  } else if (weatherDescription.contains('hot')) {
    return 'fear';
  } else if (weatherDescription.contains('cool')) {
    return 'happiness';
  } else if (weatherDescription.contains('overcast clouds')) {
    return 'clouds';
  } else if (weatherDescription.contains('broken clouds')) {
    return 'broken clouds';
  } else if (weatherDescription.contains('clear sky')) {
    return 'clear sky';
  } else if (weatherDescription.contains('scattered clouds')) {
    return 'scattered clouds';
  } else {
    return 'general';
  }
}
