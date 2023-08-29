import 'dart:convert';

import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../src/json/book.dart';

/// The main page of the application.
class HomePage extends StatelessWidget {
  /// Create an instance.
  const HomePage({
    super.key,
  });

  /// Build the widget.
  @override
  Widget build(final BuildContext context) {
    final future = DefaultAssetBundle.of(context).loadString(Assets.books);
    return SimpleScaffold(
      title: 'Books',
      body: FutureBuilder(
        future: future,
        builder: (final context, final snapshot) {
          if (snapshot.hasData) {
            final json =
                jsonDecode(snapshot.requireData) as Map<String, dynamic>;
            final books = json.values.map(
              (final e) {
                assert(
                  e is Map<String, dynamic>,
                  'Wrong format: ${e.runtimeType}.',
                );
                try {
                  final book = Book.fromJson(e as Map<String, dynamic>);
                  return book;
                } catch (_) {
                  final data = e as Map<String, dynamic>;
                  final book = Book(entryDate: DateTime.now());
                  final json = book.toJson();
                  for (final key in json.keys) {
                    print(key);
                    print(data[key]);
                  }
                  rethrow;
                }
              },
            ).toList();
            return ListView.builder(
              itemBuilder: (final context, final index) {
                final book = books[index];
                return ListTile(
                  title: Text(book.title),
                  onTap: () {},
                );
              },
              itemCount: books.length,
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
