part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocState extends Equatable
    with _WeatherStatePatternMatcher {
  const WeatherBlocState();

  @override
  List<Object> get props => [];

}

final class WeatherBlocLoading extends WeatherBlocState {
  @override
  T map<T>({
    required T Function(WeatherBlocLoading state) onWeatherBlocLoading,
    required T Function(WeatherBlocFailure state) onWeatherBlocFailure,
    required T Function(WeatherBlocSuccess state) onWeatherBlocSuccess,
  }) {
    return onWeatherBlocLoading(this);
  }
}

final class WeatherBlocFailure extends WeatherBlocState {
  final String errorMessage;

  const WeatherBlocFailure(this.errorMessage);

  @override
  T map<T>({
    required T Function(WeatherBlocLoading state) onWeatherBlocLoading,
    required T Function(WeatherBlocFailure state) onWeatherBlocFailure,
    required T Function(WeatherBlocSuccess state) onWeatherBlocSuccess,
  }) {
    return onWeatherBlocFailure(this);
  }
}

final class WeatherBlocSuccess extends WeatherBlocState {
  final Weather weather;

  const WeatherBlocSuccess(this.weather);

  @override
  List<Object> get props => [weather];

  @override
  T map<T>({
    required T Function(WeatherBlocLoading state) onWeatherBlocLoading,
    required T Function(WeatherBlocFailure state) onWeatherBlocFailure,
    required T Function(WeatherBlocSuccess state) onWeatherBlocSuccess,
  }) {
    return onWeatherBlocSuccess(this);
  }
}

mixin _WeatherStatePatternMatcher {
  T map<T>({
    required T Function(WeatherBlocLoading state) onWeatherBlocLoading,
    required T Function(WeatherBlocFailure state) onWeatherBlocFailure,
    required T Function(WeatherBlocSuccess state) onWeatherBlocSuccess,
  });
}
