import 'package:json_annotation/json_annotation.dart';

import 'book_author.dart';
import 'book_format.dart';

part 'book.g.dart';

/// Unknown constant.
const unknown = 'Unknown';

/// A single book in the library.
@JsonSerializable()
class Book {
  /// Create an instance.
  const Book({
    required this.entryDate,
    required this.summary,
    required this.genre,
    required this.source,
    this.format = const [],
    this.copies = unknown,
    this.publication = unknown,
    this.title = 'Untitled Book',
    this.authors = const [
      BookAuthor(
        lastFirst: unknown,
        firstLast: unknown,
      ),
    ],
    this.language,
    this.series,
    this.awards = const [],
  });

  /// Create an instance from a JSON object.
  factory Book.fromJson(final Map<String, dynamic> json) =>
      _$BookFromJson(json);

  /// The title of this book.
  final String title;

  /// The authors of this book.
  final List<BookAuthor> authors;

  /// The publisher of this book.
  final String publication;

  /// The summary of this book.
  final String summary;

  /// The languages of this book.
  final List<String>? language;

  /// The series this book is part of.
  final List<String>? series;

  /// Any awards this book has earned.
  final List<String> awards;

  /// The genres this book is part of.
  final List<String> genre;

  /// Data attribution.
  final String source;

  /// The date this book was added to the library.
  @JsonKey(name: 'entrydate')
  final DateTime entryDate;

  /// The formats this book is in.
  final List<BookFormat> format;

  /// The number of copies we have.
  final String copies;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
