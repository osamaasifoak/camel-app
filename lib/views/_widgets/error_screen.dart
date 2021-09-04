import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
    required this.errorMessage,
    required this.onRetry,
    this.buttonText,
  }) : super(key: key);

  final String errorMessage;
  final VoidCallback onRetry;
  final Widget? buttonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.height * 0.2,
            margin: const EdgeInsets.only(bottom: 30),
            child: const FittedBox(
              child: Icon(Icons.sentiment_dissatisfied_rounded),
            ),
          ),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: onRetry,
            style: OutlinedButton.styleFrom(
              primary: const Color(0xFF01579B),
              backgroundColor: Colors.lightBlue[50],
              side: const BorderSide(
                color: Color(0xFF01579B),
                width: 1.5,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40),
            ),
            child: buttonText ?? const Text('Reload'),
          ),
        ],
      ),
    );
  }
}
