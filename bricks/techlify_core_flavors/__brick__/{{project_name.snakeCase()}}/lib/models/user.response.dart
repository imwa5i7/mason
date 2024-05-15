class UserResponse {
  int? id;
  String? name;
  String? email;

  UserResponse({
    this.id,
    this.name,
    this.email,
  });

  factory UserResponse.fromJson(Map parsedJson) {
    return parsedJson.isNotEmpty
        ? UserResponse(
            id: parsedJson['id'],
            name: parsedJson['name'],
            email: parsedJson['email'],
          )
        : UserResponse();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;

    return map;
  }
}
