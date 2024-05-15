part of 'search_cubit.dart';

class SearchState {
  final SearchStatus status;
  List<dynamic>? data;

  SearchState({
    required this.status,
    this.data,
  });
}

abstract class SearchStatus {}

class Init extends SearchStatus {}

class SearchData extends SearchStatus {}

class Error extends SearchStatus {}

class Loading extends SearchStatus {}
