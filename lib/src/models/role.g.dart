part of 'role.dart';

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      name: json['name'] as String,
      isAdmin: json['is_admin'] as bool,
      description: json['description'] as String,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{ 
      'name': instance.name,
      'isAdmin': instance.isAdmin,
      'description': instance.description,
    };