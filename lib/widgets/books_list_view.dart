import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../screens/book_screen.dart';
import '../src/json/book.dart';

/// A [ListView] which will show [books].
class BooksListView extends StatelessWidget {
  /// Create an instance.
  const BooksListView({
    required this.books,
    this.emptyMessage = 'There are no titles to show.',
    super.key,
  });

  /// The books to show.
  final List<Book> books;

  /// The message to show when [books] is empty.
  final String emptyMessage;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) {
    if (books.isEmpty) {
      return CenterText(text: emptyMessage);
    }
    final sortedBooks = [...books]..sort(
        (final a, final b) =>
            a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );
    return BuiltSearchableListView(
      items: sortedBooks,
      builder: (final context, final index) {
        final book = sortedBooks[index];
        final bookTitle = book.title.trim();
        final bookAuthor = book.authors
            .firstWhere(
              (final element) =>
                  element.role.toLowerCase().startsWith('author'),
              orElse: () => book.authors.first,
            )
            .firstLast;
        return SearchableListTile(
          searchString: bookTitle,
          child: ListTile(
            autofocus: index == 0,
            title: Text('$bookTitle by $bookAuthor'),
            onTap: () => pushWidget(
              context: context,
              builder: (final context) => BookScreen(book: book),
            ),
          ),
        );
      },
    );
  }
}