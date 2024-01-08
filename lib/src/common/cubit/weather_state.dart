part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {
  final List<PlacemarkMapObject> mapObjects;

  const WeatherState({
    this.mapObjects = const [],
  });
}

class WeatherSuccess extends WeatherState {
  const WeatherSuccess({
    super.mapObjects,
  });
}
