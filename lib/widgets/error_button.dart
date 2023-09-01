import 'package:backstreets_widgets/util.dart';
import 'package:flutter/material.dart';

/// A button which displays an error.
class ErrorButton extends StatelessWidget {
  /// Create an instance.
  const ErrorButton({
    required this.error,
    required this.stackTrace,
    super.key,
  });

  /// Create an instance from positional arguments.
  const ErrorButton.withPositional(this.error, this.stackTrace, {super.key});

  /// The error to show.
  final Object error;

  /// THe stack trace to use.
  final StackTrace stackTrace;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => ElevatedButton(
        onPressed: () {
          final buffer = StringBuffer()
            ..writeln(error)
            ..writeln(stackTrace.toString());
          setClipboardText(buffer.toString());
        },
        child: const Icon(
          Icons.error_outline,
          semanticLabel: 'Error',
        ),
      );
}
