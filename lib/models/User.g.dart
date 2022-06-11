// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      location: json['location'] as String?,
      profilePicture: json['profilePicture'] as String?,
      password: json['password'] as String?,
      following: (json['following'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'location': instance.location,
      'username': instance.username,
      'password': instance.password,
      'profilePicture': instance.profilePicture,
      'followers': instance.followers,
      'following': instance.following,
    };
