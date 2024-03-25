import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final String? errorImage;
  final Widget? child;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double radius;
  final bool inStack;

  const CachedImage(this.imageUrl,
      {Key? key,
      this.errorImage,
      this.child,
      this.height,
      this.width,
      this.fit = BoxFit.contain,
      this.inStack = false,
      this.radius = Sizes.s0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            height: height,
            width: width,
            fit: fit,
            placeholder: (context, url) => Container(
              alignment: Alignment.center,
              height: height,
              width: width,
              child: Container(
                alignment: Alignment.center,
                height: height,
                width: width,
                child: Image.asset(
                  ImageAssets.togoLogo,
                  height: 80,
                  width: 80,
                  fit: fit,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: Palette.primary,
            ),
          ),
          if (inStack)
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Palette.black20,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
        ],
      ),
    );
  }
}
