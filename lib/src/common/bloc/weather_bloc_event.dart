part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocEvent extends Equatable
    with _WeatherEventPatternMatcher {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

class AddLocationEvent extends WeatherBlocEvent {
  final WeatherModel weather;

  const AddLocationEvent(this.weather);

  @override
  T map<T>({
    required T Function(StartEvent event) onStartEvent,
    required T Function(AddLocationEvent event) onAddLocationEvent,
    required T Function(ChangeLocation event) onChangeLocation,
    required T Function(RemoveLocationEvent event) onRemoveLocationEvent,
  }) {
    return onAddLocationEvent(this);
  }
}

class StartEvent extends WeatherBlocEvent {
  @override
  T map<T>({
    required T Function(StartEvent event) onStartEvent,
    required T Function(AddLocationEvent event) onAddLocationEvent,
    required T Function(ChangeLocation event) onChangeLocation,
    required T Function(RemoveLocationEvent event) onRemoveLocationEvent,
  }) {
    return onStartEvent(this);
  }
}

class ChangeLocation extends WeatherBlocEvent {
  final WeatherModel weather;

  const ChangeLocation(this.weather);

  @override
  T map<T>({
    required T Function(StartEvent event) onStartEvent,
    required T Function(AddLocationEvent event) onAddLocationEvent,
    required T Function(ChangeLocation event) onChangeLocation,
    required T Function(RemoveLocationEvent event) onRemoveLocationEvent,
  }) {
    return onChangeLocation(this);
  }
}

class RemoveLocationEvent extends WeatherBlocEvent {
  final WeatherModel weather;

  const RemoveLocationEvent(this.weather);

  @override
  T map<T>({
    required T Function(StartEvent event) onStartEvent,
    required T Function(AddLocationEvent event) onAddLocationEvent,
    required T Function(ChangeLocation event) onChangeLocation,
    required T Function(RemoveLocationEvent event) onRemoveLocationEvent,
  }) {
    return onRemoveLocationEvent(this);
  }
}

mixin _WeatherEventPatternMatcher {
  T map<T>({
    required T Function(StartEvent event) onStartEvent,
    required T Function(AddLocationEvent event) onAddLocationEvent,
    required T Function(ChangeLocation event) onChangeLocation,
    required T Function(RemoveLocationEvent event) onRemoveLocationEvent,
  });
}
