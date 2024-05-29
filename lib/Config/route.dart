import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Home/presentation/bloc/bloc/audio_home_bloc.dart';
import 'package:flutter_application_1/Features/Home/presentation/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as tr;
import 'package:get/get_core/src/get_main.dart';

class GetRoute {
  static route(dynamic route, {dynamic arg, required BuildContext context}) {
    if (route.runtimeType == MyHomePage) {
      BlocProvider.of<AudioHomeBloc>(context).add(PlayAudio());
    } else {
      BlocProvider.of<AudioHomeBloc>(context).add(DisposAudio());
    }
    Get.to(route, transition: tr.Transition.cupertino, arguments: arg);
  }
}
