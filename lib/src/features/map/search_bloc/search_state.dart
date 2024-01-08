part of 'search_bloc.dart';

@immutable
abstract class SearchState with _SearchStatePatternMatcher {
  const SearchState();
}

class SearchInitial extends SearchState {
  final List<WeatherModel> searchLocations;

  const SearchInitial({
    required this.searchLocations,
  });

  @override
  T map<T>({
    required T Function(SearchInitial searchInitial) onSearchInitial,
    required T Function(SearchLoading searchLoading) onSearchLoading,
    required T Function(SearchSuccess searchSuccess) onSearchSuccess,
    required T Function(SearchError searchError) onSearchError,
  }) {
    return onSearchInitial(this);
  }
}

class SearchLoading extends SearchState {
  @override
  T map<T>({
    required T Function(SearchInitial searchInitial) onSearchInitial,
    required T Function(SearchLoading searchLoading) onSearchLoading,
    required T Function(SearchSuccess searchSuccess) onSearchSuccess,
    required T Function(SearchError searchError) onSearchError,
  }) {
    return onSearchLoading(this);
  }
}

class SearchSuccess extends SearchState {
  final List<WeatherModel> searchLocations;

  const SearchSuccess({
    required this.searchLocations,
  });

  @override
  T map<T>({
    required T Function(SearchInitial searchInitial) onSearchInitial,
    required T Function(SearchLoading searchLoading) onSearchLoading,
    required T Function(SearchSuccess searchSuccess) onSearchSuccess,
    required T Function(SearchError searchError) onSearchError,
  }) {
    return onSearchSuccess(this);
  }
}

class SearchError extends SearchState {
  final String errorMessage;

  const SearchError({
    required this.errorMessage,
  });

  @override
  T map<T>({
    required T Function(SearchInitial searchInitial) onSearchInitial,
    required T Function(SearchLoading searchLoading) onSearchLoading,
    required T Function(SearchSuccess searchSuccess) onSearchSuccess,
    required T Function(SearchError searchError) onSearchError,
  }) {
    return onSearchError(this);
  }
}

mixin _SearchStatePatternMatcher {
  T map<T>({
    required T Function(SearchInitial searchInitial) onSearchInitial,
    required T Function(SearchLoading searchLoading) onSearchLoading,
    required T Function(SearchSuccess searchSuccess) onSearchSuccess,
    required T Function(SearchError searchError) onSearchError,
  });
}
