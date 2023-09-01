import 'package:json_annotation/json_annotation.dart';

import 'shopping_cart.dart';

part 'shopping_cart_item.g.dart';

/// An item in a [ShoppingCart].
@JsonSerializable()
class ShoppingCartItem {
  /// Create an instance.
  const ShoppingCartItem({
    required this.id,
    required this.name,
  });

  /// Create an instance from a JSON object.
  factory ShoppingCartItem.fromJson(final Map<String, dynamic> json) =>
      _$ShoppingCartItemFromJson(json);

  /// The ID of this item.
  final String id;

  /// The name of this item.
  final String name;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$ShoppingCartItemToJson(this);
}
