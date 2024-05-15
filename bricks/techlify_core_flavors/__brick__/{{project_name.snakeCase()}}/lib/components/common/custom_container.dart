import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color color;
  final double paddingVertical;
  final double paddingHorizontal;
  final double marginVertical;
  final double marginHorizontal;
  final Widget child;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final List<BoxShadow>? boxShadow;

  const CustomContainer(
      {super.key,
      this.height,
      this.width,
      this.showBorder = false,
      this.borderColor = Palette.greyE8E8,
      this.borderWidth = Sizes.s0_5,
      this.paddingHorizontal = Sizes.s16,
      this.paddingVertical = Sizes.s0,
      this.marginVertical = Sizes.s0,
      this.marginHorizontal = Sizes.s0,
      this.radius = Sizes.s0,
      required this.child,
      this.color = Palette.white,
      this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal, vertical: marginVertical),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
