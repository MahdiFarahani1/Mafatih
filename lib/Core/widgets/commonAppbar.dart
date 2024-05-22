import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/route.dart';
import 'package:flutter_application_1/Core/widgets/gredient.dart';
import 'package:flutter_application_1/Features/Click_article/repository/name_cat.dart';
import 'package:flutter_application_1/Features/Home/presentation/home.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonAppbar {
  static AppBar appbar(bool isNormalMode, BuildContext context) {
    return isNormalMode
        ? AppBar(
            flexibleSpace: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topCenter, colors: [
                    state.Col0,
                    state.Col1,
                    state.Col2,
                  ])),
                );
              },
            ),
            actions: [
              GestureDetector(
                  onTap: () {
                    GetRoute.route(const MyHomePage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.home_outlined,
                      size: 31,
                      color: BlocProvider.of<ThemeCubit>(context).state.Col3,
                    ),
                  )),
            ],
          )
        : AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: CustomGr.gradient(context)),
            ),
            title: Text(
              NameCat.nameCategory,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      GetRoute.route(const MyHomePage());
                    },
                    child: Icon(
                      Icons.home_outlined,
                      size: 31,
                      color: BlocProvider.of<ThemeCubit>(context).state.Col3,
                    )),
              ),
            ],
            centerTitle: true,
          );
  }
}
