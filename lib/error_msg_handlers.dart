import 'dart:async' show TimeoutException;
import 'dart:developer' as _dev show log;
import 'dart:io' show SocketException;

import 'package:flutter/foundation.dart' as foundation show kDebugMode;
import 'package:postor/error_handler.dart' as eh show initErrorMessages;
import 'package:postor/postor.dart' show CancelledRequestException, PException;

import 'core/constants/app_error_messages.dart';

const void Function(String message, {StackTrace? stackTrace}) log = _dev.log;

void initErrorMessageHandlers() {
  return eh.initErrorMessages((
    Object error,
    StackTrace? stackTrace,
    String? otherErrorMessage,
  ) {
    if (foundation.kDebugMode) {
      log(
        '[ErrorHandler] caught an error:\n$error\ncaused by the following:',
        stackTrace: stackTrace,
      );
    }
    if (error is TimeoutException) {
      return AppErrorMessages.timeOutError;
    } else if (error is SocketException) {
      return AppErrorMessages.socketError;
    } else if (error is PException) {
      if (error is CancelledRequestException) {
        return AppErrorMessages.cancelledRequestError;
      } else {
        if (foundation.kDebugMode) {
          log('[${error.runtimeType}] Response body: \n${error.message}');
        }
        return otherErrorMessage ?? AppErrorMessages.unknownRequestError;
      }
    } else {
      return otherErrorMessage ?? AppErrorMessages.unknownError;
    }
  });
}
