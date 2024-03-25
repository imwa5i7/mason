import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DynamicIcon extends StatelessWidget {
  final Color? color;
  final double height;
  final dynamic path;
  const DynamicIcon(this.path,
      {super.key, this.color, this.height = Sizes.s16});

  @override
  Widget build(BuildContext context) {
    return path is String && path.toString().endsWith('.svg')
        ? SvgPicture.asset(
            path,
            height: height,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
          )
        : path is String && path.toString().endsWith('.png')
            ? Image.asset(
                path,
                height: height,
              )
            : Icon(
                path,
                size: height,
                color: color,
              );
  }
}
