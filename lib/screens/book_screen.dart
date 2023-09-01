import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/json/book.dart';
import '../widgets/large_text.dart';
import '../widgets/large_text_list_tile.dart';
import '../widgets/shopping_cart_button.dart';
import 'author_screen.dart';
import 'books_screen.dart';
import 'series_screen.dart';

/// A screen that shows a single [book].
class BookScreen extends ConsumerWidget {
  /// Create an instance.
  const BookScreen({
    required this.book,
    super.key,
  });

  /// The book to display.
  final Book book;

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final publisher = book.publication;
    var needPublisher = true;
    final series = Set.from(book.series ?? []);
    return Cancel(
      child: TabbedScaffold(
        tabs: [
          TabbedScaffoldTab(
            actions: [ShoppingCartButton(book: book)],
            title: book.title,
            icon: const Icon(Icons.book_rounded),
            builder: (final context) => ListView(
              children: [
                LargeTextListTile(
                  autofocus: true,
                  title: 'Title',
                  subtitle: book.title,
                ),
                ListTile(
                  title: const LargeText(text: 'Book Summary'),
                  subtitle: LargeText(
                    text: book.summary,
                  ),
                  onTap: () => setClipboardText(book.summary),
                ),
              ],
            ),
          ),
          TabbedScaffoldTab(
            actions: [ShoppingCartButton(book: book)],
            title: 'Information',
            icon: const Icon(Icons.info_rounded),
            builder: (final context) => ListView(
              children: [
                LargeTextListTile(
                  autofocus: true,
                  title: 'Title',
                  subtitle: book.title,
                ),
                ...book.authors.map(
                  (final e) {
                    if (e.role.toLowerCase().trim().startsWith('publisher')) {
                      needPublisher = false;
                    }
                    return ListTile(
                      title: LargeText(text: e.role),
                      subtitle: LargeText(text: e.firstLast),
                      onTap: () => pushWidget(
                        context: context,
                        builder: (final context) => AuthorScreen(author: e),
                      ),
                    );
                  },
                ),
                ...book.callNumbers.map(
                  (final e) => LargeTextListTile(
                    title: 'Call Number',
                    subtitle: e,
                  ),
                ),
                if (needPublisher)
                  ListTile(
                    title: const LargeText(text: 'Publisher'),
                    subtitle: LargeText(text: book.publication),
                    onTap: () => pushWidget(
                      context: context,
                      builder: (final context) => BooksScreen(
                        title: 'Published by: $publisher',
                        where: (final book) => book.publication == publisher,
                      ),
                    ),
                  ),
                ...series.map(
                  (final e) => ListTile(
                    title: const LargeText(text: 'Series'),
                    subtitle: LargeText(text: e),
                    onTap: () => pushWidget(
                      context: context,
                      builder: (final context) => SeriesScreen(series: e),
                    ),
                  ),
                ),
                LargeTextListTile(
                  title: 'Formats',
                  subtitle: book.format.map((final e) => e.text).join(', '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
