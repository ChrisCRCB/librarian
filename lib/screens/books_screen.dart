import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/json/book.dart';
import '../src/providers.dart';
import '../widgets/books_list_view.dart';

/// A screen to show books according to [where].
class BooksScreen extends ConsumerWidget {
  /// Create an instance.
  const BooksScreen({
    required this.title,
    this.where,
    this.sort,
    super.key,
  });

  /// The title of this screen.
  final String title;

  /// The function to call to narrows down the book catalog.
  final bool Function(Book book)? where;

  /// The function to use to sort books.
  final int Function(Book a, Book b)? sort;

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final f = where;
    final value = ref.watch(booksProvider.call(context));
    return Cancel(
      child: SimpleScaffold(
        title: title,
        body: value.when(
          data: (final books) {
            final List<Book> actualBooks;
            if (f == null) {
              actualBooks = [...books];
            } else {
              actualBooks = books.where(f).toList();
            }
            final s = sort;
            if (s != null) {
              actualBooks.sort(
                // ignore: unnecessary_lambdas
                (final a, final b) => s(a, b),
              );
            }
            return BooksListView(
              books: actualBooks,
            );
          },
          error: ErrorListView.withPositional,
          loading: LoadingWidget.new,
        ),
      ),
    );
  }
}
