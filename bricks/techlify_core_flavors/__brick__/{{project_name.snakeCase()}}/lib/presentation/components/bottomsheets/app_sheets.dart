import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';

showModalSheet(
  BuildContext context, {
  required child,
  required double height,
  bool enableDrag = true,
}) {
  showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      useRootNavigator: true,
      barrierColor: Palette.black20,
      backgroundColor: Palette.white,
      elevation: Sizes.s4,
      builder: (ctx) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: height,
              width: Sizes.s1.sw,
              decoration: const BoxDecoration(
                  color: Palette.white,
                  boxShadow: [
                    BoxShadow(
                      color: Palette.black25,
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
