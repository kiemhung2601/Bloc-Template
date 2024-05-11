import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../utils/string_utils.dart';
import '../view/progress_indicator.dart';
import 'app_error_image.dart';

class AppRoundedImage extends StatelessWidget {
  const AppRoundedImage({
    super.key,
    this.size = AppDimens.imageSize,
    this.imageURL,
    this.border,
    this.errorImage,
  });

  final double size;
  final String? imageURL;
  final BoxBorder? border;
  final String? errorImage;

  @override
  Widget build(BuildContext context) {
    if (imageURL == null || !StringUtils.isURL(imageURL!)) {
      return AppErrorImage(width: size, height: size, isRounded: true, image: errorImage);
    }

    return CachedNetworkImage(
      width: size,
      height: size,
      imageUrl: imageURL!,
      fit: BoxFit.cover,
      imageBuilder: (BuildContext context, ImageProvider<Object> imageProvider) {
        return Container(
          decoration: BoxDecoration(
            border: border,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(backgroundImage: imageProvider),
        );
      },
      progressIndicatorBuilder: (_, __, DownloadProgress progress) => AppCircularProgressIndicator(
        progress: progress.progress,
      ),
      errorWidget: (_, __, ___) => AppErrorImage(width: size, height: size, isRounded: true),
    );
  }
}
