import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/string_utils.dart';
import '../view/progress_indicator.dart';
import 'app_error_image.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.imageURL,
    this.width = AppDimens.imageWidth,
    this.height = AppDimens.imageHeight,
    this.fit = BoxFit.cover,
    this.borderRadius = AppDimens.imageRadius,
    this.color,
  });

  const AppImage.square({
    super.key,
    this.imageURL,
    double? size = AppDimens.imageSize,
    this.fit = BoxFit.cover,
    this.borderRadius = AppDimens.imageRadius,
    this.color,
  })  : width = size,
        height = size;

  final String? imageURL;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadiusGeometry borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (imageURL == null || !StringUtils.isURL(imageURL!)) {
      return AppErrorImage(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );
    }

    return ClipRRect(
        borderRadius: borderRadius,
        child: ColoredBox(
          color: context.appColors.imageBackground,
          child: CachedNetworkImage(
            imageUrl: imageURL!,
            width: width,
            height: height,
            fit: fit,
            progressIndicatorBuilder: (_, __, DownloadProgress progress) => AppCircularProgressIndicator(
              progress: progress.progress,
            ),
            errorWidget: (_, __, ___) => AppErrorImage(
              width: width,
              height: height,
              borderRadius: borderRadius,
            ),
          ),
        ));
  }

  static Widget file(
    String? imagePath, {
    double? width = AppDimens.imageWidth,
    double? height = AppDimens.imageHeight,
    BoxFit? fit = BoxFit.cover,
    Color? color,
    BorderRadiusGeometry borderRadius = AppDimens.imageRadius,
  }) {
    if (imagePath == null || imagePath.isEmpty) {
      return AppErrorImage(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.file(
        File(imagePath),
        fit: fit,
        width: width,
        height: height,
      ),
    );
  }

  static Widget asset(
    String? imageName, {
    double? width = AppDimens.imageWidth,
    double? height = AppDimens.imageHeight,
    BoxFit? fit = BoxFit.cover,
    BorderRadiusGeometry borderRadius = AppDimens.imageRadius,
    Color? color,
  }) {
    const BorderRadius.all(Radius.circular(12));
    if (imageName == null || imageName.isEmpty) {
      return AppErrorImage(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        imageName,
        fit: fit,
        width: width,
        height: height,
        color: color,
      ),
    );
  }

  static Widget memory(
    Uint8List? bytes, {
    double? width = AppDimens.imageWidth,
    double? height = AppDimens.imageHeight,
    BoxFit? fit = BoxFit.cover,
    BorderRadiusGeometry borderRadius = AppDimens.imageRadius,
    Color? color,
  }) {
    const BorderRadius.all(Radius.circular(12));
    if (bytes == null || bytes.isEmpty) {
      return AppErrorImage(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.memory(
        bytes,
        fit: fit,
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
