/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/back.svg
  SvgGenImage get back => const SvgGenImage('assets/icons/back.svg');

  /// File path: assets/icons/claim.png
  AssetGenImage get claimPng => const AssetGenImage('assets/icons/claim.png');

  /// File path: assets/icons/claim.svg
  SvgGenImage get claimSvg => const SvgGenImage('assets/icons/claim.svg');

  /// File path: assets/icons/confirm_email.svg
  SvgGenImage get confirmEmail =>
      const SvgGenImage('assets/icons/confirm_email.svg');

  /// File path: assets/icons/datetime.svg
  SvgGenImage get datetime => const SvgGenImage('assets/icons/datetime.svg');

  /// File path: assets/icons/door.svg
  SvgGenImage get door => const SvgGenImage('assets/icons/door.svg');

  /// File path: assets/icons/email.svg
  SvgGenImage get email => const SvgGenImage('assets/icons/email.svg');

  /// File path: assets/icons/eye.svg
  SvgGenImage get eye => const SvgGenImage('assets/icons/eye.svg');

  /// File path: assets/icons/image_upload.svg
  SvgGenImage get imageUpload =>
      const SvgGenImage('assets/icons/image_upload.svg');

  /// File path: assets/icons/location.svg
  SvgGenImage get location => const SvgGenImage('assets/icons/location.svg');

  /// File path: assets/icons/location1.svg
  SvgGenImage get location1 => const SvgGenImage('assets/icons/location1.svg');

  /// File path: assets/icons/name.svg
  SvgGenImage get name => const SvgGenImage('assets/icons/name.svg');

  /// File path: assets/icons/password.png
  AssetGenImage get passwordPng =>
      const AssetGenImage('assets/icons/password.png');

  /// File path: assets/icons/password.svg
  SvgGenImage get passwordSvg => const SvgGenImage('assets/icons/password.svg');

  /// File path: assets/icons/pound.svg
  SvgGenImage get pound => const SvgGenImage('assets/icons/pound.svg');

  /// File path: assets/icons/service.svg
  SvgGenImage get service => const SvgGenImage('assets/icons/service.svg');

  /// File path: assets/icons/signin.png
  AssetGenImage get signin => const AssetGenImage('assets/icons/signin.png');

  /// File path: assets/icons/signup.png
  AssetGenImage get signup => const AssetGenImage('assets/icons/signup.png');

  /// File path: assets/icons/success.svg
  SvgGenImage get success => const SvgGenImage('assets/icons/success.svg');

  /// File path: assets/icons/time.svg
  SvgGenImage get time => const SvgGenImage('assets/icons/time.svg');

  /// File path: assets/icons/upload_receipt.svg
  SvgGenImage get uploadReceipt =>
      const SvgGenImage('assets/icons/upload_receipt.svg');

  /// List of all assets
  List<dynamic> get values => [
        back,
        claimPng,
        claimSvg,
        confirmEmail,
        datetime,
        door,
        email,
        eye,
        imageUpload,
        location,
        location1,
        name,
        passwordPng,
        passwordSvg,
        pound,
        service,
        signin,
        signup,
        success,
        time,
        uploadReceipt
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/discount.png
  AssetGenImage get discount =>
      const AssetGenImage('assets/images/discount.png');

  /// File path: assets/images/gym.png
  AssetGenImage get gym => const AssetGenImage('assets/images/gym.png');

  /// File path: assets/images/gymboygirl.png
  AssetGenImage get gymboygirl =>
      const AssetGenImage('assets/images/gymboygirl.png');

  /// File path: assets/images/image_demo.png
  AssetGenImage get imageDemo =>
      const AssetGenImage('assets/images/image_demo.png');

  /// File path: assets/images/image_demo1.png
  AssetGenImage get imageDemo1 =>
      const AssetGenImage('assets/images/image_demo1.png');

  /// File path: assets/images/line.png
  AssetGenImage get line => const AssetGenImage('assets/images/line.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo5.png
  AssetGenImage get logo5 => const AssetGenImage('assets/images/logo5.png');

  /// File path: assets/images/profile.png
  AssetGenImage get profile => const AssetGenImage('assets/images/profile.png');

  /// File path: assets/images/service.png
  AssetGenImage get service => const AssetGenImage('assets/images/service.png');

  /// File path: assets/images/splash_screen.jpg
  AssetGenImage get splashScreen =>
      const AssetGenImage('assets/images/splash_screen.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        discount,
        gym,
        gymboygirl,
        imageDemo,
        imageDemo1,
        line,
        logo,
        logo5,
        profile,
        service,
        splashScreen
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
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

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
