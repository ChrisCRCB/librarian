import 'package:flutter/material.dart';

import '../constants.dart';

/// A large [Text] widget.
class LargeText extends StatelessWidget {
  /// Create an instance.
  const LargeText({
    required this.text,
    super.key,
  });

  /// The text to display.
  final String text;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: largeTextStyle,
      );
}
