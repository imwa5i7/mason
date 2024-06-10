import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/components/shared/shared_icon.dart';
import 'package:{{project_name.snakeCase()}}/core/constants/constants.dart';

class SharedIconButton extends StatelessWidget {
  final dynamic icon;
  final Function() onPress;
  const SharedIconButton(
      {super.key, required this.icon, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPress,
      icon: SharedIcon(
        icon,
        color: Palette.primary,
        height: Sizes.s24.h,
      ),
      style: IconButton.styleFrom(
          fixedSize: Size(Sizes.s50.h, Sizes.s50.h),
          backgroundColor: Palette.white,
          foregroundColor: Palette.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.s8),
              side:
                  const BorderSide(color: Palette.primary, width: Sizes.s0_5))),
    );
  }
}
