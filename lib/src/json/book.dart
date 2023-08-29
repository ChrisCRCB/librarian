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
    this.date = unknown,
    this.summary = 'No summary available.',
    this.genre = const [],
    this.source = unknown,
    this.format = const [],
    this.copies = unknown,
    this.volumes = '1',
    this.dimensions,
    this.weight,
    this.pages,
    this.publication = unknown,
    this.asin = unknown,
    this.title = 'Untitled Book',
    this.originalIsbn = unknown,
    this.authors = const [
      BookAuthor(
        lastFirst: unknown,
        firstLast: unknown,
        role: 'Author',
      ),
    ],
    this.tags = const [],
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

  /// The tags of this book.
  final List<String> tags;

  /// The original ISBN of this book.
  @JsonKey(name: 'originalisbn')
  final String? originalIsbn;

  /// The ASIN of this book.
  final String? asin;

  /// The publisher of this book.
  final String? publication;

  /// The date string.
  final String? date;

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

  /// The number of volumes.
  final String volumes;

  /// The dimensions of this book.
  final String? dimensions;

  /// The weight of this book.
  final String? weight;

  /// The number of pages.
  final String? pages;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
