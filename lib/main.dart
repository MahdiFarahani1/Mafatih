import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Features/Click_article/presentations/bloc/audio/audio_cubit.dart';
import 'package:flutter_application_1/Features/Search/presentations/cubit/search_cubit.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/setting/settings_cubit.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
import 'package:flutter_application_1/Features/Splash/Splash.dart';
import 'package:flutter_application_1/gen/fonts.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();
void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsCubit(),
          ),
          BlocProvider(
            create: (context) => SearchCubit(),
          ),
          BlocProvider(
            create: (context) => AudioCubit(),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
          // BlocProvider(
          //   create: (context) => AudioLoadingCubit(),
          // ),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(
                          color:
                              BlocProvider.of<ThemeCubit>(context).state.Col3),
                      titleTextStyle: TextStyle(
                          color:
                              BlocProvider.of<ThemeCubit>(context).state.Col3)),
                  fontFamily: FontFamily.arabic,
                  primaryColor: BlocProvider.of<ThemeCubit>(context).state.Col1,
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                  textTheme: const TextTheme()),
              home: const Splash(),
            );
          },
        ));
  }
}
