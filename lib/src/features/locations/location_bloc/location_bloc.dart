import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';

import '../../../common/data/my_data.dart';
import '../../../common/models/weather_model.dart';
import '../../../common/service/database_service.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final WeatherFactory wf = WeatherFactory(
    API_KIY,
    language: Language.ENGLISH,
  );

  LocationBloc() : super(LocationLoading()) {
    on<GetLocationEvent>((event, emit) => _onGetAllCities);
  }

  Future<void> _onGetAllCities(
    GetLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    try {
      final List<WeatherModel> allLocation =
          DataBaseService.dataBaseService.getAllLocation();
      final List<Weather> weathers = [];
      print(allLocation);
      for (var i in allLocation) {
        print(i);
        final a = await wf.currentWeatherByLocation(i.latitude!, i.longitude!);
        weathers.add(a);
      }
      emit(LocationSuccess(weathers));
    } catch (_) {
      emit(LocationError("$_"));
    }
  }
}
