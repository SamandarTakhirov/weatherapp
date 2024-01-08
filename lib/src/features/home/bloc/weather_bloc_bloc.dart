import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/src/common/models/weather_model.dart';
import '../../../common/data/my_data.dart';
import '../../../common/service/database_service.dart';

part 'weather_bloc_state.dart';

part 'weather_bloc_event.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  final DataBaseService _dataBaseService;
  static final WeatherFactory wf = WeatherFactory(
    API_KIY,
    language: Language.ENGLISH,
  );


  WeatherBlocBloc(this._dataBaseService) : super(WeatherBlocLoading()) {
    on<WeatherBlocEvent>((event, emit) {
      return event.map(
        onStartEvent: (event) => onStartEvent(event, emit),
        onAddLocationEvent: (event) => addLocationEvent(event,emit),
        onChangeLocation: (event) {},
        onRemoveLocationEvent: (event) {},
      );
    });
  }

  Future<void> onStartEvent(
    StartEvent event,
    Emitter<WeatherBlocState> emit,
  ) async {
    try {
      final WeatherModel? weatherModel = _dataBaseService.getCurrentLocation();
      final Weather weather;

      if (weatherModel == null) {
        final Position position = await Geolocator.getCurrentPosition();

        weather = await wf.currentWeatherByLocation(
          position.latitude,
          position.longitude,
        );

        WeatherModel weatherLocation = WeatherModel(
          weather.areaName,
          position.latitude,
          position.longitude,
        );

        await _dataBaseService.addLocation(weatherLocation);
      } else {
        weather = await wf.currentWeatherByLocation(
          weatherModel.latitude!,
          weatherModel.longitude!,
        );
      }
      emit(
        WeatherBlocSuccess(weather),
      );
    } catch (e) {
      emit(WeatherBlocFailure("$e"));
    }
  }

  Future<void> addLocationEvent(
    AddLocationEvent event,
    Emitter<WeatherBlocState> emit,
  ) async {
    try {
      final Weather weather;
      weather = await wf.currentWeatherByLocation(
        event.weather.latitude!,
        event.weather.longitude!,
      );

      await _dataBaseService.addLocation(event.weather);

      await _dataBaseService.setCurrentLocation(event.weather);

      emit(
        WeatherBlocSuccess(weather),
      );
    } catch (e) {
      emit(WeatherBlocFailure("$e"));
    }
  }
}
