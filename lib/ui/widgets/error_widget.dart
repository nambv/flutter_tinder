import 'package:flutter/material.dart';
import 'package:tinder/tinder.dart';

class ErrorViewWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  ErrorViewWidget({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const SizedBox(height: 8),
            ElevatedButton(
              child: Text(context.localizations.retry),
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
