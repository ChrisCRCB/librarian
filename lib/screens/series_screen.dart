import 'package:flutter/material.dart';

import 'books_screen.dart';

/// A screen to show the books in [series].
class SeriesScreen extends StatelessWidget {
  /// Create an instance.
  const SeriesScreen({
    required this.series,
    super.key,
  });

  /// The series to show.
  final String series;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => BooksScreen(
        title: 'Series: $series',
        where: (final book) => book.series?.contains(series) ?? false,
      );
}
