// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      entryDate: DateTime.parse(json['entrydate'] as String),
      summary: json['summary'] as String? ?? 'No summary available.',
      genre:
          (json['genre'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      source: json['source'] as String? ?? unknown,
      format: (json['format'] as List<dynamic>?)
              ?.map((e) => BookFormat.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      copies: json['copies'] as String? ?? unknown,
      publication: json['publication'] as String? ?? unknown,
      title: json['title'] as String? ?? 'Untitled Book',
      authors: (json['authors'] as List<dynamic>?)
              ?.map((e) => BookAuthor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [BookAuthor(lastFirst: unknown, firstLast: unknown)],
      language: (json['language'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      series:
          (json['series'] as List<dynamic>?)?.map((e) => e as String).toList(),
      awards: (json['awards'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publication': instance.publication,
      'summary': instance.summary,
      'language': instance.language,
      'series': instance.series,
      'awards': instance.awards,
      'genre': instance.genre,
      'source': instance.source,
      'entrydate': instance.entryDate.toIso8601String(),
      'format': instance.format,
      'copies': instance.copies,
    };
