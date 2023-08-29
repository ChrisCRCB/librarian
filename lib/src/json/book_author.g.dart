// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookAuthor _$BookAuthorFromJson(Map<String, dynamic> json) => BookAuthor(
      lastFirst: json['lf'] as String,
      firstLast: json['fl'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$BookAuthorToJson(BookAuthor instance) =>
    <String, dynamic>{
      'lf': instance.lastFirst,
      'fl': instance.firstLast,
      'role': instance.role,
    };
