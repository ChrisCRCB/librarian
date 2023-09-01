import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/json/book.dart';
import '../src/providers.dart';
import 'books_list_view.dart';

/// A [ListView] to show the contents of the shopping cart.
class ShoppingCartListView extends ConsumerWidget {
  /// Create an instance.
  const ShoppingCartListView({
    super.key,
  });

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final shoppingCartValue = ref.watch(shoppingCartProvider);
    return shoppingCartValue.when(
      data: (final shoppingCart) {
        final booksValue = ref.watch(booksProvider.call(context));
        return booksValue.when(
          data: (final books) {
            final actualBooks = <Book>[];
            for (final item in shoppingCart.items) {
              final matchingBooks = books.where(
                (final element) => element.callNumbers.contains(item.id),
              );
              if (matchingBooks.isNotEmpty) {
                actualBooks.add(matchingBooks.first);
              }
            }
            return BooksListView(
              books: actualBooks,
              emptyMessage:
                  'There are no books in your shopping cart. First add books '
                  'using the button in the top right corner of any book '
                  'screen.',
            );
          },
          error: ErrorListView.withPositional,
          loading: LoadingWidget.new,
        );
      },
      error: ErrorListView.withPositional,
      loading: LoadingWidget.new,
    );
  }
}
