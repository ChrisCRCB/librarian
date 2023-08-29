import 'package:json_annotation/json_annotation.dart';

part 'book_author.g.dart';

/// An author of a book.
@JsonSerializable()
class BookAuthor {
  /// Create an instance.
  const BookAuthor({
    required this.lastFirst,
    required this.firstLast,
    required this.role,
  });

  /// Create an instance from a JSON object.
  factory BookAuthor.fromJson(final Map<String, dynamic> json) =>
      _$BookAuthorFromJson(json);

  /// The name of the author as Last, First.
  @JsonKey(name: 'lf')
  final String lastFirst;

  /// The name of the author as First, Last.
  @JsonKey(name: 'fl')
  final String firstLast;

  /// The role of this person.
  final String role;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$BookAuthorToJson(this);
}
