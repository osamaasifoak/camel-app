import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
    required this.errorMessage,
    required this.onRetry,
  }) : super(key: key);

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.height / 5,
          margin: const EdgeInsets.only(bottom: 30),
          child: const FittedBox(
            child: Icon(
              Icons.sentiment_dissatisfied_rounded,
            ),
          ),
        ),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
        OutlinedButton(
          onPressed: onRetry,
          style: OutlinedButton.styleFrom(
            primary: const Color(0xFF01579B),
            backgroundColor: Colors.lightBlue[50],
            side: const BorderSide(
              color: Color(0xFF01579B),
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40),
          ),
          child: const Text(
            'Reload',
          ),
        ),
      ],
    );
  }
}
