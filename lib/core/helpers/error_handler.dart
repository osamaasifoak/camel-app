import 'dart:async' show TimeoutException;
import 'dart:developer' as dev show log;
import 'dart:io' show SocketException;

import 'package:flutter/foundation.dart' as foundation show kDebugMode;
import 'package:postor/postor.dart' hide Postor, PFile, PFileFromBytes, PFileFromPath, GetResponse;

import '/core/constants/app_error_messages.dart';

class ErrorHandler {
  static void catchIt({
    required Object error,
    required void Function(String errorMessage) onCatch,
    StackTrace? stackTrace,
    String? customUnknownErrorMessage,
  }) {
    if (foundation.kDebugMode) {
      dev.log(
        '[ErrorHandler] caught an error:\n\n$error\n\ncaused by the following:',
        stackTrace: stackTrace,
      );
    }
    if (error is TimeoutException) {
      onCatch(AppErrorMessages.timeOutError);
    } else if (error is SocketException) {
      onCatch(AppErrorMessages.socketError);
    } else if (error is PException) {
      if (error is CancelledRequestException) {
        onCatch(AppErrorMessages.cancelledRequestError);
      } else {
        onCatch(error.message ?? AppErrorMessages.unknownRequestError);
        if (foundation.kDebugMode) {
          dev.log('[${error.runtimeType}] Response body: \n${error.message}');
        }
      }
    } else {
      onCatch(customUnknownErrorMessage ?? AppErrorMessages.unknownError);
    }
  }
}
