/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsDatabaseGen {
  const $AssetsDatabaseGen();

  /// File path: assets/database/db.sqlite
  String get db => 'assets/database/db.sqlite';

  /// List of all assets
  List<String> get values => [db];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/fav.png
  AssetGenImage get fav => const AssetGenImage('assets/images/fav.png');

  /// File path: assets/images/homeA.png
  AssetGenImage get homeA => const AssetGenImage('assets/images/homeA.png');

  /// File path: assets/images/information.png
  AssetGenImage get information =>
      const AssetGenImage('assets/images/information.png');

  /// File path: assets/images/logo_main.png
  AssetGenImage get logoMain =>
      const AssetGenImage('assets/images/logo_main.png');

  /// File path: assets/images/search.png
  AssetGenImage get search => const AssetGenImage('assets/images/search.png');

  /// File path: assets/images/settings .png
  AssetGenImage get settings =>
      const AssetGenImage('assets/images/settings .png');

  /// File path: assets/images/splash-hajj.png
  AssetGenImage get splashHajj =>
      const AssetGenImage('assets/images/splash-hajj.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [fav, homeA, information, logoMain, search, settings, splashHajj];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/Animation - 1715784626188.json
  String get animation1715784626188 =>
      'assets/lottie/Animation - 1715784626188.json';

  /// File path: assets/lottie/list.json
  String get list => 'assets/lottie/list.json';

  /// List of all assets
  List<String> get values => [animation1715784626188, list];
}

class Assets {
  Assets._();

  static const $AssetsDatabaseGen database = $AssetsDatabaseGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
