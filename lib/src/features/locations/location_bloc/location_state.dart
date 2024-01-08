part of 'location_bloc.dart';

@immutable
abstract class LocationState with _LocationStatePatternMatcher {
  const LocationState();
}

class LocationLoading extends LocationState {
  @override
  T map<T>({
    required T Function(LocationLoading state) onLocationLoading,
    required T Function(LocationSuccess state) onLocationSuccess,
    required T Function(LocationError state) onLocationError,
  }) {
    return onLocationLoading(this);
  }
}

class LocationSuccess extends LocationState {
  final List<Weather> weather;

  const LocationSuccess(this.weather);

  @override
  T map<T>({
    required T Function(LocationLoading state) onLocationLoading,
    required T Function(LocationSuccess state) onLocationSuccess,
    required T Function(LocationError state) onLocationError,
  }) {
    return onLocationSuccess(this);
  }
}

class LocationError extends LocationState {
  final String errorMessage;

  const LocationError(this.errorMessage);

  @override
  T map<T>({
    required T Function(LocationLoading state) onLocationLoading,
    required T Function(LocationSuccess state) onLocationSuccess,
    required T Function(LocationError state) onLocationError,
  }) {
    return onLocationError(this);
  }
}

mixin _LocationStatePatternMatcher {
  T map<T>({
    required T Function(LocationLoading locationLoading) onLocationLoading,
    required T Function(LocationSuccess locationSuccess) onLocationSuccess,
    required T Function(LocationError locationError) onLocationError,
  });
}
