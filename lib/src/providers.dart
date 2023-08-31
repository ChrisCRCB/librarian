import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../gen/assets.gen.dart';
import 'json/book.dart';

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
