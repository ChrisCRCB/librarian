import 'package:json_annotation/json_annotation.dart';

part 'book_format.g.dart';

/// The format of a book.
@JsonSerializable()
class BookFormat {
  /// Create an instance.
  const BookFormat({
    required this.code,
    required this.text,
  });

  /// Create an instance from a JSON object.
  factory BookFormat.fromJson(final Map<String, dynamic> json) =>
      _$BookFormatFromJson(json);

  /// The ID of this format.
  final String code;

  /// The name of this format.
  final String text;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$BookFormatToJson(this);
}
