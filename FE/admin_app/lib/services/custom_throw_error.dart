import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core/errors/exceptions.dart';

class CustomThrowError {
  static HttpException throwError(DioException err) {
    if (err.response != null) {
      if (err.response!.statusCode == 401) {
        final message = err.response!.statusMessage;
        debugPrint(message);

        throw AuthException("$message");
      }
      if (err.response!.data.runtimeType != String) {
        final message = err.response!.data['message'];
        debugPrint(message);
        throw HttpException(message);
      } else {
        final message = err.response!.statusMessage;

        throw HttpException("Error Code ${err.response!.statusCode}: $message");
      }
    } else if (err.type == DioExceptionType.connectionTimeout) {
      throw const HttpException("Connection timed out");
    } else if (err.type == DioExceptionType.receiveTimeout) {
      throw const HttpException("Received timed out");
    } else if (err.type == DioExceptionType.sendTimeout) {
      throw const HttpException("Send timed out");
    } else if (err.type == DioExceptionType.unknown) {
      throw HttpException(err.message ?? "Unknown error1");
    } else {
      throw HttpException(err.message ?? "Unknown error2");
    }
  }
}
