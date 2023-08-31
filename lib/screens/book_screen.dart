import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/json/book.dart';
import '../src/providers.dart';
import '../widgets/books_list_view.dart';

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
    var needPublisher = true;
    final series = Set.from(book.series ?? []);
    return Cancel(
      child: SimpleScaffold(
        title: book.title,
        body: Column(
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
                return CopyListTile(title: e.role, subtitle: e.firstLast);
              },
            ),
            if (needPublisher)
              CopyListTile(title: 'Publisher', subtitle: book.publication),
            ...series.map(
              (final e) => ListTile(
                title: const Text('Series'),
                subtitle: Text(e),
                onTap: () async {
                  final books =
                      await ref.read(booksProvider.call(context).future);
                  final booksInSeries = books
                      .where(
                        (final element) => element.series?.contains(e) ?? false,
                      )
                      .toList();
                  if (context.mounted) {
                    await pushWidget(
                      context: context,
                      builder: (final context) => Cancel(
                        child: SimpleScaffold(
                          title: e,
                          body: BooksListView(books: booksInSeries),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Expanded(
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
    );
  }
}
