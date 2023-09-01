import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/json/book.dart';
import '../src/json/shopping_cart/shopping_cart_item.dart';
import '../src/providers.dart';
import 'error_button.dart';
import 'large_text.dart';

/// An [ElevatedButton] to add or remove [book] from the shopping cart.
class ShoppingCartButton extends ConsumerWidget {
  /// Create an instance.
  const ShoppingCartButton({
    required this.book,
    super.key,
  });

  /// The book to use.
  final Book book;

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final id = book.callNumbers.first;
    final bookTitle = book.title;
    final author = book.authors.map((final e) => e.firstLast).join(', ');
    final value = ref.watch(shoppingCartProvider);
    return value.when(
      data: (final shoppingCart) {
        final contains = shoppingCart.contains(id);
        return ElevatedButton(
          onPressed: () async {
            if (contains) {
              shoppingCart.removeItem(id);
            } else {
              shoppingCart.addItem(
                ShoppingCartItem(
                  id: id,
                  name: '$bookTitle by $author',
                ),
              );
            }
            final sharedPreferences =
                await ref.read(sharedPreferencesProvider.future);
            await shoppingCart.save(sharedPreferences);
            ref.invalidate(shoppingCartProvider);
          },
          child: LargeText(
            text: contains ? 'Remove From Cart' : 'Add To Cart',
          ),
        );
      },
      error: ErrorButton.withPositional,
      loading: LoadingWidget.new,
    );
  }
}
