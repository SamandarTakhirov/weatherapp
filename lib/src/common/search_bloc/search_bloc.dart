import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/src/common/service/database_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../models/weather_model.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchLoading()) {
    on<SearchLocationEvent>(
      _onSearchLocationEvent,
      transformer: sequential(),
    );
    on<SearchFromStorageEvent>(
      _onSearchFromStorageEvent,
      transformer: sequential(),
    );
  }

  Future<void> _onSearchLocationEvent(
    SearchLocationEvent event,
    Emitter<SearchState> emit,
  ) async {
    try {
      final resultWithSession = YandexSearch.searchByText(
        searchText: event.query,
        geometry: Geometry.fromBoundingBox(
          const BoundingBox(
            southWest: Point(
              latitude: 55.76996383933034,
              longitude: 37.57483142322235,
            ),
            northEast: Point(
              latitude: 55.785322774728414,
              longitude: 37.590924677311705,
            ),
          ),
        ),
        searchOptions: const SearchOptions(
          geometry: false,
          searchType: SearchType.geo,
          resultPageSize: 5,
        ),
      );

      final result = await resultWithSession.result;

      if (result.error == null) {
        final listResult = result.items!
            .map(
              (e) => WeatherModel(
                e.name,
                e.toponymMetadata!.balloonPoint.latitude,
                e.toponymMetadata!.balloonPoint.longitude,
              ),
            )
            .toList();
        emit(
          SearchSuccess(
            searchLocations: listResult.toSet(),
          ),
        );
      }
    } catch (_) {
      emit(SearchError(errorMessage: "$_"));
    }
  }

  Future<void> _onSearchFromStorageEvent(
    SearchFromStorageEvent event,
    Emitter<SearchState> emit,
  ) async {
    final data = DataBaseService.dataBaseService.getLastLocation();
    emit(
      SearchInitial(
        searchLocations: data,
      ),
    );
  }
}
