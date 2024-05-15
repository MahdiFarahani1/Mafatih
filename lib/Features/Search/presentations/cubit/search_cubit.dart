import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/Core/database/db_helper.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState(status: Init()));

  init() {
    emit(SearchState(status: Init()));
  }

  searchData(String query) {
    emit(SearchState(status: Loading()));
    DBhelper dBhelper = DBhelper();
    dBhelper.getSearch(query).then((value) {
      if (value.isEmpty) {
        emit(SearchState(status: Error()));
      } else {
        emit(SearchState(
          status: SearchData(),
          data: value,
        ));
      }
    }).catchError((error) {
      emit(SearchState(status: Error()));
    });
  }
}
