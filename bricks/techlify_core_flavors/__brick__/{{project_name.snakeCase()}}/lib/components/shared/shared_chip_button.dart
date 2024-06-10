import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/components/shared/shared_wrapper_button.dart';
import 'package:{{project_name.snakeCase()}}/core/constants/constants.dart';
import 'package:{{project_name.snakeCase()}}/core/config/config.dart';

class SharedChipButton extends StatelessWidget {
  final bool isSelected;
  final Function() onPressed;
  final String label;
  final double verticalPadding;
  final double horizontalPadding;
  final double? height;
  final Color? selectedColor;

  const SharedChipButton(
      {super.key,
      this.isSelected = false,
      required this.onPressed,
      required this.label,
      this.verticalPadding = Sizes.s8,
      this.horizontalPadding = Sizes.s16,
      this.height,
      this.selectedColor});

  @override
  Widget build(BuildContext context) {
    return SharedWrapperButton(
      onTap: onPressed,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor ?? Palette.primary : Palette.white,
          borderRadius: BorderRadius.circular(Sizes.s30),
        ),
        child: Text(
          label,
          style: context.bodyMedium
              .copyWith(color: isSelected ? Palette.white : Palette.black),
        ),
      ),
    );
  }
}
