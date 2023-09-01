import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../gen/assets.gen.dart';
import 'json/book.dart';
import 'json/shopping_cart/shopping_cart.dart';

/// Provide all books.
final booksProvider = FutureProvider.family<List<Book>, BuildContext>(
  (final ref, final context) async {
    final text = await DefaultAssetBundle.of(context).loadString(Assets.books);
    final json = jsonDecode(text) as Map<String, dynamic>;
    final books = json.values.map(
      (final e) {
        assert(
          e is Map<String, dynamic>,
          'Wrong format: ${e.runtimeType}.',
        );
        final book = Book.fromJson(e as Map<String, dynamic>);
        return book;
      },
    ).toList();
    return books;
  },
);

/// Provide the shared preferences provider.
final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
  (final ref) => SharedPreferences.getInstance(),
);

/// Provide a shopping cart.
///
/// An empty cart will be created if no cart has yet been used.
final shoppingCartProvider = FutureProvider<ShoppingCart>(
  (final ref) async {
    final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
    final string = sharedPreferences.getString(shoppingCartKey);
    if (string == null) {
      // ignore: prefer_const_constructors
      final cart = ShoppingCart(name: 'Shopping Cart', items: []);
      await cart.save(sharedPreferences);
      return cart;
    }
    return ShoppingCart.fromJson(jsonDecode(string));
  },
);
