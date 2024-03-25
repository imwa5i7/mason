import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';

class WrapperButton extends StatelessWidget {
  final double radius;
  final Function()? onTap;
  final Widget child;
  final Color? color;
  final double verticalPadding;
  final double horizontalPadding;

  const WrapperButton({
    super.key,
    this.radius = Sizes.s12,
    required this.onTap,
    required this.child,
    this.color,
    this.verticalPadding = Sizes.s0,
    this.horizontalPadding = Sizes.s0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: Material(
          color: color ?? Palette.transparent,
          borderRadius: BorderRadius.circular(radius),
          child: child,
        ),
      ),
    );
  }
}
