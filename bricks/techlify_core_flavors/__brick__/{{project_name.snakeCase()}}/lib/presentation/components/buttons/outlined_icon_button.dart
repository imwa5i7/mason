import 'package:flutter/material.dart';
import 'package:togo_mobile/presentation/components/global/dyanamic_icon.dart';
import 'package:togo_mobile/presentation/resources/resources.dart';

class OutlinedIconButton extends StatelessWidget {
  final dynamic icon;
  final Function() onPress;
  const OutlinedIconButton(
      {super.key, required this.icon, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPress,
      icon: DynamicIcon(
        icon,
        color: Palette.primary,
        height: Sizes.s24.h,
      ),
      style: IconButton.styleFrom(
          fixedSize: Size(Sizes.s50.h, Sizes.s50.h),
          backgroundColor: Palette.primaryFFE,
          foregroundColor: Palette.primaryFFE,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.s8),
              side:
                  const BorderSide(color: Palette.primary, width: Sizes.s0_5))),
    );
  }
}
