import 'dart:async' show TimeoutException;
import 'dart:developer' as _dev show log;

import 'package:flutter/foundation.dart' as foundation show kDebugMode;
import 'package:postor/error_handler.dart' deferred as _eh show initErrorMessages;
import 'package:postor/http.dart' deferred as _http show ClientException;
import 'package:postor/postor.dart' deferred as _postor show CancelledRequestException, PException;

import '/core/constants/app_error_messages.dart';

const void Function(String message, {StackTrace? stackTrace}) log = _dev.log;

Future<void> initErrorMessageHandlers() async {
  await _postor.loadLibrary();
  await _http.loadLibrary();
  await _eh.loadLibrary();
  return _eh.initErrorMessages((
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
    } else if (error.runtimeType == _http.ClientException) {
      return AppErrorMessages.socketError;
    } else if (error.runtimeType == _postor.PException) {
      if (error.runtimeType == _postor.CancelledRequestException) {
        return AppErrorMessages.cancelledRequestError;
      } else {
        return otherErrorMessage ?? AppErrorMessages.unknownRequestError;
      }
    } else {
      return otherErrorMessage ?? AppErrorMessages.unknownError;
    }
  });
}
