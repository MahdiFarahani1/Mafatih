import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonIcon {
  static Widget icon(
      {required IconData icon,
      required VoidCallback event,
      required BuildContext context,
      bool? withoutBorder = false}) {
    return GestureDetector(
      onLongPress: () {},
      onTap: () {
        event();
      },
      child: !withoutBorder!
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: BlocProvider.of<ThemeCubit>(context).state.Col0,
                        offset: const Offset(4, 4))
                  ],
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                      color: BlocProvider.of<ThemeCubit>(context).state.Col3),
                  shape: BoxShape.circle),
              child: Icon(
                icon,
                size: 20,
                color: BlocProvider.of<ThemeCubit>(context).state.Col3,
              ),
            )
          : Icon(
              icon,
              size: 20,
              color: BlocProvider.of<ThemeCubit>(context).state.Col3,
            ),
    );
  }
}
