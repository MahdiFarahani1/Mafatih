part of 'settings_cubit.dart';

class SettingsState {
  bool isLightMode;
  bool notif;
  double fontSize;
  String fontFamily;
  double valueFontFamily;

  SettingsState({
    this.fontFamily = FontFamily.arabic,
    this.fontSize = 17,
    this.valueFontFamily = 1,
    this.isLightMode = true,
    this.notif = true,
  });

  SettingsState copyWith(
      {bool? isLightMode,
      bool? notif,
      double? fontSize,
      String? fontFamily,
      double? valueFontFamily}) {
    return SettingsState(
        fontFamily: fontFamily ?? this.fontFamily,
        fontSize: fontSize ?? this.fontSize,
        isLightMode: isLightMode ?? this.isLightMode,
        notif: notif ?? this.notif,
        valueFontFamily: valueFontFamily ?? this.valueFontFamily);
  }
}
