import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';

enum ReturnWidgetType { loading, loadingFirst, loadingMore, empty, error }

class ReturnWidget extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final double? size;
  final String? message;
  final ReturnWidgetType type;
  const ReturnWidget(
      {super.key,
      this.color = Palette.primaryLight,
      this.type = ReturnWidgetType.loading,
      this.message,
      this.textColor,
      this.size});

  @override
  Widget build(BuildContext context) {
    return Center(child: () {
      switch (type) {
        case ReturnWidgetType.loading:
          return SpinKitFadingCircle(
            color: color,
          );
        case ReturnWidgetType.loadingFirst:
          return SizedBox(
            height: size ?? Sizes.s1.sh * 0.7,
            child: SpinKitWave(
              color: color,
            ),
          );
        case ReturnWidgetType.loadingMore:
          return SpinKitThreeBounce(
            color: color,
          );
        case ReturnWidgetType.error:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Symbols.error, color: color),
              const Gap(Sizes.s8),
              Text(message ?? "Something Went Wrong",
                  style: TextStyle(
                      color: textColor ?? Palette.black,
                      fontWeight: FontWeight.bold))
            ],
          );
        case ReturnWidgetType.empty:
          return SizedBox(
            height: size ?? Sizes.s1.sh * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Symbols.package_2,
                  color: color,
                  size: Sizes.s100.h,
                  fill: Sizes.s1,
                ),
                const Gap(Sizes.s8),
                Text(message ?? "No Data Found",
                    style: TextStyle(
                        color: textColor ?? Palette.black,
                        fontWeight: FontWeight.bold))
              ],
            ),
          );
      }
    }());
  }
}
