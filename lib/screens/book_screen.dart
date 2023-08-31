import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/json/book.dart';
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

  /// The book to show.
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
            title: book.title,
            icon: const Icon(Icons.book_rounded),
            builder: (final context) => Column(
              children: [
                Center(
                  child: Card(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [const Text('Title'), Text(book.title)],
                    ),
                  ),
                ),
                Card(
                  semanticContainer: false,
                  child: SingleChildScrollView(
                    child: RichText(
                      text: TextSpan(
                        text: book.summary,
                        style: DefaultTextStyle.of(context).style,
                      ),
                      selectionRegistrar: SelectionContainer.maybeOf(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TabbedScaffoldTab(
            title: 'Information',
            icon: const Icon(Icons.info_rounded),
            builder: (final context) => ListView(
              children: [
                CopyListTile(
                  title: 'Title',
                  subtitle: book.title,
                  autofocus: true,
                ),
                ...book.authors.map(
                  (final e) {
                    if (e.role.toLowerCase().trim().startsWith('publisher')) {
                      needPublisher = false;
                    }
                    return ListTile(
                      title: Text(e.role),
                      subtitle: Text(e.firstLast),
                      onTap: () => pushWidget(
                        context: context,
                        builder: (final context) => AuthorScreen(author: e),
                      ),
                    );
                  },
                ),
                ...book.callNumbers.map(
                  (final e) => CopyListTile(title: 'Call Number', subtitle: e),
                ),
                if (needPublisher)
                  ListTile(
                    title: const Text('Publisher'),
                    subtitle: Text(book.publication),
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
                    title: const Text('Series'),
                    subtitle: Text(e),
                    onTap: () => pushWidget(
                      context: context,
                      builder: (final context) => SeriesScreen(series: e),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Formats'),
                  subtitle:
                      Text(book.format.map((final e) => e.text).join(', ')),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
