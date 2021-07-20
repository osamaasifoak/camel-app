import 'dart:async' show FutureOr, TimeoutException;
import 'dart:convert' show Encoding;
import 'dart:io' show SocketException;

import 'package:http/http.dart'
    show BaseRequest, Client, Response, StreamedResponse;
import 'package:retry/retry.dart' show RetryOptions;

import 'base_network_service.dart';

typedef ResponseTimeoutCallback = FutureOr<Response> Function();
typedef StreamedResponseTimeoutCallback = FutureOr<StreamedResponse> Function();

/// a network service class which is an extension of `Client` class.
/// it is by default sets `Duration` of network timeout on every http request and retries 3 times when fails.
///
/// it can also help retrieving network status (i.e. connectivity status, internet connection status).
class NetworkService implements BaseNetworkService {
  final Client _client;
  final Duration _defaultTimeLimit;
  final RetryOptions _retryPolicy;

  /// initializes a new instance of `NetworkService`.
  /// * [defaultTimeLimit] defaults to 10 seconds if not set.
  /// * [retryPolicy] defauts to 3 times if not set.
  NetworkService({
    Client? client,
    Duration? defaultTimeLimit,
    RetryOptions? retryPolicy,
  })  : _client = client ?? Client(),
        _defaultTimeLimit = defaultTimeLimit ?? const Duration(seconds: 10),
        _retryPolicy = retryPolicy ?? const RetryOptions(maxAttempts: 3);

  @override
  void close() => _client.close();

  @override
  Future<Response> get(Uri url,
      {Map<String, String>? headers,
      Duration? timeLimit,
      ResponseTimeoutCallback? onTimeout}) {
    return _retryPolicy.retry(
        () => _client
            .get(url, headers: headers)
            .timeout(timeLimit ?? _defaultTimeLimit, onTimeout: onTimeout),
        retryIf: (e) => e is SocketException || e is TimeoutException);
  }

  @override
  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Duration? timeLimit,
    ResponseTimeoutCallback? onTimeout,
  }) {
    return _retryPolicy.retry(
        () => _client
            .post(
              url,
              headers: headers,
              body: body,
              encoding: encoding,
            )
            .timeout(timeLimit ?? _defaultTimeLimit, onTimeout: onTimeout),
        retryIf: (e) => e is SocketException || e is TimeoutException);
  }

  @override
  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Duration? timeLimit,
    ResponseTimeoutCallback? onTimeout,
  }) {
    return _retryPolicy.retry(
        () => _client
            .put(
              url,
              headers: headers,
              body: body,
              encoding: encoding,
            )
            .timeout(timeLimit ?? _defaultTimeLimit, onTimeout: onTimeout),
        retryIf: (e) => e is SocketException || e is TimeoutException);
  }

  @override
  Future<StreamedResponse> send(
    BaseRequest request, {
    Duration? timeLimit,
    StreamedResponseTimeoutCallback? onTimeout,
  }) {
    return _retryPolicy.retry(
        () => _client
            .send(request)
            .timeout(timeLimit ?? _defaultTimeLimit, onTimeout: onTimeout),
        retryIf: (e) => e is SocketException || e is TimeoutException);
  }
}
