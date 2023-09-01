import 'package:json_annotation/json_annotation.dart';

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

  /// Add a new item.
  void addItem(final ShoppingCartItem item) => items.add(item);

  /// Remove an item by [id].
  void removeItem(final String id) =>
      items.removeWhere((final element) => element.id == id);
}
