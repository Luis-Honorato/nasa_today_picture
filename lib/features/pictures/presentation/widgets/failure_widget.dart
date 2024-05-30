import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String errorMessage;
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
