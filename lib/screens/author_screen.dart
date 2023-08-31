import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/json/book_author.dart';
import 'books_screen.dart';

/// Show all books by [author].
class AuthorScreen extends ConsumerWidget {
  /// Create an instance.
  const AuthorScreen({
    required this.author,
    super.key,
  });

  /// The author whose books should be displayed.
  final BookAuthor author;

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) => BooksScreen(
        title: '${author.role}: ${author.firstLast}',
        where: (final book) => book.authors
            .where(
              (final element) =>
                  element.firstLast == author.firstLast &&
                  element.role == author.role,
            )
            .isNotEmpty,
      );
}
