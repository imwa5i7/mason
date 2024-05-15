import 'package:cached_network_image/cached_network_image.dart';
import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';
import 'package:flutter/material.dart';

class CachedDecorationImage extends StatelessWidget {
  const CachedDecorationImage(this.imageUrl,
      {super.key,
      this.child,
      this.width,
      this.height,
      this.fit = BoxFit.contain});
  final String? imageUrl;
  final Widget? child;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
            centerSlice: Rect.largest,
            colorFilter: const ColorFilter.mode(
              Colors.red,
              BlendMode.colorBurn,
            ),
          ),
        ),
        child: child,
      ),
      placeholder: (context, url) => Image.asset(ImageAssets.logo),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Palette.primary,
      ),
    );
  }
}
