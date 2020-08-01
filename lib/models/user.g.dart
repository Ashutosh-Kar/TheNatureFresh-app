// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    address: json['address'] as String,
    role: json['role'] as String,
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'address': instance.address,
      'role': instance.role,
      'uid': instance.uid,
    };
