import 'package:{{project_name.snakeCase()}}/core/constants/constants.dart';
import 'package:flutter/material.dart';

Future<dynamic> showModalSheet(
  BuildContext context,
  Widget child, {
  required double height,
  bool enableDrag = true,
}) {
  return showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      useRootNavigator: true,
      barrierColor: Palette.black333,
      backgroundColor: Palette.white,
      elevation: Sizes.s4,
      builder: (ctx) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: height,
              width: Sizes.s1.sw,
              decoration: const BoxDecoration(
                  color: Palette.white,
                  boxShadow: [
                    BoxShadow(
                      color: Palette.black333,
                      spreadRadius: 4.0,
                      blurRadius: 3.0,
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Sizes.s30),
                    topRight: Radius.circular(Sizes.s30),
                  )),
              child: child,
            ),
          ),
        );
      });
}
