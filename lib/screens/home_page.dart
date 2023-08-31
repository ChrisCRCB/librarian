import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/json/book_author.dart';
import '../src/providers.dart';
import '../widgets/books_list_view.dart';
import 'author_screen.dart';

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
        final genreList = <String>[];
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
        }
        authorList.sort(
          (final a, final b) =>
              a.firstLast.toLowerCase().compareTo(b.firstLast.toLowerCase()),
        );
        genreList.sort();
        final authors = Set<BookAuthor>.from(authorList).toList();
        final genres = Set<String>.from(genreList).toList();
        return TabbedScaffold(
          tabs: [
            TabbedScaffoldTab(
              title: 'Books',
              icon: Text('${books.length}'),
              builder: (final context) => BooksListView(books: books),
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
                      title: Text('${author.role}: ${author.firstLast}'),
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
              title: 'Genres',
              icon: Text('${genres.length}'),
              builder: (final context) => BuiltSearchableListView(
                items: genres,
                builder: (final context, final index) {
                  final genre = genres[index];
                  final booksInGenre = books
                      .where(
                        (final element) => element.genre
                            .map((final e) => e.trim())
                            .contains(genre),
                      )
                      .toList();
                  return SearchableListTile(
                    searchString: genre,
                    child: ListTile(
                      autofocus: index == 0,
                      title: Text(genre),
                      subtitle: Text(booksInGenre.length.toString()),
                      onTap: () => pushWidget(
                        context: context,
                        builder: (final context) => Cancel(
                          child: SimpleScaffold(
                            title: genre,
                            body: BooksListView(books: booksInGenre),
                          ),
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
