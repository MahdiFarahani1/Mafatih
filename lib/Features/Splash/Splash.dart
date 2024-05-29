import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Features/Home/presentation/bloc/bloc/audio_home_bloc.dart';
import 'package:flutter_application_1/Features/Home/presentation/home.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/setting/settings_cubit.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as tr;

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    BlocProvider.of<SettingsCubit>(context).initState(context);
    BlocProvider.of<ThemeCubit>(context).initState(context);

    Future.delayed(
      const Duration(seconds: 2),
      () {
        Get.offAll(const MyHomePage(),
            popGesture: false, transition: tr.Transition.zoom);
        BlocProvider.of<AudioHomeBloc>(context).add(PlayAudio());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: EsaySize.width(context),
      height: EsaySize.height(context),
      child: Assets.images.splashHajj.image(fit: BoxFit.cover),
    );
  }
}
