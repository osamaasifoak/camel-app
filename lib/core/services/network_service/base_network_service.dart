import 'dart:async' show FutureOr;
import 'dart:convert' show Encoding;

import 'package:http/http.dart' show BaseRequest, Response, StreamedResponse;

typedef ResponseTimeoutCallback = FutureOr<Response> Function();
typedef StreamedResponseTimeoutCallback = FutureOr<StreamedResponse> Function();

abstract class BaseNetworkService {
  ///Closes the client and cleans up any resources associated with it.
  ///
  ///It's important to close each client when it's done being used; failing to do so can cause the Dart process to hang.
  void close();

  ///Sends an HTTP GET request with the given headers to the given URL and
  ///a default [timeLimit] of 10 seconds.
  ///
  ///For more fine-grained control over the request, use [send] instead.
  Future<Response> get(
    Uri url, {
    Map<String, String>? headers,
    Duration? timeLimit,
    ResponseTimeoutCallback? onTimeout,
  });

  ///Sends an HTTP POST request with the given headers and body to the given URL and
  ///a default [timeLimit] of 10 seconds.
  ///
  ///[body] sets the body of the request.
  ///It can be a [String], a [List] or a [Map<String, String>].
  ///If it's a String, it's encoded using [encoding] and used as the body of the request.
  ///The content-type of the request will default to `"text/plain"`.
  ///
  ///If [body] is a List, it's used as a list of bytes for the body of the request.
  ///
  ///If [body] is a Map, it's encoded as form fields using [encoding].
  ///The content-type of the request will be set to `"application/x-www-form-urlencoded"`; this cannot be overridden.
  ///
  ///[encoding] defaults to [utf8].
  ///
  ///For more fine-grained control over the request, use [send] instead.
  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Duration? timeLimit,
    ResponseTimeoutCallback? onTimeout,
  });

  ///Sends an HTTP PUT request with the given headers and body to the given URL and
  ///a default [timeLimit] of 10 seconds.
  ///
  ///[body] sets the body of the request.
  ///It can be a [String], a [List] or a [Map<String, String>].
  ///If it's a String, it's encoded using [encoding] and used as the body of the request.
  ///The content-type of the request will default to `"text/plain"`.
  ///
  ///If [body] is a List, it's used as a list of bytes for the body of the request.
  ///
  ///If [body] is a Map, it's encoded as form fields using [encoding].
  ///The content-type of the request will be set to `"application/x-www-form-urlencoded"`; this cannot be overridden.
  ///
  ///[encoding] defaults to [utf8].
  ///
  ///For more fine-grained control over the request, use [send] instead.
  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Duration? timeLimit,
    ResponseTimeoutCallback? onTimeout,
  });

  /// Sends an HTTP request with a default [timeLimit] of 10 seconds, and asynchronously returns the response.
  Future<StreamedResponse> send(
    BaseRequest request, {
    Duration? timeLimit,
    StreamedResponseTimeoutCallback? onTimeout,
  });
}
