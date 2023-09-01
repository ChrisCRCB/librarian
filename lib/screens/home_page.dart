import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/json/book_author.dart';
import '../src/providers.dart';
import '../widgets/books_list_view.dart';
import '../widgets/large_text.dart';
import '../widgets/shopping_cart_list_view.dart';
import 'author_screen.dart';
import 'books_screen.dart';
import 'series_screen.dart';

/// The main page of the application.
class HomePage extends ConsumerWidget {
  /// Create an instance.
  const HomePage({
    super.key,
  });

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final value = ref.watch(booksProvider.call(context));
    return value.when(
      data: (final books) {
        final authorList = <BookAuthor>[];
        final seriesList = <String>[];
        final genreList = <String>[];
        final formatsList = <String>[];
        for (final book in books) {
          for (final author in book.authors) {
            if (authorList
                .where(
                  (final element) =>
                      element.firstLast == author.firstLast &&
                      element.role == author.role,
                )
                .isEmpty) {
              authorList.add(author);
            }
          }
          genreList.addAll(book.genre.map((final e) => e.trim()));
          final bookSeries = book.series ?? [];
          seriesList.addAll(bookSeries.map((final e) => e.trim()));
          formatsList.addAll(book.format.map((final e) => e.text));
        }
        authorList.sort(
          (final a, final b) =>
              a.firstLast.toLowerCase().compareTo(b.firstLast.toLowerCase()),
        );
        seriesList.sort();
        genreList.sort();
        formatsList.sort();
        final authors = Set<BookAuthor>.from(authorList).toList();
        final series = Set<String>.from(seriesList).toList();
        final genres = Set<String>.from(genreList).toList();
        final formats = Set<String>.from(formatsList).toList();
        return TabbedScaffold(
          tabs: [
            TabbedScaffoldTab(
              title: 'Books',
              icon: Text('${books.length}'),
              builder: (final context) => BooksListView(books: books),
            ),
            TabbedScaffoldTab(
              title: 'Shopping Cart',
              icon: const LargeText(
                text: 'The books you have added to your cart',
              ),
              builder: (final context) => const ShoppingCartListView(),
            ),
            TabbedScaffoldTab(
              title: 'Authors',
              icon: Text('${authors.length}'),
              builder: (final context) => BuiltSearchableListView(
                items: authors,
                builder: (final context, final index) {
                  final author = authors[index];
                  return SearchableListTile(
                    searchString: author.firstLast,
                    child: ListTile(
                      autofocus: index == 0,
                      title: LargeText(
                        text: '${author.role}: ${author.firstLast}',
                      ),
                      onTap: () => pushWidget(
                        context: context,
                        builder: (final context) => AuthorScreen(
                          author: author,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            TabbedScaffoldTab(
              title: 'Series',
              icon: Text('${series.length}'),
              builder: (final context) => BuiltSearchableListView(
                items: series,
                builder: (final context, final index) {
                  final s = series[index];
                  return SearchableListTile(
                    searchString: s,
                    child: ListTile(
                      autofocus: index == 0,
                      title: LargeText(
                        text: s,
                      ),
                      onTap: () => pushWidget(
                        context: context,
                        builder: (final context) => SeriesScreen(series: s),
                      ),
                    ),
                  );
                },
              ),
            ),
            TabbedScaffoldTab(
              title: 'Genres',
              icon: Text('${genres.length}'),
              builder: (final context) => BuiltSearchableListView(
                items: genres,
                builder: (final context, final index) {
                  final genre = genres[index];
                  return SearchableListTile(
                    searchString: genre,
                    child: ListTile(
                      autofocus: index == 0,
                      title: LargeText(
                        text: genre,
                      ),
                      onTap: () => pushWidget(
                        context: context,
                        builder: (final context) => BooksScreen(
                          title: 'Genre: $genre',
                          where: (final book) => book.genre
                              .map((final e) => e.trim())
                              .contains(genre),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            TabbedScaffoldTab(
              title: 'Formats',
              icon: Text('${formats.length}'),
              builder: (final context) => BuiltSearchableListView(
                items: formats,
                builder: (final context, final index) {
                  final format = formats[index];
                  return SearchableListTile(
                    searchString: format,
                    child: ListTile(
                      autofocus: index == 0,
                      title: LargeText(
                        text: format,
                      ),
                      onTap: () => pushWidget(
                        context: context,
                        builder: (final context) => BooksScreen(
                          title: 'Format: $format',
                          where: (final book) => book.format
                              .where((final element) => element.text == format)
                              .isNotEmpty,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      error: ErrorScreen.withPositional,
      loading: LoadingScreen.new,
    );
  }
}
