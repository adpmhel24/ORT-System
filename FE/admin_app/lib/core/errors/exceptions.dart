import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'failures.dart';

class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class CacheException implements Exception {}

class AuthException implements Exception {
  final String message;
  final Uri? uri;

  const AuthException(this.message, {this.uri});

  @override
  String toString() {
    var b = StringBuffer()
      ..write('AuthException: ')
      ..write(message);
    var uri = this.uri;
    if (uri != null) {
      b.write(', uri = $uri');
    }
    return b.toString();
  }
}

class CustomDioReturnError {
  static error(DioException err) {
    if (err.response != null) {
      if (err.response!.statusCode == 401) {
        final message = err.response!.statusMessage;
        debugPrint(message);

        return ServerFailure("$message");
      }
      if (err.response!.data.runtimeType != String) {
        final message = err.response!.data['message'];
        debugPrint(message);
        return ServerFailure(message);
      } else {
        final message = err.response!.statusMessage;

        return ServerFailure(
            "Error Code ${err.response!.statusCode}: $message");
      }
    } else if (err.type == DioExceptionType.connectionTimeout) {
      return const ServerFailure("Connection timed out");
    } else if (err.type == DioExceptionType.receiveTimeout) {
      return const ServerFailure("Received timed out");
    } else if (err.type == DioExceptionType.sendTimeout) {
      return const ServerFailure("Send timed out");
    } else if (err.type == DioExceptionType.unknown) {
      return ServerFailure(err.message ?? "Unknown error");
    } else {
      return ServerFailure(err.message ?? "Unknown error");
    }
  }
}
