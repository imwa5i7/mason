class User {
  int? id;
  String? name;
  String? email;

  User({
    this.id,
    this.name,
    this.email,
  });

  factory User.fromJson(Map parsedJson) {
    return parsedJson.isNotEmpty
        ? User(
            id: parsedJson['id'],
            name: parsedJson['name'],
            email: parsedJson['email'],
          )
        : User();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;

    return map;
  }
}
