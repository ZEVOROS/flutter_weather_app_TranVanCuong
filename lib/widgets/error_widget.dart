import 'package:flutter/material.dart';

class ErrorWidgetCustom extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const ErrorWidgetCustom({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(message, style: const TextStyle(color: Colors.red)),
        const SizedBox(height: 8),
        if (onRetry != null) ElevatedButton(onPressed: onRetry, child: const Text('Retry'))
      ]),
    );
  }
}
