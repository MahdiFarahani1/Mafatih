import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            Col0: const Color.fromARGB(255, 1, 64, 45),
            Col1: const Color.fromARGB(255, 12, 101, 74),
            Col2: const Color.fromARGB(255, 98, 187, 160),
            Col3: const Color.fromARGB(255, 224, 255, 245)));

  initState(BuildContext context) {
    var val = box.read("mode") ?? true;
    if (val) {
      emit(ThemeState(
          Col0: const Color.fromARGB(255, 1, 64, 45),
          Col1: const Color.fromARGB(255, 12, 101, 74),
          Col2: const Color.fromARGB(255, 98, 187, 160),
          Col3: const Color.fromARGB(255, 224, 255, 245)));
    } else {
      emit(ThemeState(
          Col0: Colors.grey.shade900,
          Col1: Colors.grey.shade700,
          Col2: Colors.grey.shade500,
          Col3: Colors.grey.shade200));
    }
  }

  changeTheme(bool val) {
    if (val) {
      emit(ThemeState(
          Col0: const Color.fromARGB(255, 1, 64, 45),
          Col1: const Color.fromARGB(255, 12, 101, 74),
          Col2: const Color.fromARGB(255, 98, 187, 160),
          Col3: const Color.fromARGB(255, 224, 255, 245)));
    } else {
      emit(ThemeState(
          Col0: Colors.grey.shade900,
          Col1: Colors.grey.shade700,
          Col2: Colors.grey.shade500,
          Col3: Colors.grey.shade200));
    }
  }
}
