import 'package:flutter/material.dart';

/// Used to display to user a message instead his expected data or screen.
class FailureWidget extends StatelessWidget {
  /// Message displayed to user
  final String errorMessage;

  /// Function to retry fetch data at user is expected to recieve
  final Function retryFunction;
  const FailureWidget({
    super.key,
    required this.errorMessage,
    required this.retryFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => retryFunction.call(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
