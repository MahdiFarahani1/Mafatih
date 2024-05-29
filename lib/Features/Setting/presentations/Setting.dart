import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/widgets/commonAppbar.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/setting/settings_cubit.dart';
import 'package:flutter_application_1/Features/Setting/presentations/bloc/theme/cubit/theme_cubit.dart';
import 'package:flutter_application_1/Features/Setting/widgets/base.dart';
import 'package:flutter_application_1/gen/fonts.gen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar.appbar(true, context),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Column(
            children: [
              fontFamily(context, state.valueFontFamily),
              fontSize(context, state.fontSize),
              darkMode(context, state.isLightMode),
              const Spacer(),
              Card(
                color: BlocProvider.of<ThemeCubit>(context).state.Col1,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    "الاصدار: 1.7",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  ItemSetting fontFamily(BuildContext context, double val) {
    return ItemSetting(
        icon: Icons.font_download,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: SliderTheme(
                data: const SliderThemeData(
                  activeTrackColor: Colors.white,
                  trackHeight: 1,
                  inactiveTrackColor: Color.fromRGBO(158, 158, 158, 1),
                  thumbColor: Colors.white,
                  inactiveTickMarkColor: Colors.grey,
                  activeTickMarkColor: Colors.transparent,
                ),
                child: Slider(
                  divisions: 2,
                  value: val,
                  min: 0,
                  max: 2,
                  onChanged: (value) {
                    BlocProvider.of<SettingsCubit>(context)
                        .changeFontValueState(value);

                    switch (value) {
                      case 0:
                        BlocProvider.of<SettingsCubit>(context)
                            .changeFontFamilyState(FontFamily.salamat);
                        break;
                      case 1:
                        BlocProvider.of<SettingsCubit>(context)
                            .changeFontFamilyState(FontFamily.arabic);
                        break;
                      case 2:
                        BlocProvider.of<SettingsCubit>(context)
                            .changeFontFamilyState(FontFamily.trajan);
                        break;
                      default:
                    }
                    // saveAll.put("fontFamily", value);
                  },
                ),
              ),
            ),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: state.fontFamily),
                  ),
                );
              },
            ),
          ],
        ));
  }

  ItemSetting fontSize(BuildContext context, double val) {
    return ItemSetting(
      icon: Icons.text_fields,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: Colors.white,
                trackHeight: 1,
                inactiveTrackColor: Color.fromRGBO(158, 158, 158, 1),
                thumbColor: Colors.white,
                inactiveTickMarkColor: Colors.grey,
                activeTickMarkColor: Colors.transparent,
                valueIndicatorColor: Theme.of(context).primaryColor,
              ),
              child: Slider(
                label: val.toInt().toString(),
                divisions: 15,
                value: val,
                min: 10,
                max: 25,
                onChanged: (value) {
                  BlocProvider.of<SettingsCubit>(context)
                      .changeFontSizeState(value);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              "بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ",
              style: TextStyle(fontSize: val, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  ItemSetting darkMode(BuildContext context, bool val) {
    return ItemSetting(
        icon: Icons.color_lens,
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "داكن",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  decoration:
                      !val ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Switch(
                  activeTrackColor: Theme.of(context).primaryColor,
                  value: val,
                  onChanged: (value) {
                    BlocProvider.of<SettingsCubit>(context)
                        .changeisDarkState(value);
                    BlocProvider.of<ThemeCubit>(context).changeTheme(value);
                    box.write("mode", value);
                  },
                ),
              ),
              Text(
                "فاتح",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    decorationColor: Colors.white,
                    decoration:
                        val ? TextDecoration.underline : TextDecoration.none),
              ),
            ],
          ),
        ));
  }
}
