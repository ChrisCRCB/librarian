import 'package:backstreets_widgets/util.dart';
import 'package:flutter/material.dart';

import 'large_text.dart';

/// A [ListTile] that shows [title] and [subtitle] using the [LargeText] widget.
class LargeTextListTile extends StatelessWidget {
  /// Create an instance.
  const LargeTextListTile({
    required this.title,
    required this.subtitle,
    this.autofocus = false,
    super.key,
  });

  /// The title of the list tile.
  final String title;

  /// THe subtitle of the list tile.
  final String subtitle;

  /// Whether or not the list tile should be autofocused.
  final bool autofocus;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => ListTile(
        autofocus: autofocus,
        title: LargeText(text: title),
        subtitle: LargeText(text: title),
        onTap: () => setClipboardText('$title: $subtitle'),
      );
}
