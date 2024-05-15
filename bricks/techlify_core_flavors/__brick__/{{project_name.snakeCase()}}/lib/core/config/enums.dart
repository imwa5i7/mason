class EnumValues<T> {
  Map<int, T>? map;
  Map<T, int>? reverseMap;

  EnumValues(this.map);

  Map<T, int> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
