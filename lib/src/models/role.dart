

part 'role.g.dart';

/// {@template role}
/// Role description
/// {@endtemplate}
class Role {
  /// {@macro role}
  const Role({ 
    required this.name,
    required this.isAdmin,
    required this.description,
  });

  /// Creates a Role from Json map
  factory Role.fromJson(Map<String, dynamic> data) => _$RoleFromJson(data);

  /// A description for name
  final String name;
  /// A description for isAdmin
  final bool isAdmin;
  /// A description for description
  final String description;

  
  /// Creates a Json map from a Role
  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
