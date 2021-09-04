import 'package:flutter/material.dart';

import '_widgets/error_screen.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: ErrorScreen(
          errorMessage: "Oopss... The page you're looking for does not exist",
          onRetry: Navigator.of(context).pop,
          buttonText: const Text('Go back'),
        ),
      ),
    );
  }
}
