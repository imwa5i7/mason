import 'package:flutter/material.dart';

const String empty = "";
const int zero = 0;

extension ContextExtension on BuildContext {
  double get statusPadding => MediaQuery.paddingOf(this).top;
}

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return empty;
    } else {
      return this!;
    }
  }

  String onImage() {
    if (this == null) {
      return "Placeholder image url";
    } else {
      return "baseUrl${this!}";
    }
  }
}

extension NonNullDouble on double? {
  double toDouble() {
    if (this == null) {
      return 0.0;
    } else {
      return this!;
    }
  }
}

// extension on Integer

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return zero;
    } else {
      return this!;
    }
  }
}
