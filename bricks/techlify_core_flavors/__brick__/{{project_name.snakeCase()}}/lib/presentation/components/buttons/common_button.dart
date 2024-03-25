import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/presentation/components/global/dyanamic_icon.dart';
import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';

class CommonButton extends StatelessWidget {
  final Widget? child;
  final String title;
  final Function()? onPressed;
  final double marginHorizontal;
  final double paddingVeritical;
  final double paddingHorizontal;
  final double radius;

  final Color color;
  final Color textColor;
  final double elevalion;
  final double? width;
  final double? height;

  final bool isDisabled;
  final bool showBorder;

  const CommonButton({
    super.key,
    this.child,
    required this.onPressed,
    this.color = Palette.primary,
    this.textColor = Palette.white,
    this.elevalion = 0,
    this.marginHorizontal = 0.0,
    this.paddingHorizontal = Sizes.s16,
    this.width,
    this.paddingVeritical = Sizes.s16,
    this.showBorder = false,
    this.isDisabled = false,
    this.title = 'Next',
    this.radius = Sizes.s30,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            minimumSize:
                width != null || height != null ? Size(width!, height!) : null,
            side: showBorder
                ? const BorderSide(
                    color: Palette.greyD8D, // Border color
                    width: Sizes.s0_5, // Border width
                  )
                : null,
            backgroundColor: isDisabled ? Palette.greyd9d9d9 : color,
            elevation: elevalion,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.symmetric(
                vertical: paddingVeritical, horizontal: paddingHorizontal),
            foregroundColor: !isDisabled ? textColor : Palette.white,
            textStyle: context.textTheme.bodyMedium!.copyWith(color: textColor),
          ),
          child: child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyMedium!
                        .copyWith(fontSize: Sizes.s18.sp, color: textColor),
                  ),
                  const Gap(Sizes.s4),
                  DynamicIcon(
                    Symbols.keyboard_arrow_right,
                    height: Sizes.s24.h,
                    color: textColor,
                  )
                ],
              ),
        ),
      ),
    );
  }
}
