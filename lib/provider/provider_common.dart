import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather_task/provider/News_Provider.dart';
import 'package:weather_task/provider/Weather_Provider.dart';

class ProviderHelperClass {
  static ProviderHelperClass? _instance;

  static ProviderHelperClass get instance {
    _instance ??= ProviderHelperClass();
    return _instance!;
  }

  List<SingleChildWidget> providerLists = [
    ChangeNotifierProvider(create: (context) => WeatherProvider()),
    ChangeNotifierProvider(create: (context) => NewsProvider()),
  ];
}
