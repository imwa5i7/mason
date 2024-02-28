import 'package:equatable/equatable.dart';

/// {@template user}
/// User description
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        phone: json['phone'] as String,
      );

  final String name;
  final String email;
  final String password;
  final String phone;

  User copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        phone,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      };

  @override
  String toString() => 'User(name: $name, email: $email, password: $password, phone: $phone)';
}
