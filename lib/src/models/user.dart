import 'package:flutter_skeleton_app/src/models/role.dart';

part 'user.g.dart';

/// {@template user}
/// User description
/// {@endtemplate}
class User {
  /// {@macro user}
  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.role,
  });

  /// Creates a User from Json map
  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  final int id;

  /// A description for email
  final String email;

  /// A description for username
  final String username;

  /// A description for password
  final String password;

  /// A description for role
  final Role role;

  /// Creates a Json map from a User
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
