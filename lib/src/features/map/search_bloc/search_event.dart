part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

class SearchLocationEvent extends SearchEvent {
  final String query;

  const SearchLocationEvent({
    required this.query,
  });
}

class SearchFromStorageEvent extends SearchEvent {
  const SearchFromStorageEvent();
}
