import 'package:{{project_name.snakeCase()}}/presentation/resources/resources.dart';
import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headlineLarge => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;
  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;

  ElevatedButtonThemeData get elevatedButtonTheme =>
      Theme.of(this).elevatedButtonTheme;
  InputDecorationTheme get inputDecoration =>
      Theme.of(this).inputDecorationTheme;
}

ThemeData getApplicationTheme() {
  return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Palette.primary),
      primaryColor: Palette.primary,
      useMaterial3: true,
      primaryColorLight: Palette.primaryLight,
      scaffoldBackgroundColor: Palette.white,
      primaryColorDark: Palette.primary,
      disabledColor: Palette.grey7f7f,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Palette.white,
        surfaceTintColor: null,
      ),
      splashColor: Palette.primaryLight,
      cardTheme: const CardTheme(
          color: Palette.white,
          shadowColor: Palette.grey7f7f,
          elevation: Sizes.s4),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Palette.primary,
        elevation: Sizes.s4,
        shadowColor: Palette.black333,
        titleTextStyle:
            getRegularStyle(color: Palette.white, fontSize: Sizes.s16),
      ),
      iconTheme: const IconThemeData(
          color: Palette.black1C1, fill: 0, weight: 300, opticalSize: 48),
      buttonTheme: const ButtonThemeData(
          shape: StadiumBorder(),
          disabledColor: Palette.grey7f7f,
          buttonColor: Palette.primary,
          splashColor: Palette.primaryLight),
      radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(Palette.primary),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.primary,
          disabledForegroundColor: Palette.white,
          disabledBackgroundColor: Palette.grey7272,
          textStyle:
              getMediumStyle(fontSize: Sizes.s16.sp, color: Palette.white),
          padding: EdgeInsets.symmetric(vertical: Sizes.s16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.s12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: Palette.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.s16),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.s8,
            ),
            textStyle:
                getMediumStyle(fontSize: Sizes.s14.sp, color: Palette.primary)),
      ),
      textTheme: TextTheme(
          displayLarge:
              getBoldStyle(color: Palette.primary, fontSize: Sizes.s42.sp),
          displayMedium:
              getBoldStyle(color: Palette.primary, fontSize: Sizes.s32.sp),
          displaySmall:
              getBoldStyle(color: Palette.primary, fontSize: Sizes.s20.sp),
          headlineMedium:
              getSemiBoldStyle(color: Palette.black, fontSize: Sizes.s24.sp),
          headlineLarge:
              getSemiBoldStyle(color: Palette.black, fontSize: Sizes.s28.sp),
          headlineSmall:
              getSemiBoldStyle(color: Palette.black, fontSize: Sizes.s18.sp),
          titleLarge:
              getMediumStyle(color: Palette.black, fontSize: Sizes.s20.sp),
          titleMedium:
              getMediumStyle(color: Palette.black, fontSize: Sizes.s16.sp),
          titleSmall:
              getMediumStyle(color: Palette.black, fontSize: Sizes.s12.sp),
          bodyMedium:
              getRegularStyle(color: Palette.black, fontSize: Sizes.s14.sp),
          bodySmall:
              getRegularStyle(color: Palette.black, fontSize: Sizes.s10.sp),
          bodyLarge:
              getRegularStyle(color: Palette.black, fontSize: Sizes.s17.sp)),

      // input decoration theme (text form field)
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.s100)),
        backgroundColor: Palette.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: Sizes.s16, vertical: Sizes.s8),
        hintStyle:
            getRegularStyle(color: Palette.grey7f7f, fontSize: Sizes.s16.sp),
        labelStyle: getMediumStyle(color: Palette.black),
        errorStyle: getRegularStyle(color: Palette.primary),
        filled: true,
        fillColor: Palette.greyE8E8,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Palette.transparent),
          borderRadius: BorderRadius.all(Radius.circular(Sizes.s30)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Palette.grey8b8b),
          borderRadius: BorderRadius.all(Radius.circular(Sizes.s30)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Palette.primary),
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.s30),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Palette.primary),
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.s30),
          ),
        ),
      ));
}
