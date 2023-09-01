import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import 'shopping_cart_item.dart';

part 'shopping_cart.g.dart';

/// A basic shopping cart.
@JsonSerializable()
class ShoppingCart {
  /// Create an instance.
  const ShoppingCart({
    required this.name,
    required this.items,
  });

  /// Create an instance from a JSON object.
  factory ShoppingCart.fromJson(final Map<String, dynamic> json) =>
      _$ShoppingCartFromJson(json);

  /// The name of this cart.
  final String name;

  /// The entries in the cart.
  final List<ShoppingCartItem> items;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ShoppingCartToJson(this);

  /// Save this instance.
  Future<void> save(final SharedPreferences sharedPreferences) async {
    await sharedPreferences.setString(shoppingCartKey, jsonEncode(toJson()));
  }

  /// Add a new item.
  void addItem(final ShoppingCartItem item) => items.add(item);

  /// Remove an item by [id].
  void removeItem(final String id) =>
      items.removeWhere((final element) => element.id == id);

  /// Returns `true` of [id] is found in [items].
  bool contains(final String id) =>
      items.where((final element) => element.id == id).isNotEmpty;

  /// Convert [items] to text.
  String itemsToText() {
    final buffer = StringBuffer();
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      buffer.writeln('${i + 1}. ${item.name} (${item.id})');
    }
    return buffer.toString();
  }

  /// Return an email requesting [items].
  String getEmail() {
    final buffer = StringBuffer()
      ..writeln('Hi,')
      ..writeln('I would like to reserve the following books:')
      ..writeln(itemsToText());
    return buffer.toString();
  }
}
