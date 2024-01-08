import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/src/common/models/weather_model.dart';

class DataBaseService {
  final SharedPreferences _sharedPreferences;
  static const String currentLocation = "location";
  static const String allLocation = "allLocation";
  static const String allLastLocation = "allLastLocation";
  static List<WeatherModel> weathers = [];
  static List<WeatherModel> lastWeathers = [];
  static late final DataBaseService dataBaseService;

  DataBaseService._(this._sharedPreferences);

  static Future<DataBaseService> create() async {
    final storage = await SharedPreferences.getInstance();
    dataBaseService = DataBaseService._(storage);

    return dataBaseService;
  }

  WeatherModel? getCurrentLocation() {
    final location = _sharedPreferences.getString(currentLocation);
    return location != null
        ? WeatherModel.fromJson(
            jsonDecode(location),
          )
        : null;
  }

  Future<void> setCurrentLocation(WeatherModel weatherModel) async {
    await _sharedPreferences.setString(
      currentLocation,
      jsonEncode(
        weatherModel.toJson(),
      ),
    );
  }

  List<WeatherModel> getAllLocation() {
    final getAllDate = _sharedPreferences.getString(allLocation) ?? "[]";
    weathers = (jsonDecode(getAllDate) as List)
        .map(
          (e) => WeatherModel.fromJson(e),
        )
        .toList();
    return weathers;
  }

  Future<void> addLocation(WeatherModel weatherModel) async {
    weathers.add(weatherModel);
    _setAllLocation(weathers);
  }

  Future<void> removeLocation(WeatherModel weatherModel) async {
    weathers.remove(weatherModel);
    await _setAllLocation(weathers);
  }

  Future<void> _setAllLocation(List<WeatherModel> weathers) async {
    await _sharedPreferences.setString(
      allLocation,
      jsonEncode(
        weathers
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      ),
    );
  }

  Future<void> addLastLocation(WeatherModel weatherModel) async {
    lastWeathers.add(weatherModel);
    _setLastLocation(lastWeathers);
  }

  Set<WeatherModel> getLastLocation() {
    final getAllDate = _sharedPreferences.getString(allLastLocation) ?? "[]";
    lastWeathers = (jsonDecode(getAllDate) as List)
        .map(
          (e) => WeatherModel.fromJson(e),
        )
        .toList();
    return lastWeathers.toSet();
  }

  Future<void> _setLastLocation(List<WeatherModel> weathers) async {
    await _sharedPreferences.setString(
      allLastLocation,
      jsonEncode(
        lastWeathers
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      ),
    );
  }
}
