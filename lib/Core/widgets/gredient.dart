import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomGr {
  static LinearGradient gradient(BuildContext context) {
    return LinearGradient(begin: Alignment.topCenter, colors: [
      BlocProvider.of<ThemeCubit>(context).state.Col0,
      BlocProvider.of<ThemeCubit>(context).state.Col1,
      BlocProvider.of<ThemeCubit>(context).state.Col2,
    ]);
  }

  static LinearGradient gradientLeft(BuildContext context) {
    return LinearGradient(begin: Alignment.topCenter, colors: [
      BlocProvider.of<ThemeCubit>(context).state.Col2,
      BlocProvider.of<ThemeCubit>(context).state.Col1,
      BlocProvider.of<ThemeCubit>(context).state.Col0,
    ]);
  }

  static BoxDecoration dec(BuildContext context) {
    return BoxDecoration(
        border: Border.all(
          color: BlocProvider.of<ThemeCubit>(context).state.Col3,
          width: 2,
        ),
        color: BlocProvider.of<ThemeCubit>(context).state.Col1,
        borderRadius: BorderRadius.circular(4));
  }
}
