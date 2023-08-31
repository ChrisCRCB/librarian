import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const.dart';
import '../src/json/book.dart';
import '../widgets/large_text.dart';
import '../widgets/large_text_list_tile.dart';
import 'author_screen.dart';
import 'books_screen.dart';
import 'series_screen.dart';

/// A screen that shows a single [book].
class BookScreen extends ConsumerStatefulWidget {
  /// Create an instance.
  const BookScreen({
    required this.book,
    super.key,
  });

  /// The book to display.
  final Book book;

  /// Create state for this widget.
  @override
  BookScreenState createState() => BookScreenState();
}

/// State for [BookScreen].
class BookScreenState extends ConsumerState<BookScreen> {
  /// The controller to use for displaying the book summary.
  late final TextEditingController summaryController;

  /// Initialise state.
  @override
  void initState() {
    super.initState();
    summaryController = TextEditingController(text: widget.book.summary);
  }

  /// Dispose of the widget.
  @override
  void dispose() {
    super.dispose();
    summaryController.dispose();
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final book = widget.book;
    final publisher = book.publication;
    var needPublisher = true;
    final series = Set.from(book.series ?? []);
    return Cancel(
      child: TabbedScaffold(
        tabs: [
          TabbedScaffoldTab(
            title: book.title,
            icon: const Icon(Icons.book_rounded),
            builder: (final context) => ListView(
              children: [
                LargeTextListTile(
                  autofocus: true,
                  title: 'Title',
                  subtitle: book.title,
                ),
                TextField(
                  controller: summaryController,
                  decoration: const InputDecoration(
                    labelText: 'Book Summary',
                  ),
                  expands: true,
                  maxLines: null,
                  readOnly: true,
                  style: largeTextStyle,
                ),
              ],
            ),
          ),
          TabbedScaffoldTab(
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
